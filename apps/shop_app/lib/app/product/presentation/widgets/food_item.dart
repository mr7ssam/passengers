import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:p_design/p_design.dart';
import 'package:shop_app/app/product/domain/entities/product.dart';
import 'package:shop_app/app/product/presentation/pages/product_details/product_details.dart';

class FoodMenuItem extends StatelessWidget {
  final Product product;

  const FoodMenuItem({Key? key, required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var subtitleText2 = product.avilable ? 'Available' : 'Not Available';
    return ListTileCard(
      padding: PEdgeInsets.horizontal,
      titleText: product.name,
      subtitleText: subtitleText2,
      subtitle: Row(
        children: [
          Text(
            subtitleText2,
          ),
          Icon(
            product.avilable ? PIcons.outline_check : PIcons.outline_close,
            size: 16.r,
            color: product.avilable ? Colors.green : Colors.red,
          ),
        ],
      ),
      leadingImage: product.imagePath,
      trailing: Column(
        children: [
          YouText.bodyMedium(
            '${product.price} SYP',
            style: TextStyle(
              decoration:
                  product.isHaveDiscount ? TextDecoration.lineThrough : null,
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
      onTap: () {
        context.pushNamed(
          ProductDetailsScreen.name,
          extra: product,
          params: {
            'id': product.id,
          },
        );
      },
    );
  }
}
