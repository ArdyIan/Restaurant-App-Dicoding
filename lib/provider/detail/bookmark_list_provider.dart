import 'package:flutter/widgets.dart';
import 'package:restaurant_api_dicoding/data/model/restauran.dart';

class BookmarkListProvider extends ChangeNotifier {
  final List<Restauran> _bookmarkList = [];

  List<Restauran> get bookmarkList => _bookmarkList;

  void addBookmark(Restauran value) {
    _bookmarkList.add(value);
    notifyListeners();
  }

  void removeBookmark(Restauran value) {
    _bookmarkList.removeWhere((element) => element.id == value.id);
    notifyListeners();
  }

  bool checkItemBookmark(Restauran value) {
    final restauranInList = _bookmarkList.where(
      (element) => element.id == value.id,
    );
    return restauranInList.isNotEmpty;
  }
}
