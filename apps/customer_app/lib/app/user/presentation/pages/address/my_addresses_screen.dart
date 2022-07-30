import 'package:customer_app/app/user/domain/entities/address.dart';
import 'package:customer_app/app/user/presentation/pages/address/add_address/add_address_screen.dart';
import 'package:customer_app/app/user/presentation/pages/address/provider.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
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
      child: const MyAddressScreen(),
    );
  }

  @override
  State<MyAddressScreen> createState() => _MyAddressScreenState();
}

class _MyAddressScreenState extends State<MyAddressScreen> {
  @override
  initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      context.read<MyAddressProvider>().start();
    });
  }

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    return SafeArea(
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            context.pushNamed(
              AddAddressScreen.name,
            );
          },
          child: const Icon(PIcons.outline_plus),
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
                    provider.start();
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
                              constraints: BoxConstraints(maxWidth: 0.7.sw),
                              icon: const Icon(PIcons.outline_kabab),
                              itemBuilder: (context) => [
                                if (!address.isCurrentLocation)
                                  PopupMenuItem(
                                    onTap: () {
                                      provider.setCurrentAddress(
                                          address, index, context);
                                    },
                                    child: const ListTile(
                                      title: Text('Set as current location'),
                                      leading: Icon(PIcons.outline_check),
                                    ),
                                  ),
                                PopupMenuItem(
                                  onTap: () {
                                    context.pushNamed(
                                      AddAddressScreen.name,
                                      extra: address,
                                    );
                                  },
                                  child: const ListTile(
                                    title: Text('Edit address'),
                                    leading: Icon(PIcons.outline_edit),
                                  ),
                                ),
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
                              ],
                            ),
                            text: address.title,
                            textWidget: Row(
                              children: [
                                Text(
                                  address.title,
                                  style: themeData.textTheme.bodyText1,
                                ),
                                Space.hS1,
                                if (address.isCurrentLocation)
                                  Icon(PIcons.outline_check,
                                      color: context.colorScheme.primary),
                              ],
                            ),
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
