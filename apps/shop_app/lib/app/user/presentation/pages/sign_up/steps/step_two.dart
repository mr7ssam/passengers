import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:map_location_picker/google_map_location_picker.dart';
import 'package:p_design/p_design.dart';
import 'package:shop_app/app/user/presentation/pages/sign_up/steps/step_two_provider.dart';
import 'package:shop_app/common/const/const.dart';

import '../../../../../../generated/locale_keys.g.dart';

class StepTwo extends StatelessWidget {
  const StepTwo({
    Key? key,
    required this.step,
  }) : super(key: key);

  final StepTwoProvider step;

  @override
  Widget build(BuildContext context) {
    return ReactiveForm(
      formGroup: step.form,
      child: Column(
        children: [
          CustomReactiveTextField(
            validationMessages: (control) => {
              ValidationMessage.required: LocaleKeys.validations_full_name.tr(),
            },
            hintText: 'Owner Name',
            prefix: PIcons.outline_profile,
            formControlName: StepTwoProvider.fullNameControllerName,
          ),
          Space.vM2,
          CustomReactiveTextField(
            validationMessages: (control) => {
              ValidationMessage.required:
                  LocaleKeys.validations_business_name.tr(),
            },
            hintText: LocaleKeys.user_sign_up_business_name.tr(),
            prefix: PIcons.outline_shop,
            formControlName: StepTwoProvider.businessNameControllerName,
          ),
          Space.vM2,
          const CustomReactiveTextField(
            hintText: 'Business line address',
            maxLines: 1,
            prefix: PIcons.outline_pin_location,
            formControlName: StepTwoProvider.businessLineAddressControllerName,
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
                      step.locationControl.value = r;
                    }
                  },
                  child: const Text('Tap to pinpoint the exact location')),
            ],
          )
        ],
      ),
    );
  }
}
