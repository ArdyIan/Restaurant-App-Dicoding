import 'package:restaurant_api_dicoding/data/model/restauran.dart';

sealed class RestauranListResultState {}

class RestauranListNoneState extends RestauranListResultState {}

class RestauranListLoadingState extends RestauranListResultState {}

class RestauranListErrorState extends RestauranListResultState {
  final String error;

  RestauranListErrorState(this.error);
}

class RestauranListLoadedState extends RestauranListResultState {
  final List<Restauran> data;

  RestauranListLoadedState(this.data);
}
