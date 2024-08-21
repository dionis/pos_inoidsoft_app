import 'package:flutter/material.dart';
import 'dart:math';

import 'package:pos_inoidsoft_app/models/product.dart';
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

@riverpod
class ItemSales extends _$ItemSales {
  @override
  List<Product> build() {
    return [
      Product(
          title: RandomNames(Zone.spain).fullName(),
          description: RandomNames(Zone.spain).fullName(),
          image: '',
          price: Random(345).nextDouble(),
          colors: List.empty()..addAll([Colors.red, Colors.green, Colors.blue]),
          category: RandomNames(Zone.spain).fullName(),
          rate: Random(345).nextDouble()),
      Product(
          title: RandomNames(Zone.spain).fullName(),
          description: RandomNames(Zone.spain).fullName(),
          image: '',
          price: Random(345).nextDouble(),
          colors: List.empty()..addAll([Colors.red, Colors.green, Colors.blue]),
          category: RandomNames(Zone.spain).fullName(),
          rate: Random(345).nextDouble()),
      Product(
          title: RandomNames(Zone.spain).fullName(),
          description: RandomNames(Zone.spain).fullName(),
          image: '',
          price: Random(345).nextDouble(),
          colors: List.empty()..addAll([Colors.red, Colors.green, Colors.blue]),
          category: RandomNames(Zone.spain).fullName(),
          rate: Random(345).nextDouble()),
      Product(
          title: RandomNames(Zone.spain).fullName(),
          description: RandomNames(Zone.spain).fullName(),
          image: '',
          price: Random(345).nextDouble(),
          colors: List.empty()..addAll([Colors.red, Colors.green, Colors.blue]),
          category: RandomNames(Zone.spain).fullName(),
          rate: Random(345).nextDouble()),
      Product(
          title: RandomNames(Zone.spain).fullName(),
          description: RandomNames(Zone.spain).fullName(),
          image: '',
          price: Random(345).nextDouble(),
          colors: List.empty()..addAll([Colors.red, Colors.green, Colors.blue]),
          category: RandomNames(Zone.spain).fullName(),
          rate: Random(345).nextDouble()),
      Product(
          title: RandomNames(Zone.spain).fullName(),
          description: RandomNames(Zone.spain).fullName(),
          image: '',
          price: Random(345).nextDouble(),
          colors: List.empty()..addAll([Colors.red, Colors.green, Colors.blue]),
          category: RandomNames(Zone.spain).fullName(),
          rate: Random(345).nextDouble()),
      Product(
          title: RandomNames(Zone.spain).fullName(),
          description: RandomNames(Zone.spain).fullName(),
          image: '',
          price: Random(345).nextDouble(),
          colors: List.empty()..addAll([Colors.red, Colors.green, Colors.blue]),
          category: RandomNames(Zone.spain).fullName(),
          rate: Random(345).nextDouble()),
    ];
  }

  void createProduct(Product product) {
    state = [...state, product];
  }

  void updateProduct(Product product, int index) {
    state = [...state]..[index] = product;
  }

  void deleteProduct(int index) {}
}
