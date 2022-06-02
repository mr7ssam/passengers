import 'dart:io';

import 'package:duration/duration.dart';
import 'package:duration_picker/duration_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:p_core/p_core.dart';
import 'package:p_design/p_design.dart';
import 'package:provider/provider.dart';
import 'package:reactive_image_picker/image_file.dart';
import 'package:reactive_image_picker/reactive_image_picker.dart';
import 'package:shop_app/app/product/domain/entities/product.dart';
import 'package:shop_app/app/product/presentation/pages/add_new_product/provider.dart';
import 'package:shop_app/injection/service_locator.dart';

import '../../../../category/application/api.dart';
import '../../../../category/domain/entities/tag.dart';

class AddProductScreen extends StatelessWidget {
  const AddProductScreen({Key? key, this.product}) : super(key: key);
  final Product? product;
  static const path = 'add-product';
  static const name = 'add_product_screen';
  static const editPath = 'edit-product';
  static const editName = 'edit_product_screen';

  static Page pageBuilder(BuildContext context, GoRouterState state) {
    return MaterialPage<void>(
      key: state.pageKey,
      child: ChangeNotifierProvider(
          create: (context) => AddProductProvider(
                si(),
                state.extra as Product?,
              ),
          child: AddProductScreen(
            product: state.extra as Product?,
          )),
    );
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.read<AddProductProvider>();
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(provider.isEdit ? 'Edit Product' : 'Add Product'),
        actions: [
          Selector<AddProductProvider, PageState>(
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
      body: ReactiveForm(
        formGroup: provider.formGroup,
        child: Builder(
          builder: (context) {
            return SingleChildScrollView(
              padding: PEdgeInsets.vertical,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Padding(
                    padding: PEdgeInsets.horizontal,
                    child: ReactiveImagePicker(
                      formControl: provider.controls.image,
                      editIcon: const Icon(PIcons.outline_edit),
                      imageBuilder: (image, handleDelete, selectImage) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            AspectRatio(
                              aspectRatio: 1,
                              child: _ImageView(image: image),
                            ),
                            Space.vM1,
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                IconButton(
                                    onPressed: handleDelete,
                                    icon: const Icon(PIcons.outline_delete)),
                                IconButton(
                                    onPressed: selectImage,
                                    icon: const Icon(PIcons.outline_edit)),
                              ],
                            )
                          ],
                        );
                      },
                      deleteIcon: const Icon(PIcons.outline_delete),
                      onBeforeChange: (ctx, image) async {
                        return await _onBeforeChange(image, context);
                      },
                      inputBuilder: (onPressed) => TextButton.icon(
                        onPressed: onPressed,
                        icon: const Icon(PIcons.outline_add_picture),
                        label: const Text('Click to add picture'),
                      ),
                    ),
                  ),
                  Space.vL1,
                  Padding(
                    padding: PEdgeInsets.horizontal,
                    child: const CustomTitle(
                        icon: Icon(PIcons.outline_leg_chicken),
                        label: Text('Select Category')),
                  ),
                  Space.vS3,
                  CustomChipSelect<Tag>(
                    selectedItem: product?.tag,
                    type: CustomChipSelectType.list,
                    asyncItems: () async {
                      final api = si<CategoryApi>();
                      final tags = await api.getShopTags();
                      return tags;
                    },
                    onChanged: (value) {
                      provider.controls.tags.value = value;
                    },
                    itemAsString: (item) => item.name,
                  ),
                  Padding(
                    padding: PEdgeInsets.horizontal,
                    child: Column(
                      children: [
                        Space.vM3,
                        const CustomTitle(
                            icon: Icon(PIcons.outline_details),
                            label: Text('Main Information')),
                        Space.vM1,
                        CustomReactiveTextField(
                          formControl: provider.controls.name,
                          labelText: 'Name',
                        ),
                        Space.vM1,
                        CustomReactiveTextField(
                          formControl: provider.controls.price,
                          labelText: 'Price',
                          suffix: const Text('SYP'),
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                          ],
                          keyboardType: TextInputType.number,
                        ),
                        Space.vM1,
                        CustomReactiveTextField<Duration>(
                          suffix: const Icon(PIcons.outline_time_circle),
                          valueAccessor:
                              ControlValueAccessor<Duration, String>.create(
                                  modelToView: (modelValue) =>
                                      prettyDuration(modelValue!),
                                  valueToModel: (v) {
                                    return Duration.zero;
                                  }),
                          onTap: () async {
                            var resultingDuration = await showDurationPicker(
                              context: context,
                              initialTime: const Duration(minutes: 30),
                            );
                            // if (resultingDuration != null) {
                            provider.controls.duration
                                .updateValue(resultingDuration);
                            //  }
                          },
                          // readOnly: true,
                          formControl: provider.controls.duration,
                          labelText: 'Preparation time',
                        ),
                        Space.vM1,
                        CustomReactiveTextField(
                          formControl: provider.controls.description,
                          labelText: 'Description',
                          keyboardType: TextInputType.multiline,
                          textInputAction: TextInputAction.newline,
                          maxLength: 200,
                        ),
                        Space.vM1,
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Future<ImageFile> _onBeforeChange(
      ImageFile image, BuildContext context) async {
    File? croppedFile = await ImageCropper().cropImage(
      sourcePath: image.image!.path,
      aspectRatioPresets: [
        CropAspectRatioPreset.square,
      ],
      androidUiSettings: AndroidUiSettings(
        toolbarTitle: 'Edit your image profile',
        toolbarColor: Theme.of(context).primaryColor,
        toolbarWidgetColor: Colors.white,
        initAspectRatio: CropAspectRatioPreset.square,
      ),
    );
    if (croppedFile != null) {
      return image.copyWith(image: croppedFile);
    }
    return image.copyWith(image: null);
  }
}

class _ImageView extends StatelessWidget {
  final ImageFile image;

  const _ImageView({Key? key, required this.image}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final imageFile = image.image;
    if (imageFile != null) {
      return Image.file(imageFile, fit: BoxFit.cover);
    }

    final localImage = image.localImage;
    if (localImage != null) {
      final file = File(localImage);
      return Image.memory(file.readAsBytesSync(), fit: BoxFit.cover);
    }

    final imageUrl = image.imageUrl;
    if (imageUrl != null) {
      return Image.network(imageUrl);
    }

    return Container();
  }
}
