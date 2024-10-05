import 'package:flutter/material.dart';

import 'package:pos_inoidsoft_app/data/models/product.dart';
import 'package:pos_inoidsoft_app/presentation/providers/config_state_variables.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:uuid/uuid.dart';

import '../../data/models/category.dart';

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

enum QuantityFilterType {
  equal,
  greaterThan,
  lessThan,
  greaterThanOrEqual,
  lessThanOrEqual,
  between,
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
//Check https://stackoverflow.com/questions/75391076/update-state-of-an-object-in-riverpod
  void set product(Product newProduct) {
    state = newProduct;
  }

  bool updateBarCode(String barCode) {
    if (state.barCode != barCode) {
      state.barcode = barCode;
      return true;
    }
    return false;
  }

  bool addColor(List<Color> newListColors) {
    state = state.copyWith(colors: newListColors);
    return true;
  }

  bool removeColor(Color newColor) {
    if (state.colors.remove(newColor)) {
      return true;
    }
    return false;
  }

  set categories(String newCategory) {
    state = state.copyWith(category: newCategory);
  }

  set image(String path) {
    state = state.copyWith(image: path);
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
    return allList();
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

  void filteredItemSalesByCategory(Category filteredCategory) {
    // obtains both the filter and the list of todos
    state = allList()
        .where((todo) => todo.category == filteredCategory.title)
        .toList();
  }

  List<Product> filteredItemSalesByName(String nameToSearch) {
    return nameToSearch.isEmpty
        ? state = allList()
        : state = allList()
            .where((todo) => todo.title
                .toLowerCase()
                .contains(nameToSearch.toLowerCase().trim()))
            .toList();
  }

  List<Product> allList() {
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
        category: "Electrónicos",
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
        category: "Ropas",
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
        category: "Electrónicos",
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
        category: "Ropas",
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
          category: "Belleza",
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
          category: "Belleza",
          rate: 0.8,
          barcode: '8504000011575'),
      Product(
          title: "Rectal Baseline",
          description:
              "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Donec massa sapien faucibus et molestie ac feugiat. In massa tempor nec feugiat nisl. Libero id faucibus nisl tincidunt.",
          image: "assets/pc.jpg",
          price: 456.67,
          colors: [Colors.blueAccent.shade400, Colors.lightGreenAccent],
          category: "Belleza",
          rate: 1.8,
          barcode: '080196668420'),
      Product(
          title: "Desodorant Axe",
          description:
              "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Donec massa sapien faucibus et molestie ac feugiat. In massa tempor nec feugiat nisl. Libero id faucibus nisl tincidunt.",
          image: "assets/beauty.png",
          price: 5.99,
          colors: [Colors.cyanAccent.shade700, Colors.orangeAccent.shade400],
          category: "Otros",
          rate: 1.8,
          barcode: '7506306226739'),
    ];
  }

  void filteredItemSalesByQuantity(
      int quantity, QuantityFilterType filterType) {
    // obtains both the filter and the list of todos

    switch (filterType) {
      case QuantityFilterType.equal:
        state = allList().where((todo) => todo.rate == quantity).toList();
        break;
      case QuantityFilterType.greaterThan:
        state = allList().where((todo) => todo.rate > quantity).toList();
        break;
      case QuantityFilterType.lessThan:
        state = allList().where((todo) => todo.rate < quantity).toList();
        break;
      case QuantityFilterType.greaterThanOrEqual:
        state = allList().where((todo) => todo.rate >= quantity).toList();
        break;
      case QuantityFilterType.lessThanOrEqual:
        state = allList().where((todo) => todo.rate <= quantity).toList();
        break;
      default:
        state = allList();
    }
  }

  void filteredItemSalesByPrice(int quantity, QuantityFilterType filterType) {
    switch (filterType) {
      case QuantityFilterType.equal:
        state = [...state].where((todo) => todo.price == quantity).toList();
        break;
      case QuantityFilterType.greaterThan:
        state = [...state].where((todo) => todo.price > quantity).toList();
        break;
      case QuantityFilterType.lessThan:
        state = [...state].where((todo) => todo.price < quantity).toList();
        break;
      case QuantityFilterType.greaterThanOrEqual:
        state = [...state].where((todo) => todo.price >= quantity).toList();
        break;
      case QuantityFilterType.lessThanOrEqual:
        state = [...state].where((todo) => todo.price <= quantity).toList();
        break;
      default:
        state = allList();
        break;
    }
  }

  void showAll() {
    state = allList();
  }
}

@Riverpod(keepAlive: true)
class SelectedCoinIndex extends _$SelectedCoinIndex {
  @override
  int build() => 0;

  updateEditSelectedItem(int index) {
    state = index >= 0 ? index : 0;
  }
}

//Filtered Items List Example
//Bibliografy: https://riverpod.dev/docs/concepts/reading

@Riverpod(keepAlive: true)
List<Product> filteredItemSales(FilteredItemSalesRef ref) {
  // obtains both the filter and the list of todos
  final Category filteredCategory = ref.watch(categorySelectedProvider);
  final List<Product> todos = ref.watch(itemSalesProvider);
  return todos
      .where((todo) => todo.category == filteredCategory.title)
      .toList();
}

@Riverpod(keepAlive: true)
List<Product> filteredItemSalesByName(
    FilteredItemSalesByNameRef ref, String title) {
  // obtains both the filter and the list of todos
  final List<Product> todos = ref.watch(itemSalesProvider);

  return title.isEmpty
      ? todos
      : todos
          .where((todo) =>
              todo.title.toLowerCase().contains(title.toLowerCase().trim()))
          .toList();
}

@Riverpod(keepAlive: true)
List<Product> filteredItemSalesByQuantity(FilteredItemSalesByQuantityRef ref,
    int quantity, QuantityFilterType filterType) {
  // obtains both the filter and the list of todos
  final List<Product> todos = ref.watch(itemSalesProvider);

  switch (filterType) {
    case QuantityFilterType.equal:
      return todos.where((todo) => todo.rate == quantity).toList();
    case QuantityFilterType.greaterThan:
      return todos.where((todo) => todo.rate > quantity).toList();
    case QuantityFilterType.lessThan:
      return todos.where((todo) => todo.rate < quantity).toList();
    case QuantityFilterType.greaterThanOrEqual:
      return todos.where((todo) => todo.rate >= quantity).toList();
    case QuantityFilterType.lessThanOrEqual:
      return todos.where((todo) => todo.rate <= quantity).toList();
    default:
      return todos;
  }
}

@Riverpod(keepAlive: true)
List<Product> filteredItemSalesByPrice(FilteredItemSalesByPriceRef ref,
    int quantity, QuantityFilterType filterType) {
  // obtains both the filter and the list of todos
  final List<Product> todos = ref.watch(itemSalesProvider);

  switch (filterType) {
    case QuantityFilterType.equal:
      return todos.where((todo) => todo.price == quantity).toList();
    case QuantityFilterType.greaterThan:
      return todos.where((todo) => todo.price > quantity).toList();
    case QuantityFilterType.lessThan:
      return todos.where((todo) => todo.price < quantity).toList();
    case QuantityFilterType.greaterThanOrEqual:
      return todos.where((todo) => todo.price >= quantity).toList();
    case QuantityFilterType.lessThanOrEqual:
      return todos.where((todo) => todo.price <= quantity).toList();
    default:
      return todos;
  }
}
