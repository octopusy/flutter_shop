import 'package:flutter/material.dart';

class Product {
  String name;
  String image;
  double rating;
  String price;
  double priceNum;
  String brand;
  String description;
  int totalReviews;
  List<String> sizes;
  List<ProductColor> colors;
  int quantity = 0;
  int count = 0;
  bool isChecked = false;

  Product(
      {this.name,
      this.image,
      this.brand,
      this.price,
      this.priceNum,
      this.rating,
      this.description,
      this.totalReviews,
      this.sizes,
      this.colors,
      this.quantity});

  @override
  bool operator ==(other) {

    return other is Product&& other.name==this.name;
  }

}

class ProductColor {
  final String colorName;
  final MaterialColor color;

  ProductColor({this.colorName, this.color});
}