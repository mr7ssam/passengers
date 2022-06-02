import 'package:badges/badges.dart';
import 'package:customer_app/app/products/presentation/pages/food_list_page/provider.dart';
import 'package:darq/darq.dart';
import 'package:flutter/material.dart';
import 'package:p_core/p_core.dart';
import 'package:p_design/p_design.dart';
import 'package:provider/provider.dart';

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
          padding: PEdgeInsets.horizontal,
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
                        SliverList(
                          delegate: SliverChildListDelegate(
                            [
                              Space.vM1,
                              ShopsSlider(
                                shops: data.item0,
                              ),
                              Space.vS2,
                              CategoriesSlider(
                                tags: data.item1,
                              ),
                            ],
                          ),
                        ),
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

class ShopsSlider extends StatelessWidget {
  final List<Shop> shops;

  const ShopsSlider({Key? key, required this.shops}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final selectedShop = context
        .select<FoodListPageProvider, Shop?>((value) => value.selectedShop);
    return AspectRatio(
      aspectRatio: 16 / 4,
      child: GridView.builder(
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
            return GestureDetector(
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
                          position:
                              BadgePosition.bottomEnd(bottom: 2.r, end: 2.r),
                          child: Card(
                            margin: EdgeInsets.zero,
                            child: ImageAvatar(imagePath: shop.imagePath),
                          ),
                        ),
                      ),
                    ),
                    Space.vS2,
                    YouText.bodyMedium(shop.name,
                        textOverflow: TextOverflow.ellipsis),
                  ],
                ),
              ),
            );
          }),
    );
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
          final tags = value != null ? [value] : <Tag>[];
        },
        itemAsString: (item) => item.name,
      ),
    );
  }
}
