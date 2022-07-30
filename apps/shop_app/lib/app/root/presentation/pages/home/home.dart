import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:p_design/p_design.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/app/product/domain/entities/home_data.dart';
import 'package:shop_app/app/root/presentation/pages/home/provider.dart';
import 'package:shop_app/injection/service_locator.dart';

import '../../../../product/domain/entities/product.dart';
import '../../../../product/presentation/pages/product_details/product_details.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => HomeProvider(si())..fetch(),
      builder: (context, _) {
        final provider = context.watch<HomeProvider>();
        return Padding(
          padding: PEdgeInsets.vertical,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: PEdgeInsets.horizontal,
                child: const YouText.titleLarge('Enjoy the orders '
                    '\n'
                    'notification tone'),
              ),
              Space.vL1,
              Expanded(
                child: RefreshIndicator(
                  onRefresh: () async {
                    provider.fetch();
                  },
                  child: ListView(
                    children: [
                      PageStateBuilder<HomeData>(
                        result: provider.state,
                        error: (error) => SizedBox(
                          height: 1.sh / 2,
                          child: Center(
                            child: APIErrorWidget(exception: error),
                          ),
                        ),
                        success: (data) {
                          if (data.isEmpty) {
                            return SizedBox(
                              height: 0.7.sh,
                              child: const EmptyWidget(
                                title: 'No Products yet!',
                                subTitle: 'Add some products',
                                path: EmptyState.noMeal,
                              ),
                            );
                          }
                          const aspectRatio2 = 2 / 1;
                          const childAspectRatio = 1.2;
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              if (data.topOffers.isNotEmpty) ...[
                                Padding(
                                  padding: PEdgeInsets.listView,
                                  child: const CustomTitle(
                                    label: Text('Top Offers'),
                                    icon: Icon(PIcons.outline_star),
                                  ),
                                ),
                                AspectRatio(
                                  aspectRatio: aspectRatio2,
                                  child: GridView.builder(
                                    padding: PEdgeInsets.horizontal,
                                    scrollDirection: Axis.horizontal,
                                    itemCount: data.topOffers.length,
                                    gridDelegate:
                                        SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 1,
                                      childAspectRatio: childAspectRatio,
                                      mainAxisSpacing: 12.r,
                                      crossAxisSpacing: 12.r,
                                    ),
                                    itemBuilder: (_, index) {
                                      final product = data.topOffers[index];
                                      return ProductCard(
                                        product: product,
                                      );
                                    },
                                  ),
                                ),
                              ],
                              if (data.topProducts.isNotEmpty) ...[
                                Padding(
                                  padding: PEdgeInsets.listView,
                                  child: const CustomTitle(
                                    label: Text('Top Products'),
                                    icon: Icon(PIcons.outline_star),
                                  ),
                                ),
                                AspectRatio(
                                  aspectRatio: aspectRatio2,
                                  child: GridView.builder(
                                    padding: PEdgeInsets.horizontal,
                                    scrollDirection: Axis.horizontal,
                                    itemCount: data.topProducts.length,
                                    gridDelegate:
                                        SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 1,
                                      childAspectRatio: childAspectRatio,
                                      mainAxisSpacing: 12.r,
                                      crossAxisSpacing: 12.r,
                                    ),
                                    itemBuilder: (_, index) {
                                      final product = data.topProducts[index];
                                      return ProductCard(
                                        product: product,
                                      );
                                    },
                                  ),
                                ),
                              ],
                              if (data.popularProducts.isNotEmpty) ...[
                                Padding(
                                  padding: PEdgeInsets.listView,
                                  child: const CustomTitle(
                                    label: Text('Popular Products'),
                                    icon: Icon(PIcons.outline_fire),
                                  ),
                                ),
                                AspectRatio(
                                  aspectRatio: aspectRatio2,
                                  child: GridView.builder(
                                    padding: PEdgeInsets.horizontal,
                                    scrollDirection: Axis.horizontal,
                                    itemCount: data.popularProducts.length,
                                    gridDelegate:
                                        SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 1,
                                      childAspectRatio: childAspectRatio,
                                      mainAxisSpacing: 12.r,
                                      crossAxisSpacing: 12.r,
                                    ),
                                    itemBuilder: (_, index) {
                                      final product = data.topProducts[index];
                                      return ProductCard(
                                        type: ProductCardType.popular,
                                        product: product,
                                      );
                                    },
                                  ),
                                ),
                              ],
                            ],
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class EmptyWidget extends StatelessWidget {
  const EmptyWidget({
    Key? key,
    required this.path,
    required this.title,
    this.subTitle,
  }) : super(key: key);
  final String path;
  final String title;
  final String? subTitle;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(path),
          YouText.bodyLarge(title),
          if (subTitle != null) ...[
            Space.vM1,
            YouText.bodySmall(subTitle!),
          ]
        ],
      ),
    );
  }
}

enum ProductCardType { popular, top }

class ProductCard extends StatelessWidget {
  final Product product;
  final ProductCardType type;

  const ProductCard({
    Key? key,
    required this.product,
    this.type = ProductCardType.top,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final subtitle =
        type == ProductCardType.top ? product.rate : product.buyers;
    final icon =
        type == ProductCardType.top ? PIcons.outline_star : PIcons.outline_cart;
    return GestureDetector(
      onTap: () {
        context.pushNamed(
          ProductDetailsScreen.name,
          extra: product,
          params: {
            'id': product.id,
          },
        );
      },
      child: VerticalCard(
        title: product.name,
        imagePath: product.imagePath,
        subtitle: CustomTitle.small(
            mainAxisAlignment: MainAxisAlignment.center,
            label: Text(subtitle.toString()),
            icon: Icon(icon)),
      ),
    );
  }
}

class VerticalCard extends StatelessWidget {
  const VerticalCard(
      {Key? key, this.imagePath, required this.title, this.subtitle})
      : super(key: key);
  final String? imagePath;
  final String title;
  final Widget? subtitle;

  @override
  Widget build(BuildContext context) {
    String title = this.title;
    if (title.split('\n').length == 1) {
      title = title + '\n';
    }
    return Card(
        clipBehavior: Clip.antiAlias,
        child: Column(
          children: [
            Expanded(
              child: ImageAvatar(
                imagePath: imagePath,
                size: Size.infinite,
                replacement: const Icon(PIcons.outline_leg_chicken),
              ),
            ),
            Center(
              child: Padding(
                padding: REdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    YouText.titleSmall(
                      title,
                      maxLines: 1,
                      textAlign: TextAlign.center,
                      textOverflow: TextOverflow.ellipsis,
                    ),
                    if (subtitle != null) ...[
                      Space.vS2,
                      Center(child: subtitle!),
                    ]
                  ],
                ),
              ),
            ),
          ],
        ));
  }
}
