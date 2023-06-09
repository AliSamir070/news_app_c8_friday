import 'package:flutter/material.dart';

class CategoryModel {
  String id;
  String name;
  String image;
  Color color;

  CategoryModel(this.id, this.name, this.image, this.color);

  static List<CategoryModel> getCategories() {
    return [
      CategoryModel(
          "sports", "Sports", "assets/images/sports.png", Color(0xffC91C22)),
      CategoryModel("technology", "Technology", "assets/images/sports.png",
          Colors.purple),
      CategoryModel("business", "Business", "assets/images/bussines.png",
          Color(0xffCF7E48)),
      CategoryModel("entertainment", "Entertainment",
          "assets/images/environment.png", Colors.blueAccent),
      CategoryModel(
          "general",
          "General",
          "assets/images/science"
              ".png",
          Colors.greenAccent),
      CategoryModel(
          "health", "Health", "assets/images/health.png", Colors.pinkAccent),
      CategoryModel(
          "science", "Science", "assets/images/science.png", Colors.pinkAccent),
    ];
  }
}
