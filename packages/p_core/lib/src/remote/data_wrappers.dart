class PagingDataWrapper<T> {
  PagingDataWrapper({required this.data, required this.paging});

  final List<T> data;
  final Paging paging;

  PagingDataWrapper<V> copyWithData<V>({
    required List<V> data,
  }) {
    return PagingDataWrapper<V>(
      data: data,
      paging: paging,
    );
  }

  bool isLastPage() {
    return paging.isLastPage();
  }
}

class Paging {
  Paging(
    this.currentPage,
    this.pageSize,
    this.totalCount,
    this.totalPages,
    this.hasNext,
  );

  final int currentPage;
  final int pageSize;
  final bool hasNext;
  final int totalCount;
  final int totalPages;

  Paging.fromJson(Map<String, dynamic> json)
      : currentPage = json['CurrentPage'],
        pageSize = json['PageSize'],
        hasNext = json['HasNext'],
        totalPages = json['TotalPages'],
        totalCount = json['TotalCount'];

  bool isLastPage() {
    return currentPage == totalPages;
  }
}
