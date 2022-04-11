import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:go_router/go_router.dart';
import 'package:p_design/p_design.dart';
import 'package:p_network/p_http_client.dart';
import 'package:reactive_dropdown_search/reactive_dropdown_search.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:shop_app/common/utils.dart';
import 'package:shop_app/features/category/application/facade.dart';
import 'package:shop_app/features/category/domain/entities/category.dart';
import 'package:shop_app/injection/service_locator.dart';

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
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      YouText.labelMedium(state.message),
                      IconButton(
                        icon: const Icon(Icons.refresh),
                        onPressed: () {
                          userInfoBloc.retry();
                        },
                      ),
                    ],
                  ),
                );
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

  void _listener(BuildContext context, UserInfoState state) {
    if (state is UserInfoFailure) {
      final message = state.message;
      dismissAllAndShowError(context, message);
    } else if (state is UserInfoLoading) {
      showLoadingOverLay();
    } else if (state is UserInfoSuccess) {
      EasyLoading.dismiss();
    }
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
            hint: LocaleKeys.user_complete_information_main_category_title.tr(),
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
