import 'package:badges/badges.dart';
import 'package:customer_app/app/products/presentation/pages/food_list_page/provider.dart';
import 'package:customer_app/app/products/presentation/pages/product_details/product_details_screen.dart';
import 'package:darq/darq.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sticky_header/flutter_sticky_header.dart';
import 'package:go_router/go_router.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:p_core/p_core.dart';
import 'package:p_design/p_design.dart';
import 'package:provider/provider.dart';

import '../../../domain/entities/product.dart';
import '../../../domain/entities/shop.dart';
import '../../../domain/entities/tag.dart';

class FoodListPage extends StatelessWidget {
  const FoodListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: PEdgeInsets.title,
          child: const YouText.titleLarge('Products'),
        ),
        Expanded(
          child: Selector<FoodListPageProvider,
              PageState<Tuple2<List<Shop>, List<Tag>>>>(
            selector: (p0, p1) => p1.pageState,
            builder: (context, value, child) {
              return RefreshIndicator(
                onRefresh: () async {
                  context.read<FoodListPageProvider>().fetch();
                },
                child: PageStateBuilder<Tuple2<List<Shop>, List<Tag>>>(
                  result: value,
                  success: (data) {
                    return CustomScrollView(
                      slivers: [
                        SliverAppBar(
                          flexibleSpace: ShopsSlider(
                            shops: data.item0,
                          ),
                          backgroundColor:
                              context.theme.scaffoldBackgroundColor,
                          leading: const SizedBox(),
                          collapsedHeight: 100.h,
                          expandedHeight: 100.h,
                          floating: true,
                          snap: true,
                        ),
                        SliverList(
                          delegate: SliverChildListDelegate(
                            [
                              Space.vS2,
                            ],
                          ),
                        ),
                        SliverStickyHeader(
                          header: Container(
                            color: context.theme.scaffoldBackgroundColor,
                            child: CategoriesSlider(
                              tags: data.item1,
                            ),
                          ),
                          sliver: SliverPadding(
                            padding: PEdgeInsets.horizontal,
                            sliver: PagedSliverGrid<int, Product>(
                                pagingController: context
                                    .read<FoodListPageProvider>()
                                    .pagingController,
                                builderDelegate: PagedChildBuilderDelegate(
                                  itemBuilder: (context, product, index) {
                                    return ProductCard(
                                      product: product,
                                      onTap: () {
                                        context.goNamed(
                                          ProductDetailsScreen.name,
                                          params: {'id': product.id},
                                        );
                                      },
                                    );
                                  },
                                ),
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                        childAspectRatio: 13 / 9,
                                        crossAxisCount: 1,
                                        mainAxisSpacing: 16,
                                        crossAxisSpacing: 16)),
                          ),
                        )
                      ],
                    );
                  },
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

class ProductCard extends StatelessWidget {
  const ProductCard({
    Key? key,
    required this.product,
    required this.onTap,
  }) : super(key: key);
  final Product product;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
              child: Card(
            child: AppNetworkImage(
              url: product.imagePath!,
              fit: BoxFit.cover,
            ),
          )),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(product.name),
                      Space.vS1,
                      IntrinsicHeight(
                        child: Row(
                          children: [
                            CustomTitle.small(
                              label: Text(product.rate.toStringAsFixed(1)),
                              icon: const Icon(PIcons.outline_star),
                            ),
                            VerticalDivider(thickness: 1.r),
                            Row(
                              children: [
                                Text(
                                  product.avilable
                                      ? 'Available'
                                      : 'Not Available',
                                ),
                                Icon(
                                  product.avilable
                                      ? PIcons.outline_check
                                      : PIcons.outline_close,
                                  size: 16.r,
                                  color: product.avilable
                                      ? Colors.green
                                      : Colors.red,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Column(
                  children: [
                    YouText.bodyMedium(
                      '${product.price} SYP',
                      style: TextStyle(
                        decoration: product.discount != null
                            ? TextDecoration.lineThrough
                            : null,
                      ),
                    ),
                    if (product.isHaveDiscount)
                      YouText.bodyMedium(
                        '${product.price! * product.discount!} SYP',
                        style: TextStyle(
                          color: Theme.of(context).primaryColor,
                        ),
                      )
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ShopsSlider extends StatelessWidget {
  final List<Shop> shops;

  const ShopsSlider({Key? key, required this.shops}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final selectedShop = context
        .select<FoodListPageProvider, Shop?>((value) => value.selectedShop);
    return GridView.builder(
        padding: PEdgeInsets.horizontal,
        itemCount: shops.length,
        scrollDirection: Axis.horizontal,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 1,
            crossAxisSpacing: 8.r,
            childAspectRatio: 9 / 7,
            mainAxisSpacing: 8.r),
        itemBuilder: (context, index) {
          final shop = shops[index];
          var colorScheme = context.colorScheme;
          final isSelected = selectedShop == shop;
          return Stack(
            children: [
              AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                curve: Curves.bounceIn,
                decoration: BoxDecoration(
                  color: isSelected ? colorScheme.primaryContainer : null,
                  borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(PRadius.container * 2),
                      bottom: Radius.circular(PRadius.container / 2)),
                ),
              ),
              Center(
                child: GestureDetector(
                  onTap: () {
                    context.read<FoodListPageProvider>().selectShop(shop);
                  },
                  child: Opacity(
                    opacity: isSelected ? 1 : 0.5,
                    child: Column(
                      children: [
                        Flexible(
                          child: AspectRatio(
                            aspectRatio: 1,
                            child: Badge(
                              showBadge: shop.online,
                              toAnimate: true,
                              badgeColor: colorScheme.primary,
                              position: BadgePosition.bottomEnd(
                                  bottom: 2.r, end: 2.r),
                              child: ImageAvatar(imagePath: shop.imagePath),
                            ),
                          ),
                        ),
                        Space.vS2,
                        RPadding(
                          padding: const EdgeInsets.symmetric(horizontal: 2),
                          child: YouText.bodyMedium(shop.name,
                              textOverflow: TextOverflow.ellipsis),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          );
        });
  }
}

class CategoriesSlider extends StatelessWidget {
  final List<Tag> tags;

  const CategoriesSlider({Key? key, required this.tags}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final tags =
        context.select<FoodListPageProvider, List<Tag>?>((value) => value.tags);
    return SizedBox(
      height: 50.h,
      child: CustomChipSelect<Tag>(
        items: tags ?? [],
        isLoading: tags == null,
        type: CustomChipSelectType.list,
        onChanged: (value) {
          context.read<FoodListPageProvider>().selectTag(value);
        },
        itemAsString: (item) => item.name,
      ),
    );
  }
}
