import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class Restauran {
  final String id;
  final String name;
  final String description;
  final String city;
  final String? address; 
  final String pictureId;
  final double rating;
  final Menus? menus; 

  Restauran({
    required this.id,
    required this.name,
    required this.description,
    required this.city,
     this.address,
    required this.pictureId,
    required this.rating,
     this.menus,
  });

  factory Restauran.fromJson(Map<String, dynamic> json) {
    return Restauran(
      id: json["id"] ?? "",
      name: json["name"] ?? "",
      description: json["description"] ?? "",
      city: json["city"] ?? "",
      address: json["address"],
      pictureId: json["pictureId"] ?? "",
      rating: (json["rating"] ?? 0).toDouble(),
      menus: json["menus"] != null ? Menus.fromJson(json["menus"]) : null,
    );
  }
}

class Menus {
  final List<Category> foods;
  final List<Category> drinks;

  Menus({required this.foods, required this.drinks});

  factory Menus.fromJson(Map<String, dynamic> json) {
    return Menus(
      foods: List<Category>.from(json["foods"].map((x) => Category.fromJson(x))),
      drinks: List<Category>.from(json["drinks"].map((x) => Category.fromJson(x))),
    );
  }
}

class Category {
  final String name;
  Category({required this.name});

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(name: json["name"]);
  }
}
