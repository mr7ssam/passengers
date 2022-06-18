import 'package:customer_app/app/user/domain/entities/address.dart';
import 'package:customer_app/app/user/presentation/pages/address/add_address/add_address_screen.dart';
import 'package:customer_app/app/user/presentation/pages/address/provider.dart';
import 'package:customer_app/injection/service_locator.dart';
import 'package:darq/darq.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_place_picker_mb/google_maps_place_picker.dart';
import 'package:map_location_picker/google_map_location_picker.dart';
import 'package:p_core/p_core.dart';
import 'package:p_design/p_design.dart';
import 'package:provider/provider.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import '../../../../root/presentation/pages/home/home.dart';

class MyAddressScreen extends StatefulWidget {
  const MyAddressScreen({Key? key}) : super(key: key);
  static const path = 'my-address';
  static const name = 'my_address';

  static Page pageBuilder(BuildContext context, GoRouterState state) {
    return MaterialPage<void>(
      key: state.pageKey,
      child: ChangeNotifierProvider<MyAddressProvider>(
        create: (context) => MyAddressProvider(si())..init(),
        child: const MyAddressScreen(),
      ),
    );
  }

  @override
  State<MyAddressScreen> createState() => _MyAddressScreenState();
}

class _MyAddressScreenState extends State<MyAddressScreen> {
  final ValueNotifier<bool> _loadingCurrentLocation = ValueNotifier(false);

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    return SafeArea(
      child: Scaffold(
        floatingActionButton: ValueListenableBuilder<bool>(
          valueListenable: _loadingCurrentLocation,
          builder: (context, loading, child) => FloatingActionButton(
            onPressed: loading ? null : () => _onAddAddress(context),
            child: loading
                ? AppLoading(
                    color: themeData.colorScheme.onPrimary,
                  )
                : const Icon(PIcons.outline_plus),
          ),
        ),
        appBar: AppBar(),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Space.vL1,
            Padding(
              padding: PEdgeInsets.horizontal,
              child: const YouText.titleLarge('My Address'),
            ),
            Expanded(
              child: Consumer<MyAddressProvider>(
                  builder: (context, provider, child) {
                return RefreshIndicator(
                  onRefresh: () async {
                    provider.init();
                  },
                  child: StreamBuilder<List<Address>?>(
                    stream: provider.stream,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const AppLoading();
                      } else if (snapshot.hasError) {
                        return APIErrorWidget(
                          exception: snapshot.error! as AppException,
                        );
                      } else if (snapshot.data == null ||
                          snapshot.data!.isEmpty) {
                        return const EmptyWidget(
                          path: EmptyState.noAddress,
                          title: 'No addresses yet!',
                        );
                      }
                      final addresses = snapshot.data!;
                      return ListView.separated(
                        padding: PEdgeInsets.listView +
                            PEdgeInsets.bottomFloatBuffer,
                        itemBuilder: (context, index) {
                          final address = addresses[index];
                          return CustomListTile(
                            trilling: PopupMenuButton(
                              icon: const Icon(PIcons.outline_kabab),
                              itemBuilder: (context) => [
                                PopupMenuItem(
                                  onTap: () async {
                                    await _onDeletePressed(
                                      context,
                                      themeData,
                                      provider,
                                      address,
                                    );
                                  },
                                  child: const ListTile(
                                    title: Text('Delete'),
                                    leading: Icon(PIcons.outline_delete),
                                  ),
                                ),
                                PopupMenuItem(
                                  onTap: () {
                                    context.goNamed(
                                      AddAddressScreen.name,
                                      extra: Tuple2(
                                          address,
                                          LatLng(double.parse(address.lat),
                                              double.parse(address.lng))),
                                    );
                                  },
                                  child: const ListTile(
                                    title: Text('Edit address'),
                                    leading: Icon(PIcons.outline_edit),
                                  ),
                                ),
                              ],
                            ),
                            text: address.title,
                            children: <Widget>[
                              const SizedBox.shrink(),
                              CustomTitle(
                                label: Text(address.text),
                                icon: const Icon(PIcons.outline_pin_location),
                              ),
                              CustomTitle(
                                label: Text(address.building),
                                icon: const Icon(PIcons.outlin_street_number),
                              ),
                              if (address.phoneNumber != null)
                                CustomTitle(
                                  label: Text(address.phoneNumber!),
                                  icon: const Icon(PIcons.outline_phone),
                                ),
                              if (address.note != null)
                                CustomTitle(
                                  label: Text(address.note!),
                                  icon: const Icon(PIcons.outline_edit),
                                ),
                            ].superJoin(Space.vM1).toList(),
                          );
                        },
                        separatorBuilder: (_, __) => Space.vM1,
                        itemCount: addresses.length,
                      );
                    },
                  ),
                );
              }),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _onAddAddress(BuildContext context) async {
    LocationPermission permission = await Geolocator.checkPermission();
    if ((permission == LocationPermission.denied)) {
      permission = await Geolocator.requestPermission();
    }
    if ((permission == LocationPermission.deniedForever)) {
      await Geolocator.openAppSettings();
      return;
    }
    if (!(permission == LocationPermission.denied)) {
      late LatLng initPosition;
      _loadingCurrentLocation.value = true;
      try {
        final location = await Geolocator.getCurrentPosition(
            desiredAccuracy: LocationAccuracy.lowest,
            timeLimit: const Duration(seconds: 5));
        initPosition = LatLng(location.latitude, location.longitude);
      } catch (e) {
        initPosition = const LatLng(36.2048, 37.1371);
      }
      _loadingCurrentLocation.value = false;

      if (mounted) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) {
              return PlacePicker(
                apiKey: 'AIzaSyA7Brr57aNvZbp8vxe7m2wxJA9k1AyBt_M',
                onPlacePicked: (result) {
                  var location = result.geometry!.location;
                  context.goNamed(
                    AddAddressScreen.name,
                    extra: Tuple2(null, LatLng(location.lat, location.lng)),
                  );
                  Navigator.of(context).pop();
                },
                initialPosition: initPosition,
                useCurrentLocation: true,
              );
            },
          ),
        );
      }
    }
  }

  Future<void> _onDeletePressed(BuildContext context, ThemeData themeData,
      MyAddressProvider provider, Address address) async {
    Future.delayed(Duration.zero, () async {
      await AwesomeDialog(
        context: context,
        dialogType: DialogType.WARNING,
        title: 'Delete address',
        desc: 'Are you sure you want to delete this address?',
        btnCancelColor: themeData.primaryColor,
        btnOk: OutlinedButton(
          child: const Text('Delete'),
          onPressed: () {
            provider.deleteAddress(address, context);
          },
        ),
        btnCancel: FilledButton(
          child: const Text('Cancel'),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ).show();
    });
  }
}
