import 'package:flutter/material.dart';
import 'dart:convert';

import 'package:string_to_hex/string_to_hex.dart';

Product productFromJson(String str) => Product.fromJson(json.decode(str));

String productToJson(Product data) => json.encode(data.toJson());

class Product {
  final String title;
  final String description;
  final String image;
  final double price;
  List<Color> colors = [Colors.white, Colors.black];
  final String category;
  final double rate;
  final String barcode;

  Product(
      {required this.title,
      required this.price,
      required this.rate,
      this.description = '',
      this.image = '',
      this.colors = const [Colors.white],
      this.category = '',
      this.barcode = ''});

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        title: json["title"],
        price: json["price"],
        rate: json["rate"]?.toDouble(),
      );

  ///Complet fromJson
  // factory Product.fromJson(Map<String, dynamic> json) => Product(
  // title: json["title"],
  // price: json["price"],
  // rate: json["rate"]?.toDouble(),
  // description: json["description"],
  // image: json["image"],
  // colors: List<Color>.from(
  //     json["colors"].map((x) => Color(StringToHex.toColor(x)))),
  // category: json["category"]);

  //Complete toJson
  // Map<String, dynamic> toJson() => {
  //       "title": title,
  //       "description": description,
  //       "image": image,
  //       "price": price,
  //       "colors": List<dynamic>.from(colors.map((x) => x.toString())),
  //       "category": category,
  //       "rate": rate,
  //     };

  Map<String, dynamic> toJson() =>
      {"title": title, "price": price, "rate": rate};
}

final List<Product> products = [
  Product(
    title: "Wireless Headphones",
    description:
        "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Donec massa sapien faucibus et molestie ac feugiat. In massa tempor nec feugiat nisl. Libero id faucibus nisl tincidunt.",
    image: "assets/wireless.png",
    price: 120,
    colors: [
      Colors.black,
      Colors.blue,
      Colors.orange,
    ],
    category: "Headphones",
    rate: 4.8,
  ),
  Product(
    title: "Woman Sweter",
    description:
        "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Donec massa sapien faucibus et molestie ac feugiat. In massa tempor nec feugiat nisl. Libero id faucibus nisl tincidunt.",
    image: "assets/sweet.png",
    price: 120,
    colors: [
      Colors.brown,
      Colors.red,
      Colors.pink,
    ],
    category: "Woman Fashion",
    rate: 4.8,
  ),
  Product(
    title: "Smart Watch",
    description:
        "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Donec massa sapien faucibus et molestie ac feugiat. In massa tempor nec feugiat nisl. Libero id faucibus nisl tincidunt.",
    image: "assets/miband.jpg",
    price: 55,
    colors: [
      Colors.black,
    ],
    category: "Watch",
    rate: 4.8,
  ),
  Product(
    title: "Dresses",
    description:
        "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Donec massa sapien faucibus et molestie ac feugiat. In massa tempor nec feugiat nisl. Libero id faucibus nisl tincidunt.",
    image: "assets/beauty.png",
    price: 125.33,
    colors: [
      Colors.yellowAccent,
    ],
    category: "Cloth",
    rate: 5.8,
  ),
  Product(
      title: "Desodorant Whisky",
      description:
          "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Donec massa sapien faucibus et molestie ac feugiat. In massa tempor nec feugiat nisl. Libero id faucibus nisl tincidunt.",
      image: "assets/beauty.png",
      price: 23.33,
      colors: [
        Colors.yellowAccent,
      ],
      category: "Personal care",
      rate: 1.8,
      barcode: '3509163891083'),
  Product(
      title: "Desodorant Bambu",
      description:
          "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Donec massa sapien faucibus et molestie ac feugiat. In massa tempor nec feugiat nisl. Libero id faucibus nisl tincidunt.",
      image: "assets/shoes.jpg",
      price: 23.33,
      colors: [
        Colors.pink.shade300,
      ],
      category: "Personal care",
      rate: 0.8,
      barcode: '8504000011575'),
  Product(
      title: "Rectal Baseline",
      description:
          "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Donec massa sapien faucibus et molestie ac feugiat. In massa tempor nec feugiat nisl. Libero id faucibus nisl tincidunt.",
      image: "assets/pc.jpg",
      price: 23.33,
      colors: [Colors.blueAccent.shade400, Colors.lightGreenAccent],
      category: "Personal care",
      rate: 1.8,
      barcode: '080196668420'),
  Product(
      title: "Desodorant Axe",
      description:
          "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Donec massa sapien faucibus et molestie ac feugiat. In massa tempor nec feugiat nisl. Libero id faucibus nisl tincidunt.",
      image: "assets/beauty.png",
      price: 23.33,
      colors: [Colors.cyanAccent.shade700, Colors.orangeAccent.shade400],
      category: "Personal care",
      rate: 1.8,
      barcode: '7506306226739'),
];
