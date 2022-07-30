import 'package:customer_app/app/root/presentation/pages/home/provider.dart';
import 'package:customer_app/app/root/presentation/widgets/page_name_mixin.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:p_design/p_design.dart';
import 'package:provider/provider.dart';

import '../../../../../injection/service_locator.dart';
import '../../../../products/domain/entities/home_data.dart';
import '../../../../products/presentation/pages/food_list_page/food_list_screen.dart';

class HomePage extends StatefulWidget with PageNameMixin {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();

  @override
  String get pageName => 'home';
}

class _HomePageState extends State<HomePage>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
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
                child: const YouText.titleLarge('Your orders'
                    '\n'
                    'knows you well'),
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
                                path: EmptyState.noMeal,
                              ),
                            );
                          }
                          const aspectRatio2 = 3 / 2;
                          const childAspectRatio = 0.8;
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              if (data.newProducts.isNotEmpty) ...[
                                Padding(
                                  padding: PEdgeInsets.listView,
                                  child: const CustomTitle(
                                    label: Text('New products'),
                                    icon: Icon(PIcons.outline_new),
                                  ),
                                ),
                                AspectRatio(
                                  aspectRatio: aspectRatio2,
                                  child: GridView.builder(
                                    padding: PEdgeInsets.horizontal,
                                    scrollDirection: Axis.horizontal,
                                    itemCount: data.newProducts.length,
                                    gridDelegate:
                                        SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 1,
                                      childAspectRatio: childAspectRatio,
                                      mainAxisSpacing: 12.r,
                                      crossAxisSpacing: 12.r,
                                    ),
                                    itemBuilder: (_, index) {
                                      final product = data.newProducts[index];
                                      return ProductCard(
                                        product: product,
                                        type: ProductType.newProduct,
                                      );
                                    },
                                  ),
                                ),
                              ],
                              if (data.newProducts.isNotEmpty) ...[
                                Padding(
                                  padding: PEdgeInsets.listView,
                                  child: const CustomTitle(
                                    label: Text('Suggestion for you'),
                                    icon: Icon(PIcons.outline_lamp),
                                  ),
                                ),
                                AspectRatio(
                                  aspectRatio: aspectRatio2,
                                  child: GridView.builder(
                                    padding: PEdgeInsets.horizontal,
                                    scrollDirection: Axis.horizontal,
                                    itemCount: data.newProducts.length,
                                    gridDelegate:
                                        SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 1,
                                      childAspectRatio: childAspectRatio,
                                      mainAxisSpacing: 12.r,
                                      crossAxisSpacing: 12.r,
                                    ),
                                    itemBuilder: (_, index) {
                                      final product =
                                          data.suggestionProducts[index];
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
                                    label: Text('Popular products'),
                                    icon: Icon(PIcons.outline_leg_chicken),
                                  ),
                                ),
                                AspectRatio(
                                  aspectRatio: aspectRatio2,
                                  child: GridView.builder(
                                    padding: PEdgeInsets.horizontal,
                                    scrollDirection: Axis.horizontal,
                                    itemCount: data.newProducts.length,
                                    gridDelegate:
                                        SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 1,
                                      childAspectRatio: childAspectRatio,
                                      mainAxisSpacing: 12.r,
                                      crossAxisSpacing: 12.r,
                                    ),
                                    itemBuilder: (_, index) {
                                      final product =
                                          data.popularProducts[index];
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
                                    label: Text('Top products'),
                                    icon: Icon(PIcons.outline_star),
                                  ),
                                ),
                                AspectRatio(
                                  aspectRatio: aspectRatio2,
                                  child: GridView.builder(
                                    padding: PEdgeInsets.horizontal,
                                    scrollDirection: Axis.horizontal,
                                    itemCount: data.newProducts.length,
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
                              ]
                            ],
                          );
                        },
                      )
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

  @override
  bool get wantKeepAlive => true;
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
          SvgPicture.asset(
            path,
          ),
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
