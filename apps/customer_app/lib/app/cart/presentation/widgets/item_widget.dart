import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:p_design/p_design.dart';

import '../../../../common/utils.dart';
import '../../domain/entities/cart.dart';
import '../../domain/entities/cart_item.dart';

class ItemWidget extends StatefulWidget {
  const ItemWidget({
    Key? key,
    required this.item,
  }) : super(key: key);

  final ICartItem item;

  @override
  State<ItemWidget> createState() => _ItemWidgetState();
}

class _ItemWidgetState extends State<ItemWidget> {
  late ValueNotifier<int> _count;

  @override
  void initState() {
    super.initState();
    _count = ValueNotifier<int>(widget.item.count);
    _count.addListener(() {
      widget.item.count = _count.value;
      if (_count.value == 0) {
        context.read<Cart>().delete(widget.item);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 86.h,
      child: Row(
        children: [
          ImageAvatar(
            imagePath: buildDocUrl(widget.item.image),
            replacement: const Icon(PIcons.outline_leg_chicken),
          ),
          Expanded(
            child: ListTile(
              minVerticalPadding: 0,
              contentPadding: EdgeInsets.zero,
              title: Padding(
                padding: PEdgeInsets.horizontal / 2,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    YouText.titleSmall(
                      widget.item.itemName,
                      maxLines: 1,
                      textAlign: TextAlign.center,
                      textOverflow: TextOverflow.ellipsis,
                    ),
                    Space.vS2,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Card(
                          child: IconButton(
                            onPressed: () {
                              _count.value += 1;
                            },
                            icon: const Icon(PIcons.outline_plus),
                          ),
                        ),
                        Expanded(
                          child: Center(
                            child: ValueListenableBuilder<int>(
                              valueListenable: _count,
                              builder: (context, value, child) {
                                return YouText.bodyMedium('$value');
                              },
                            ),
                          ),
                        ),
                        Card(
                          child: IconButton(
                            onPressed: () {
                              if (_count.value > 0) _count.value -= 1;
                            },
                            icon: const Icon(PIcons.outline_minus),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
              trailing: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ValueListenableBuilder<int>(
                    valueListenable: _count,
                    builder: (context, value, child) {
                      return YouText.bodyMedium(
                        '${widget.item.itemPrice * value} SYP',
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
  }

  @override
  void dispose() {
    super.dispose();
    _count.dispose();
  }
}
