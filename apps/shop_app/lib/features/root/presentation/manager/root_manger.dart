import 'package:flutter/cupertino.dart';

class RootManger extends ChangeNotifier {
  RootManger() {
    pageController.addListener(_listener);
  }

  void _listener() {
    pageIndex = pageController.page!.toInt();
  }

  int _pageIndex = 0;

  final PageController pageController = PageController(initialPage: 1);

  int get pageIndex => _pageIndex;

  set pageIndex(int pageIndex) {
    _pageIndex = pageIndex;
    notifyListeners();
  }

  void jump(int index) {
    pageController.jumpToPage(index);
    pageIndex=index;
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }
}
