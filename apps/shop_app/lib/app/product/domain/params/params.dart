import 'package:shop_app/app/category/domain/entities/tag.dart';
import 'package:shop_app/core/remote/params.dart';

class GetProductParams extends PagingParams {
  GetProductParams({
    this.filter = const ProductsFilter(),
    int page = 1,
    int pageSize = 20,
  }) : super(page: page, pageSize: pageSize);

  final ProductsFilter filter;

  @override
  Map<String, dynamic> toMap() {
    return {
      ...filter.toMap(),
      ...super.toMap(),
    };
  }
}

class ProductsFilter implements IMap {
  final List<Tag> tags;
  final String? search;

  const ProductsFilter({
    this.tags = const [],
    this.search,
  });

  @override
  Map<String, dynamic> toMap() {
    return {
      'tagIds': tags.map((e) => e.id).toList(),
      if (search != null) 'search': search,
    };
  }

  ProductsFilter copyWith({
    List<Tag>? tags,
    String? search,
  }) {
    return ProductsFilter(
      tags: tags ?? this.tags,
      search: search ?? this.search,
    );
  }
}
