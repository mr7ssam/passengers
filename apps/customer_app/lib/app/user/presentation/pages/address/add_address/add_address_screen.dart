import 'package:customer_app/app/user/domain/entities/address.dart';
import 'package:customer_app/app/user/presentation/pages/address/add_address/provider.dart';
import 'package:customer_app/app/user/presentation/pages/address/provider.dart';
import 'package:customer_app/injection/service_locator.dart';
import 'package:darq/darq.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:p_core/p_core.dart';
import 'package:p_design/p_design.dart';
import 'package:provider/provider.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import '../../../../../root/presentation/pages/home/home.dart';

class AddAddressScreen extends StatelessWidget {
  const AddAddressScreen({Key? key}) : super(key: key);
  static const path = 'add-address';
  static const name = 'add_address';

  static Page pageBuilder(BuildContext context, GoRouterState state) {
    final params = state.extra as Tuple2<Address?, LatLng>;
    final Address? address = params.item0;
    final LatLng latLng = params.item1;
    return MaterialPage<void>(
      key: state.pageKey,
      child: ChangeNotifierProvider<AddAddressProvider>(
        create: (context) => AddAddressProvider(si())..init(address, latLng),
        child: const AddAddressScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
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
            ].superJoin(Space.vM1).toList(),
          ),
        ),
      ),
    );
  }
}
