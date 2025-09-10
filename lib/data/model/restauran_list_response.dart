import 'package:restaurant_api_dicoding/data/model/restauran.dart';

class RestauranListResponse {
  final bool error;
  final String message;
  final int count;
  final List<Restauran> restaurants;

  RestauranListResponse({
    required this.error,
    required this.message,
    required this.count,
    required this.restaurants,
  });

  factory RestauranListResponse.fromJson(Map<String, dynamic> json) {
    return RestauranListResponse(
      error: json["error"],
      message: json["message"],
      count: json["count"],
      restaurants: json["restaurants"] != null
          ? List<Restauran>.from(
              // (json["restaurants"])!.map((x) => Restauran.fromJson(x)),
              (json["restaurants"] as List).map(
                (x) => Restauran.fromJson(x as Map<String, dynamic>),
              ),
            )
          : <Restauran>[],
    );
  }
}
