import 'package:restaurant_api_dicoding/data/model/restauran.dart';

sealed class RestauranDetailResultState {}

class RestauranDetailNoneState extends RestauranDetailResultState {}

class RestauranDetailLoadingState extends RestauranDetailResultState {}

class RestauranDetailErrorState extends RestauranDetailResultState {
  final String error;

  RestauranDetailErrorState(this.error);
}

class RestauranDetailLoadedState extends RestauranDetailResultState {
  final Restauran data;

  RestauranDetailLoadedState(this.data);
}
