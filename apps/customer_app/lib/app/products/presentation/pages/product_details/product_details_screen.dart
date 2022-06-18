import 'package:duration/duration.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:p_core/p_core.dart';
import 'package:p_design/p_design.dart';
import 'package:provider/provider.dart';
import 'package:simple_animations/simple_animations.dart';

import '../../../../../common/utils.dart';
import '../../../../../injection/service_locator.dart';
import '../../../domain/entities/product_details.dart';
import 'provider.dart';

class ProductDetailsScreen extends StatelessWidget {
  const ProductDetailsScreen({
    Key? key,
  }) : super(key: key);
  static const path = 'product-details/:id';
  static const name = 'product_details';

  static Page pageBuilder(BuildContext context, GoRouterState state) {
    return MaterialPage<void>(
      key: state.pageKey,
      child: ChangeNotifierProvider(
        create: (context) => ProductDetailsProvider(
          si(),
          state.params['id'] as String,
        )..loadProduct(),
        child: const ProductDetailsScreen(),
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
                                  YouText.titleLarge(
                                    '${data.price} SYP',
                                    key: ValueKey(data.price),
                                    style: TextStyle(
                                        color: themeData.colorScheme.primary),
                                  ),
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
                                      label: Text(
                                        data.available
                                            ? 'Available'
                                            : 'Not Available',
                                      ),
                                      icon: Icon(
                                        data.available
                                            ? PIcons.outline_check
                                            : PIcons.outline_close,
                                        size: 16.r,
                                        color: data.available
                                            ? Colors.green
                                            : Colors.red,
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
                              Space.vM1,
                              CustomTitle.small(
                                label: YouText.bodyMedium(
                                  'Delivery Available',
                                  style: TextStyle(
                                      color: context.colorScheme.primary),
                                ),
                                icon: const Icon(PIcons.outline_motorcycle),
                              ),
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
}
