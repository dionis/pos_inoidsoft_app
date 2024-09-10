import 'package:flutter/material.dart';
import 'dart:math';

import 'package:pos_inoidsoft_app/data/models/product.dart';
import 'package:random_name_generator/random_name_generator.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:uuid/uuid.dart';

part 'item_sales_provider.g.dart';

const uuid = Uuid();

enum FilterType {
  all,
  completed,
  pending,
  updateItemPos,
  updateItemList,
  editItem
}

@Riverpod(keepAlive: true)
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

  bool updateBarCode(String barCode) {
    if (state.barCode != barCode) {
      state.barcode = barCode;
      return true;
    }
    return false;
  }

  bool addColor(Color newColor) {
    state.colors.add(newColor);
    return true;
  }

  bool removeColor(Color newColor) {
    if (state.colors.remove(newColor)) {
      return true;
    }
    return false;
  }

  set categories(String newCategory) {
    state.category = newCategory;
  }
}

@Riverpod(keepAlive: true)
class SelectedProductIndex extends _$SelectedProductIndex {
  @override
  int build() => 0;

  updateEditSelectedItem(int index) {
    state = index >= 0 ? index : 0;
  }
}

@Riverpod(keepAlive: true)
class ItemSales extends _$ItemSales {
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
  @override
  List<Product> build() {
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

  bool createProduct(Product product) {
    final exitsProduct = state.any((element) => element.id == product.id);

    if (!exitsProduct) {
      state = [...state, product];
    }

    return exitsProduct;
  }

  void updateProduct(Product product, int index) {
    state = [...state]..[index] = product;
  }

  void deleteProduct(int index) {
    state = [...state]..removeAt(index);
  }
}
