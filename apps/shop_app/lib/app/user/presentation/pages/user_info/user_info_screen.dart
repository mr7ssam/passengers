import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:map_location_picker/google_map_location_picker.dart';
import 'package:p_design/p_design.dart';
import 'package:p_network/p_http_client.dart';
import 'package:reactive_dropdown_search/reactive_dropdown_search.dart';
import 'package:shop_app/app/category/application/facade.dart';
import 'package:shop_app/app/category/domain/entities/category.dart';
import 'package:shop_app/app/product/presentation/pages/food_menu/food_menu_page.dart';
import 'package:shop_app/injection/service_locator.dart';

import '../../../../../common/const/const.dart';
import '../../../../../generated/locale_keys.g.dart';
import 'bloc/user_info_bloc.dart';

class UserInfoScreen extends StatelessWidget {
  const UserInfoScreen({Key? key}) : super(key: key);

  static const path = 'user-info';
  static const name = 'user_info_screen';

  static Page pageBuilder(BuildContext context, GoRouterState state) {
    return MaterialPage<void>(
      key: state.pageKey,
      child: BlocProvider<UserInfoBloc>(
        create: (context) => UserInfoBloc(si())..add(UseInfoStarted()),
        child: const UserInfoScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final userInfoBloc = context.read<UserInfoBloc>();
    return Scaffold(
      appBar: PAppBar(
        title: 'Personal Info',
        actions: [
          TextButton.icon(
            icon: const Icon(PIcons.outline_check),
            onPressed: () {
              context.read<UserInfoBloc>().add(UseInfoSubmitted());
            },
            label: const Text('Save'),
          ),
        ],
      ),
      body: ReactiveForm(
        formGroup: userInfoBloc.form,
        child: Builder(
          builder: (context) => BlocBuilder<UserInfoBloc, UserInfoState>(
            builder: (context, state) {
              if (state is UserInfoLoading) {
                return const AppLoading();
              } else if (state is UserInfoFailure) {
                return APIErrorWidget(exception: state.exception);
              }
              return SingleChildScrollView(
                padding: PEdgeInsets.horizontal,
                child: Column(
                  children: [
                    Space.vL1,
                    const CustomTitle(
                        icon: Icon(PIcons.outline_shop),
                        label: Text('Main information')),
                    Space.vM1,
                    const CategoriesDropdown(),
                    Space.vM1,
                    CustomReactiveTextField(
                      validationMessages: (control) => {
                        ValidationMessage.required:
                            LocaleKeys.validations_business_name.tr(),
                      },
                      hintText: 'Shop name',
                      prefix: PIcons.outline_shop,
                      formControlName: UserInfoBloc.shopNameControlName,
                    ),
                    Space.vM1,
                    const CustomReactiveTextField(
                      hintText: 'Business line address',
                      maxLines: 1,
                      prefix: PIcons.outline_pin_location,
                      formControlName:
                          UserInfoBloc.businessLineAddressControllerName,
                    ),
                    Space.vM2,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        TextButton(
                            onPressed: () async {
                              final r = await showLocationPicker(
                                context,
                                kGoogleMapKey,
                                initialCenter: const LatLng(36.2021, 37.1343),
                                myLocationButtonEnabled: true,
                                layersButtonEnabled: true,
                              );
                              if (r != null) {
                                userInfoBloc.locationControl.value = r;
                              }
                            },
                            child: const Text(
                                'Tap to pinpoint the exact location')),
                      ],
                    ),
                    Space.vL1,
                    const CustomTitle(
                        icon: Icon(PIcons.outline_info_circle),
                        label: Text('Contact information')),
                    Space.vM1,
                    CustomReactiveTextField(
                      validationMessages: (control) => {
                        ValidationMessage.required:
                            LocaleKeys.validations_phone_number.tr(),
                      },
                      keyboardType: const TextInputType.numberWithOptions(
                        decimal: false,
                        signed: false,
                      ),
                      hintText: 'Enter phone number',
                      prefix: PIcons.outline_phone,
                      formControlName: UserInfoBloc.phoneNumberControlName,
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

class CategoriesDropdown extends StatefulWidget {
  const CategoriesDropdown({
    Key? key,
  }) : super(key: key);

  @override
  State<CategoriesDropdown> createState() => _CategoriesDropdownState();
}

class _CategoriesDropdownState extends State<CategoriesDropdown> {
  final _f = si<CategoryFacade>().getAll();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<ApiResult<List<Category>>>(
      future: _f,
      builder: (context, snapshot) {
        final loading = snapshot.connectionState == ConnectionState.waiting;

        final categories = snapshot.data?.maybeWhen(
          orElse: () => null,
          success: (data) => data,
        );
        return IgnorePointer(
          ignoring: loading,
          child: ReactiveDropdownSearch<Category, Category>(
            validationMessages: (control) => {
              ValidationMessage.required: LocaleKeys.validations_password.tr(),
            },
            hint: LocaleKeys.user_complete_information_business_type_title.tr(),
            decoration: InputDecoration(
                prefixIcon: loading
                    ? const SizedBox.shrink(child: AppLoading())
                    : const Icon(PIcons.outline_categories),
                contentPadding: REdgeInsets.symmetric(
                  horizontal: 8,
                )),
            searchFieldProps: TextFieldProps(
                decoration: InputDecoration(
              prefixIcon: const Icon(
                PIcons.outline_search,
              ),
              hintText: LocaleKeys.general_search.tr(),
            )),
            mode: Mode.BOTTOM_SHEET,
            showSearchBox: true,
            formControlName: UserInfoBloc.categoriesControlName,
            items: categories,
            itemAsString: (c) => c!.name,
          ),
        );
      },
    );
  }
}
