import 'package:flutter/cupertino.dart';

class RootManger extends ChangeNotifier {
  RootManger() {
    pageController.addListener(_listener);
  }

  void _listener() {
    pageIndex = pageController.page!.round();
  }

  int _pageIndex = 0;

  final PageController pageController = PageController(initialPage: 0);

  int get pageIndex => _pageIndex;

  set pageIndex(int pageIndex) {
    _pageIndex = pageIndex;
    notifyListeners();
  }

  void jump(int index) {
    pageController.jumpToPage(index);
    pageIndex = index;
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }
}
