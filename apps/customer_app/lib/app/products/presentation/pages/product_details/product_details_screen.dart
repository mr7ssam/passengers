import 'package:duration/duration.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:p_core/p_core.dart';
import 'package:p_design/p_design.dart';
import 'package:provider/provider.dart';
import 'package:simple_animations/simple_animations.dart';

import '../../../../../common/utils.dart';
import '../../../../../common/widgets/cart_icon.dart';
import '../../../../../injection/service_locator.dart';
import '../../../../cart/domain/entities/cart.dart';
import '../../../domain/entities/product_details.dart';
import 'provider.dart';

class ProductDetailsScreen extends StatelessWidget {
  const ProductDetailsScreen({
    Key? key,
  }) : super(key: key);
  static const path = 'product/:id';
  static const name = 'product';

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
          return Column(
            children: [
              Expanded(
                child: RefreshIndicator(
                  onRefresh: () => provider.loadProduct(),
                  child: CustomScrollView(
                    slivers: [
                      SliverAppBar(
                        expandedHeight: height,
                        actions: [
                          const CartIcon(),
                          IconButton(
                            onPressed: () {},
                            icon: const Icon(
                              PIcons.outline_copy,
                            ),
                          ),
                        ],
                        iconTheme:
                            themeData.iconTheme.copyWith(color: Colors.white),
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
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 2),
                                      child: YouText.titleLarge(data.name),
                                    ),
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        YouText.titleLarge(
                                          '${data.itemPrice} SYP',
                                          key: ValueKey(data.itemPrice),
                                          style: TextStyle(
                                              color: themeData
                                                  .colorScheme.primary),
                                        ),
                                      ],
                                    ),
                                    Padding(
                                      padding: PEdgeInsets.vertical,
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
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
                                            icon:
                                                const Icon(PIcons.outline_star),
                                          ),
                                          CustomTitle.small(
                                            label: Text(prettyDuration(
                                                data.prepareTime)),
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
                                      icon:
                                          const Icon(PIcons.outline_motorcycle),
                                    ),
                                    Space.vM1,
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              AddToCart(
                product: data,
              )
            ],
          );
        },
      ),
    );
  }
}

class AddToCart extends StatefulWidget {
  const AddToCart({
    Key? key,
    required this.product,
  }) : super(key: key);

  final ProductDetails product;

  @override
  State<AddToCart> createState() => _AddToCartState();
}

class _AddToCartState extends State<AddToCart> {
  int _count = 0;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final cart = context.watch<Cart>();
    _count = cart.items[widget.product.id]?.count ?? 0;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: PEdgeInsets.listView,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 250),
            switchInCurve: Curves.elasticInOut,
            switchOutCurve: Curves.elasticInOut,
            transitionBuilder: (child, animation) {
              return FadeTransition(
                opacity: animation,
                child: SlideTransition(
                  position:
                      Tween(begin: const Offset(0, 1), end: const Offset(0, 0))
                          .animate(animation),
                  child: child,
                ),
              );
            },
            child: _count > 0
                ? Row(
                    children: [
                      Expanded(
                        child: Column(
                          children: [
                            const YouText.labelSmall('Total Price'),
                            YouText.bodyMedium(
                                '${widget.product.itemPrice * _count} SYP'),
                          ],
                        ),
                      ),
                      Card(
                        child: IconButton(
                          onPressed: () {
                            setState(() {
                              _count = _count + 1;
                            });
                            _update(context);
                          },
                          icon: const Icon(PIcons.outline_plus),
                        ),
                      ),
                      Expanded(
                        child: Center(
                          child: YouText.bodyMedium('$_count'),
                        ),
                      ),
                      Card(
                        child: IconButton(
                          onPressed: () {
                            setState(() {
                              if (_count > 0) _count = _count - 1;
                            });
                            _update(context);
                          },
                          icon: const Icon(PIcons.outline_minus),
                        ),
                      ),
                    ],
                  )
                : SizedBox(
                    width: double.infinity,
                    child: FilledButton.icon(
                      onPressed: () {
                        setState(() {
                          _count = _count + 1;
                        });
                        _update(context);
                      },
                      icon: const Icon(PIcons.outline_add_bag),
                      label: const Text('Add to cart'),
                    ),
                  ),
          ),
          Space.vM1,
        ],
      ),
    );
  }

  void _update(BuildContext context) {
    context.read<Cart>().add(widget.product..count = _count);
  }
}
