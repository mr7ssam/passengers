import 'dart:math';

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:p_network/api_result.dart';
import 'package:shimmer/shimmer.dart';

import '../theme/const.dart';

enum CustomChipSelectType {
  list,
  wrap,
}

class CustomChipSelect<T> extends StatefulWidget {
  final List<T> items;
  final String Function(T item) itemAsString;
  final List<T> selectedItems;
  final T? selectedItem;
  final ValueChanged<T?>? onChanged;
  final ValueChanged<List<T>>? onChangedMulti;
  final CustomChipSelectType type;
  final bool allSelected;
  final Future<ApiResult<List<T>>> Function()? asyncItems;
  final EdgeInsets? padding;
  final bool isMulti;

  const CustomChipSelect({
    Key? key,
    this.items = const [],
    required this.onChanged,
    this.selectedItem,
    required this.itemAsString,
    this.type = CustomChipSelectType.wrap,
    this.allSelected = false,
    this.padding,
    this.asyncItems,
    this.isMulti = false,
  })  : selectedItems = const [],
        onChangedMulti = null,
        super(key: key);

  const CustomChipSelect.multi({
    Key? key,
    this.isMulti = true,
    this.items = const [],
    ValueChanged<List<T>>? onChanged,
    this.selectedItems = const [],
    required this.itemAsString,
    this.type = CustomChipSelectType.wrap,
    this.allSelected = false,
    this.padding,
    this.asyncItems,
  })  : selectedItem = null,
        onChangedMulti = onChanged,
        onChanged = null,
        super(key: key);

  @override
  State<CustomChipSelect> createState() => _CustomChipSelectState<T>();
}

class _CustomChipSelectState<T> extends State<CustomChipSelect<T>> {
  late List<T> _selectedItems;
  Future<ApiResult<List<T>>>? _asyncItems;

  @override
  void initState() {
    _asyncItems = widget.asyncItems?.call();
    _selectedItems = List.from(widget.selectedItems);
    if (widget.selectedItem != null) {
      _selectedItems.add(widget.selectedItem!);
    }
    super.initState();
  }

  RSizedBox _separatorBuilder() => const RSizedBox.horizontal(8);

  Widget _asyncBuilder(AsyncSnapshot<ApiResult<List<T>>> snapshot) {
    if (snapshot.hasData) {
      var data = snapshot.data!;
      if (data.isSuccess) {
        return _build(data.data);
      } else {
        return Text(data.message);
      }
    } else if (snapshot.hasError) {
      return Text(snapshot.error.toString());
    }
    return _shimmerLoading();
  }

  RSizedBox _shimmerLoading() {
    return RSizedBox(
      height: 50,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        separatorBuilder: (context, index) => _separatorBuilder(),
        padding: PEdgeInsets.horizontal,
        itemBuilder: (_, __) => Shimmer.fromColors(
          period: const Duration(milliseconds: 700),
          highlightColor: Colors.grey.shade400,
          baseColor: Colors.grey,
          child: FilterChip(
            onSelected: (value) {},
            label: RSizedBox(
              width: Random().nextInt(20) + 25,
            ),
          ),
        ),
        itemCount: 5,
      ),
    );
  }

  RenderObjectWidget _build(List<T> items) {
    if (widget.type == CustomChipSelectType.list) {
      return RSizedBox(
        height: 50,
        child: ListView.separated(
          padding: PEdgeInsets.horizontal,
          itemCount: items.length,
          scrollDirection: Axis.horizontal,
          separatorBuilder: (_, __) => _separatorBuilder(),
          itemBuilder: (context, index) {
            return _buildFilterChips(index, items);
          },
        ),
      );
    }
    return Wrap(
      spacing: 8.r,
      children: List.generate(
          items.length, (index) => _buildFilterChips(index, items)),
    );
  }

  Widget _buildFilterChips(int index, List<T> items) {
    final item = items[index];
    final selected = _selectedItems.contains(item);
    return ChoiceChip(
      selected: selected,
      onSelected: (value) => _onSelected(value, item, items),
      side: selected ? const BorderSide(color: Colors.transparent) : null,
      label: Text(
        widget.itemAsString(
          item,
        ),
      ),
    );
  }

  void _onSelected(bool value, item, List<T> items) {
    if (!widget.isMulti) {
      _selectedItems.clear();
    }
    if (!value) {
      _selectedItems.remove(item);
    } else {
      _selectedItems.add(item);
    }
    if (widget.isMulti) {
      widget.onChangedMulti?.call(items);
    } else {
      widget.onChanged?.call(_selectedItems.firstOrNull);
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    if (widget.asyncItems != null) {
      return FutureBuilder<ApiResult<List<T>>>(
        future: _asyncItems,
        builder: (context, snapshot) {
          return _asyncBuilder(snapshot);
        },
      );
    }
    return _build(widget.items);
  }
}
