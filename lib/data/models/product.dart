import 'package:flutter/material.dart';
import 'dart:convert';

import 'package:string_to_hex/string_to_hex.dart';
import 'package:uuid/uuid.dart';

Product productFromJson(String str) => Product.fromJson(json.decode(str));

String productToJson(Product data) => json.encode(data.toJson());

class Product {
  String id = '';
  String title;
  String description;
  String image;
  double price;
  List<Color> colors = [Colors.white, Colors.black];
  String category;
  double rate;
  String barcode;

  //Test id
  //1- {
  //    id: f5f34e75-6d71-11ef-bcf5-61ea3649fb87,
  //    title: Desodorant Bambu,
  //    price: 2.53,
  //    rate: 0.8
  // }

  //2- {
  //    id: ef490702-6d70-11ef-8a86-a3583e4301a2,
  //    title: Dresses,
  //    price: 125.33,
  //    rate:
  //    2.0
  //}
  Product(
      {required this.title,
      required this.price,
      required this.rate,
      this.description = '',
      this.image = "assets/no-image.jpg",
      this.colors = const [Colors.white],
      this.category = 'Otros',
      this.barcode = ''})
      : id = title == 'Desodorant Bambu'
            ? '289b56c4-6f15-11ef-b5a0-ddf0880b13b'
            : const Uuid().v1();

  factory Product.fromJson(Map<String, dynamic> json) {
    Product newProduct = Product(
      title: json["title"],
      price: double.parse(json["price"]),
      rate: double.parse(json["rate"]),
    );
    newProduct.id = json["id"];
    return newProduct;
  }
  get barCode => null;

  Map<String, dynamic> toJson() => {
        "id": "${id}",
        "title": "${title}",
        "price": "${price}",
        "rate": "${rate}"
      };

  Product copyWith(
          {String? id,
          String? title,
          String? description,
          String? image,
          double? price,
          List<Color>? colors,
          String? category,
          double? rate,
          String? barcode}) =>
      Product(
          title: title ?? this.title,
          description: description ?? this.description,
          image: image ?? this.image,
          price: price ?? this.price,
          colors: colors ?? this.colors,
          category: category ?? this.category,
          rate: rate ?? this.rate,
          barcode: barcode ?? this.barcode);
}

/**
 *   
 *    Barcode examples with product images
 *      
*        Crema Anal :080196668420
*        Desodorante Whisky: 3509163891083
 *
 */

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
      price: 2.53,
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
      price: 456.67,
      colors: [Colors.blueAccent.shade400, Colors.lightGreenAccent],
      category: "Personal care",
      rate: 1.8,
      barcode: '080196668420'),
  Product(
      title: "Desodorant Axe",
      description:
          "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Donec massa sapien faucibus et molestie ac feugiat. In massa tempor nec feugiat nisl. Libero id faucibus nisl tincidunt.",
      image: "assets/beauty.png",
      price: 5.99,
      colors: [Colors.cyanAccent.shade700, Colors.orangeAccent.shade400],
      category: "Personal care",
      rate: 1.8,
      barcode: '7506306226739'),
];

List<String> itemCategoriesEn = [
  'Electronics',
  'Clothing',
  'Books',
  'Home & Garden',
  'Sports & Outdoors',
  'Beauty & Personal Care',
  'Toys & Games',
  'Automotive',
  'Grocery',
  'Health & Wellness',
  'Pet Supplies',
  'Office Products',
  'Jewelry',
  'Tools & Home Improvement',
  'Baby',
  'Music & Instruments',
  'Others'
];

List<String> itemCategoriesEs = [
  'Electrónicos',
  'Ropas',
  'Libros',
  'Casa & Jardín',
  'Deportes & Entretenimiento',
  'Belleza & Cuidado personal',
  'Juguetes & Juegos',
  'Automotive',
  'Dulces',
  'Salud & Bienestar',
  'Mascotas',
  'Productos de oficina',
  'Joyas',
  'Herramients & Mejoras del hogar',
  'Bebes',
  'Musica & Instrumentos',
  'Otros'
];

List<IconData> categoryIcons = [
  Icons.devices,
  Icons.shopping_bag,
  Icons.book,
  Icons.home,
  Icons.sports_soccer,
  Icons.spa,
  Icons.toys,
  Icons.directions_car,
  Icons.shopping_cart,
  Icons.favorite,
  Icons.pets,
  Icons.work,
  Icons.diamond,
  Icons.build,
  Icons.child_care,
  Icons.music_note,
  Icons.more_horiz,
];
