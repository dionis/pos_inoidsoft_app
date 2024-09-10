import 'dart:ui';

import 'package:pos_inoidsoft_app/data/models/cart_item.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../data/models/product.dart';

part 'items_car_sales_provider.g.dart';

@Riverpod(keepAlive: true)
class SelectedInSalesCartProduct extends _$SelectedInSalesCartProduct {
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
class SelectedInSalesCartProductIndex
    extends _$SelectedInSalesCartProductIndex {
  @override
  int build() => 0;

  updateEditSelectedItem(int index) {
    state = index >= 0 ? index : 0;
  }
}

@Riverpod(keepAlive: true)
class ItemsSalesCart extends _$ItemsSalesCart {
  @override
  List<CartItem> build() {
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

    return [];

    //  // CartItem(quantity: 2, product: products[0]),
    //   CartItem(quantity: 1, product: products[1]),
    //   CartItem(quantity: 15, product: products[2]),
    //   CartItem(quantity: 2, product: products[3]),
    //   CartItem(quantity: 7, product: products[4]),
    //   // CartItem(quantity: 1, product: products[5]),
    //   // CartItem(quantity: 1, product: products[6]),
    //   CartItem(quantity: 1, product: products[7]),
  }

  bool createProduct(CartItem product) {
    final exitsProduct = state.any((element) => element.id == product.id);

    if (!exitsProduct) {
      state = [...state, product];
    }

    return exitsProduct;
  }

  void updateProduct(Product product, int index) {
    state = [...state]..[index].quantity = product.rate.toInt();
    state = [...state]..[index].product = product;
  }

  void deleteProduct(int index) {
    state = [...state]..removeAt(index);
  }
}
