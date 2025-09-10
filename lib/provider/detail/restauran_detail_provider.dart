import 'package:flutter/material.dart';
import 'package:restaurant_api_dicoding/data/api/api_service.dart';
import 'package:restaurant_api_dicoding/static/restauran_detail_result_state.dart';

class RestauranDetailProvider extends ChangeNotifier {
  final ApiServices _apiServices;

  RestauranDetailProvider(this._apiServices);

  RestauranDetailResultState _resultState = RestauranDetailNoneState();
  RestauranDetailResultState get resultState => _resultState;

  Future<void> fetchRestauranDetail(String id) async {
    try {
      _resultState = RestauranDetailLoadingState();
      notifyListeners();

      final result = await _apiServices.getRestauranDetail(id);

      if (result.error) {
        _resultState = RestauranDetailErrorState(result.message);
        notifyListeners();
      } else {
        _resultState = RestauranDetailLoadedState(result.restaurant);
        notifyListeners();
      }
    } 
    // on Exception catch (e) {
    //   _resultState = RestauranDetailErrorState(e.toString());
    //   notifyListeners();
    // }
    on Exception catch (e) {
    debugPrint("Error di provider: $e");
    _resultState = RestauranDetailErrorState(e.toString());
    notifyListeners();
  }
  }
}
