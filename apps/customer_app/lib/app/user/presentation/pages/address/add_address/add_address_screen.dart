import 'package:customer_app/app/user/domain/entities/address.dart';
import 'package:customer_app/app/user/presentation/pages/address/add_address/provider.dart';
import 'package:customer_app/injection/service_locator.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_place_picker_mb/google_maps_place_picker.dart';
import 'package:map_location_picker/google_map_location_picker.dart';
import 'package:p_core/p_core.dart';
import 'package:p_design/p_design.dart';
import 'package:provider/provider.dart';

class AddAddressScreen extends StatefulWidget {
  const AddAddressScreen({Key? key}) : super(key: key);
  static const path = '/add-address';
  static const name = 'add_address';

  static Page pageBuilder(BuildContext context, GoRouterState state) {
    final Address? address = state.extra as Address?;
    return MaterialPage<void>(
      key: state.pageKey,
      child: ChangeNotifierProvider<AddAddressProvider>(
        create: (context) => AddAddressProvider(si())..init(address),
        child: const AddAddressScreen(),
      ),
    );
  }

  @override
  State<AddAddressScreen> createState() => _AddAddressScreenState();
}

class _AddAddressScreenState extends State<AddAddressScreen> {
  @override
  Widget build(BuildContext context) {
    final provider = context.read<AddAddressProvider>();
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(provider.isEdit ? 'Update Address' : 'Add address'),
          actions: [
            Selector<AddAddressProvider, PageState>(
              selector: (p0, p1) => p1.pageState,
              builder: (_, state, __) {
                final textButton = TextButton.icon(
                  onPressed: () {
                    provider.submitted(context);
                  },
                  label: const Text('Save'),
                  icon: const Icon(PIcons.outline_check),
                );
                return PageStateBuilder(
                  result: state,
                  error: (_) => textButton,
                  init: () => textButton,
                  success: (void data) {
                    return textButton;
                  },
                );
              },
            ),
          ],
        ),
        body: SingleChildScrollView(
          padding: PEdgeInsets.listView,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              CustomReactiveTextField(
                formControl: provider.controls.title,
                labelText: 'Address title',
              ),
              CustomReactiveTextField(
                formControl: provider.controls.building,
                labelText: 'Building name/Street name',
              ),
              CustomReactiveTextField(
                formControl: provider.controls.text,
                labelText: 'Address line',
              ),
              CustomReactiveTextField(
                formControl: provider.controls.phoneNumber,
                labelText: 'Phone number (optional)',
                keyboardType: const TextInputType.numberWithOptions(
                    decimal: false, signed: false),
              ),
              CustomReactiveTextField(
                formControl: provider.controls.note,
                labelText: 'Note (optional)',
              ),
              CustomReactiveTextField<LatLng>(
                formControl: provider.controls.location,
                labelText: 'On map location',
                readOnly: true,
                onTap: () => _onAddAddress(context),
                valueAccessor: ControlValueAccessor.create(
                  modelToView: (model) => model?.toString() ?? '',
                  valueToModel: (_) => null,
                ),
              ),
            ].superJoin(Space.vM1).toList(),
          ),
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
      try {
        final location = await Geolocator.getCurrentPosition(
            desiredAccuracy: LocationAccuracy.lowest,
            timeLimit: const Duration(seconds: 2));
        initPosition = LatLng(location.latitude, location.longitude);
      } catch (e) {
        initPosition = const LatLng(36.2048, 37.1371);
      }

      if (mounted) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) {
              return PlacePicker(
                apiKey: 'AIzaSyA7Brr57aNvZbp8vxe7m2wxJA9k1AyBt_M',
                onPlacePicked: (result) {
                  var location = result.geometry!.location;
                  context.read<AddAddressProvider>().controls.location.value =
                      LatLng(location.lat, location.lng);
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
}
