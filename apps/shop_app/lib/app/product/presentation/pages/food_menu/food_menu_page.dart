import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:p_core/p_core.dart';
import 'package:p_design/p_design.dart';
import 'package:shop_app/app/category/domain/entities/tag.dart';
import 'package:shop_app/app/product/domain/entities/product.dart';
import 'package:shop_app/app/product/presentation/pages/add_new_product/add_new_product_screen.dart';
import 'package:shop_app/app/root/presentation/pages/home/home.dart';
import 'package:shop_app/injection/service_locator.dart';

import '../../../../category/application/api.dart';
import '../../widgets/food_item.dart';
import 'bloc/food_menu_bloc.dart';

class FoodMenuPage extends StatelessWidget {
  const FoodMenuPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: const Icon(PIcons.outline_plus),
        onPressed: () {
          context.goNamed(AddProductScreen.name);
        },
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: PEdgeInsets.horizontal,
            child: const YouText.titleLarge('Food Menu'),
          ),
          Space.vM1,
          Padding(
            padding: PEdgeInsets.horizontal,
            child: CustomReactiveTextField(
              dense: true,
              contentPadding: EdgeInsets.zero,
              formControl: context.read<FoodMenuBloc>().formControl,
              prefix: PIcons.outline_search,
              hintText: 'Search for products',
            ),
          ),
          Space.vM1,
          CustomChipSelect<Tag>(
            type: CustomChipSelectType.list,
            asyncItems: () async {
              final api = si<CategoryApi>();
              return api.getShopTags();
            },
            onChanged: (value) {
              final tags = value != null ? [value] : <Tag>[];
              context.read<FoodMenuBloc>().add(FoodMenuTagsChanged(tags: tags));
            },
            itemAsString: (item) => item.name,
          ),
          Space.vM1,
          Expanded(
            child: Builder(
              builder: (context) {
                final bloc = context.read<FoodMenuBloc>();
                return RefreshIndicator(
                  onRefresh: () async => bloc.pagingController.refresh(),
                  child: PagedListView<int, Product>.separated(
                    separatorBuilder: (context, index) => Space.vM1,
                    pagingController: bloc.pagingController,
                    builderDelegate: PagedChildBuilderDelegate(
                      noItemsFoundIndicatorBuilder: (context) {
                        final search = context
                                .read<FoodMenuBloc>()
                                .state
                                .filter
                                .search
                                ?.trim()
                                .isNotEmpty ??
                            false;
                        return EmptyWidget(
                          path: EmptyState.noMeal,
                          title: !search ? 'No products yet!' : 'Oops!',
                          subTitle: !search
                              ? 'Add new product to start'
                              : 'No matches',
                        );
                      },
                      firstPageErrorIndicatorBuilder: (context) {
                        final error = bloc.pagingController.error as Failure;
                        return APIErrorWidget(exception: error.exception);
                      },
                      itemBuilder: (context, item, index) {
                        return FoodMenuItem(
                          product: item.copyWith(
                            index: index,
                          ),
                        );
                      },
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
