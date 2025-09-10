import 'package:restaurant_api_dicoding/data/model/restauran.dart';

class RestauranDetailResponse {
  final bool error;
  final String message;
  final Restauran restaurant;

  RestauranDetailResponse({
    required this.error,
    required this.message,
    required this.restaurant,
  });

  factory RestauranDetailResponse.fromJson(Map<String, dynamic> json) {
    return RestauranDetailResponse(
      error: json["error"] as bool,
      message: json["message"] as String,
      restaurant: Restauran.fromJson(json["restaurant"]),
    );
  }
}
