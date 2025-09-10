import 'dart:convert';

import 'package:restaurant_api_dicoding/data/model/restauran_list_response.dart';
import 'package:restaurant_api_dicoding/data/model/restauran_detail_response.dart';
import 'package:http/http.dart' as http;

class ApiServices {
  static const String _baseUrl = "https://restaurant-api.dicoding.dev";

  Future<RestauranListResponse> getRestauranList() async {
    final response = await http.get(Uri.parse("$_baseUrl/list"));

    if (response.statusCode == 200) {
      return RestauranListResponse.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load restaurant list');
    }
  }

  Future<RestauranDetailResponse> getRestauranDetail(String id) async {
    final response = await http.get(Uri.parse("$_baseUrl/detail/$id"));

    if (response.statusCode == 200) {
      return RestauranDetailResponse.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load restaurant detail');
    }
  }
}
