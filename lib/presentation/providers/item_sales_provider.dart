import 'package:flutter/material.dart';
import 'dart:math';

import 'package:pos_inoidsoft_app/data/models/product.dart';
import 'package:random_name_generator/random_name_generator.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:uuid/uuid.dart';

part 'item_sales_provider.g.dart';

const uuid = Uuid();

enum FilterType { all, completed, pending }

@riverpod
class ItemSalesCurrentFilter extends _$ItemSalesCurrentFilter {
  @override
  FilterType build() => FilterType.all;

  void changeCurrentFilter(FilterType newFilter) {
    state = newFilter;
  }
}

@Riverpod(keepAlive: true)
class SelectedProduct extends _$SelectedProduct {
  @override
  Product build() => Product(
      title: '',
      description: '',
      image: '',
      price: 0,
      colors: [],
      category: '',
      rate: 0);

  void setProduct(Product newProduct) {
    state = newProduct;
  }
}

@Riverpod(keepAlive: true)
class ItemSales extends _$ItemSales {
  @override
  List<Product> build() {
    // return [
    //   Product(
    //       title: RandomNames(Zone.spain).fullName(),
    //       description: RandomNames(Zone.spain).fullName(),
    //       image: '',
    //       price: Random(345).nextDouble(),
    //       colors: List.empty()..addAll([Colors.red, Colors.green, Colors.blue]),
    //       category: RandomNames(Zone.spain).fullName(),
    //       rate: Random(345).nextDouble()),
    //   Product(
    //       title: RandomNames(Zone.spain).fullName(),
    //       description: RandomNames(Zone.spain).fullName(),
    //       image: '',
    //       price: Random(345).nextDouble(),
    //       colors: List.empty()..addAll([Colors.red, Colors.green, Colors.blue]),
    //       category: RandomNames(Zone.spain).fullName(),
    //       rate: Random(345).nextDouble()),
    //   Product(
    //       title: RandomNames(Zone.spain).fullName(),
    //       description: RandomNames(Zone.spain).fullName(),
    //       image: '',
    //       price: Random(345).nextDouble(),
    //       colors: List.empty()..addAll([Colors.red, Colors.green, Colors.blue]),
    //       category: RandomNames(Zone.spain).fullName(),
    //       rate: Random(345).nextDouble()),
    //   Product(
    //       title: RandomNames(Zone.spain).fullName(),
    //       description: RandomNames(Zone.spain).fullName(),
    //       image: '',
    //       price: Random(345).nextDouble(),
    //       colors: List.empty()..addAll([Colors.red, Colors.green, Colors.blue]),
    //       category: RandomNames(Zone.spain).fullName(),
    //       rate: Random(345).nextDouble()),
    //   Product(
    //       title: RandomNames(Zone.spain).fullName(),
    //       description: RandomNames(Zone.spain).fullName(),
    //       image: '',
    //       price: Random(345).nextDouble(),
    //       colors: List.empty()..addAll([Colors.red, Colors.green, Colors.blue]),
    //       category: RandomNames(Zone.spain).fullName(),
    //       rate: Random(345).nextDouble()),
    //   Product(
    //       title: RandomNames(Zone.spain).fullName(),
    //       description: RandomNames(Zone.spain).fullName(),
    //       image: '',
    //       price: Random(345).nextDouble(),
    //       colors: List.empty()..addAll([Colors.red, Colors.green, Colors.blue]),
    //       category: RandomNames(Zone.spain).fullName(),
    //       rate: Random(345).nextDouble()),
    //   Product(
    //       title: RandomNames(Zone.spain).fullName(),
    //       description: RandomNames(Zone.spain).fullName(),
    //       image: '',
    //       price: Random(345).nextDouble(),
    //       colors: List.empty()..addAll([Colors.red, Colors.green, Colors.blue]),
    //       category: RandomNames(Zone.spain).fullName(),
    //       rate: Random(345).nextDouble()),
    // ];

    return [
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
  }

  void createProduct(Product product) {
    state = [...state, product];
  }

  void updateProduct(Product product, int index) {
    state = [...state]..[index] = product;
  }

  void deleteProduct(int index) {
    state = [...state]..removeAt(index);
  }
}
