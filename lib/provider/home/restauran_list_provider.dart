import 'package:flutter/material.dart';
import 'package:restaurant_api_dicoding/data/api/api_service.dart';
import 'package:restaurant_api_dicoding/static/restauran_list_result_state.dart';

class RestauranListProvider extends ChangeNotifier {
  final ApiServices _apiServices;

  RestauranListProvider(this._apiServices);

  RestauranListResultState _resultState = RestauranListNoneState();

  RestauranListResultState get resultState => _resultState;

  Future<void> fetchRestauranList() async {
    try {
      _resultState = RestauranListLoadingState();
      notifyListeners();

      final result = await _apiServices.getRestauranList();

      if (result.error) {
        _resultState = RestauranListErrorState(result.message);
        notifyListeners();
      } else {
        _resultState = RestauranListLoadedState(result.restaurants);
        notifyListeners();
      }
    } on Exception catch (e) {
      _resultState = RestauranListErrorState(e.toString());
      notifyListeners();
    }
  }
}
