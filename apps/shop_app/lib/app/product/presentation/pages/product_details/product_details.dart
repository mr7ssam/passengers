import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:duration/duration.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:p_core/p_core.dart';
import 'package:p_design/p_design.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/app/product/presentation/pages/add_new_product/add_new_product_screen.dart';
import 'package:shop_app/app/product/presentation/pages/product_details/provider.dart';
import 'package:shop_app/common/utils.dart';
import 'package:shop_app/injection/service_locator.dart';
import 'package:simple_animations/simple_animations.dart';

import '../../../domain/entities/product.dart';
import '../../../domain/entities/product_details.dart';

class ProductDetailsScreen extends StatelessWidget {
  const ProductDetailsScreen({
    Key? key,
    required this.product,
  }) : super(key: key);
  final Product product;
  static const path = 'product-details/:id';
  static const name = 'product_details';

  static Page pageBuilder(BuildContext context, GoRouterState state) {
    return MaterialPage<void>(
      key: state.pageKey,
      child: ChangeNotifierProvider(
        create: (context) => ProductDetailsProvider(
          si(),
          state.extra as Product,
        )..loadProduct(),
        child: ProductDetailsScreen(product: state.extra as Product),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final query = MediaQuery.of(context);
    final width = query.size.width;
    final height = width;
    final provider = context.watch<ProductDetailsProvider>();
    return Scaffold(
      body: PageStateBuilder<ProductDetails>(
        result: provider.pageState,
        success: (data) {
          final themeData = Theme.of(context);
          return RefreshIndicator(
            onRefresh: () => provider.loadProduct(),
            child: CustomScrollView(
              slivers: [
                SliverAppBar(
                  actions: [
                    PopupMenuButton<String>(
                      icon: const Icon(
                        PIcons.outline_kabab,
                      ),
                      itemBuilder: (_) => [
                        PopupMenuItem(
                          onTap: () {
                            context.pushNamed(
                              AddProductScreen.editName,
                              extra: product.copyWith(
                                tag: data.tag,
                                price: data.price,
                                prepareTime: data.prepareTime,
                                description: data.description,
                              ),
                              params: {'id': product.id},
                            );
                          },
                          child: const ListTile(
                            title: Text('Edit'),
                            leading: Icon(PIcons.outline_edit),
                          ),
                        ),
                        PopupMenuItem(
                          onTap: () async {
                            Future.delayed(Duration.zero, () async {
                              await AwesomeDialog(
                                context: context,
                                dialogType: DialogType.WARNING,
                                title: 'Delete product',
                                desc:
                                    'Are you sure you want to delete this product?',
                                btnCancelColor: themeData.primaryColor,
                                btnOk: OutlinedButton(
                                  child: const Text('Delete'),
                                  onPressed: () {
                                    provider.deleteProduct(context);
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
                          },
                          child: const ListTile(
                            title: Text('Delete'),
                            leading: Icon(PIcons.outline_delete),
                          ),
                        ),
                      ],
                    ),
                  ],
                  expandedHeight: height,
                  iconTheme: themeData.iconTheme.copyWith(color: Colors.white),
                  flexibleSpace: FlexibleSpaceBar(
                    background: Stack(
                      fit: StackFit.expand,
                      children: [
                        AppNetworkImage(
                          url: buildDocUrl(data.imagePath!)!,
                        ),
                        Container(
                          decoration: const BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                                Colors.black38,
                                Colors.transparent,
                                Colors.transparent,
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SliverPadding(
                  padding: PEdgeInsets.listView,
                  sliver: SliverList(
                    delegate: SliverChildListDelegate(
                      [
                        PlayAnimation<Offset>(
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.easeOutCirc,
                          tween: Tween<Offset>(
                            begin: const Offset(0, -0.5),
                            end: const Offset(0, 0),
                          ),
                          builder: (context, child, animation) =>
                              FractionalTranslation(
                                  translation: animation, child: child),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              YouText.bodySmall(data.tag.name),
                              RPadding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 2),
                                child: YouText.titleLarge(data.name),
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  AnimatedSwitcher(
                                    duration: const Duration(milliseconds: 300),
                                    child: YouText.titleLarge(
                                      '${data.price} SYP',
                                      key: ValueKey(data.price),
                                      style: TextStyle(
                                          color: themeData.colorScheme.primary),
                                    ),
                                  ),
                                  IconButton(
                                    onPressed: () {
                                      _onEditPricePressed(
                                          context, data.price.toString());
                                    },
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 4),
                                    constraints: const BoxConstraints(
                                        minHeight: 0, minWidth: 0),
                                    icon: const Icon(PIcons.outline_edit),
                                  )
                                ],
                              ),
                              Padding(
                                padding: PEdgeInsets.vertical,
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    CustomTitle.small(
                                      label: const Text('Availability'),
                                      icon: SizedBox.square(
                                        dimension: 20.r,
                                        child: Checkbox(
                                          tristate: true,
                                          visualDensity: VisualDensity.compact,
                                          onChanged: (value) {
                                            provider
                                                .updateAvailability(context);
                                          },
                                          value: data.available,
                                        ),
                                      ),
                                    ),
                                    CustomTitle.small(
                                      label: Text(
                                          '${data.rateDegree} (${data.rateNumber})'),
                                      icon: const Icon(PIcons.outline_star),
                                    ),
                                    CustomTitle.small(
                                      label: Text(
                                          prettyDuration(data.prepareTime)),
                                      icon: const Icon(
                                          PIcons.outline_time_square),
                                    ),
                                  ],
                                ),
                              ),
                              YouText.bodySmall(data.description!),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  void _onEditPricePressed(BuildContext context, String price) {
    final control = FormControl(
        validators: [Validators.required], value: double.parse(price).toInt());
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (_) {
        return BottomSheetWrapperWidget(
          title: 'Edit price',
          children: [
            Space.vL1,
            CustomReactiveTextField(
              labelText: 'Price',
              hintText: 'Enter the new price',
              formControl: control,
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
              ],
              keyboardType: const TextInputType.numberWithOptions(
                signed: false,
                decimal: false,
              ),
            ),
            Space.vM2,
            Row(
              children: [
                Expanded(
                  child: TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text('Cancel'),
                  ),
                ),
                Expanded(
                  child: FilledButton(
                    onPressed: () {
                      control.unfocus();
                      if (control.isValid()) {
                        context
                            .read<ProductDetailsProvider>()
                            .updatePrice(control.value.toString(), context);
                      }
                    },
                    child: const Text('Edit'),
                  ),
                )
              ],
            ),
          ],
        );
      },
    );
  }
}
