import 'package:flutter/widgets.dart';

class IndexNavProvider extends ChangeNotifier {
  int _indexBottomNavbar = 0;

  int get indexBottomNavBar => _indexBottomNavbar;

  set setIndexBottomNavBar(int value) {
    _indexBottomNavbar = value;
    notifyListeners();
  }
}
