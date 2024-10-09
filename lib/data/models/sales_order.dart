import 'cart_item.dart';

class SalesOrder {
  DateTime date;
  List<CartItem> items;
  double totalPrice;
  int vendorId = 0;
  int customerId = 0;

  SalesOrder(
      {required this.date, required this.items, required this.totalPrice}) {
    if (items.isEmpty) {
      items = [];
    }
  }

  set setVendorId(int id) => vendorId = id;
  set setCustomerId(int id) => customerId = id;
  set setTotalPrice(double price) => totalPrice = price;
  set setDate(DateTime date) => date = date;
  set setItemToOrder(CartItem item) => items.add(item);
}

List<SalesOrder> stadisticOrders = [
  SalesOrder(
      date: DateTime(2024, 10, 5, 10, 30, 00),
      items: cartItems,
      totalPrice: cartItems.fold(
          0, (tot, item) => tot.toDouble() + item.product!.price)),
  SalesOrder(
      date: DateTime(2024, 10, 5, 10, 30, 00),
      items: cartItems,
      totalPrice: cartItems.fold(
          0, (tot, item) => tot.toDouble() + item.product!.price)),
  SalesOrder(
      date: DateTime(2024, 10, 5, 10, 30, 00),
      items: cartItems,
      totalPrice: cartItems.fold(
          0, (tot, item) => tot.toDouble() + item.product!.price)),
  SalesOrder(
      date: DateTime(2024, 10, 5, 10, 30, 00),
      items: cartItems,
      totalPrice: cartItems.fold(
          0, (tot, item) => tot.toDouble() + item.product!.price)),
  SalesOrder(
      date: DateTime(2024, 10, 5, 10, 30, 00),
      items: cartItems,
      totalPrice: cartItems.fold(
          0, (tot, item) => tot.toDouble() + item.product!.price)),
  SalesOrder(
      date: DateTime(2024, 10, 5, 10, 30, 00),
      items: cartItems,
      totalPrice: cartItems.fold(
          0, (tot, item) => tot.toDouble() + item.product!.price)),
  SalesOrder(
      date: DateTime(2024, 10, 5, 10, 30, 00),
      items: cartItems,
      totalPrice: cartItems.fold(
          0, (tot, item) => tot.toDouble() + item.product!.price)),
  SalesOrder(
      date: DateTime(2024, 10, 5, 10, 30, 00),
      items: cartItems,
      totalPrice: cartItems.fold(
          0, (tot, item) => tot.toDouble() + item.product!.price)),
  SalesOrder(
      date: DateTime(2024, 10, 5, 10, 30, 00),
      items: cartItems,
      totalPrice: cartItems.fold(
          0, (tot, item) => tot.toDouble() + item.product!.price)),
  SalesOrder(
      date: DateTime(2024, 10, 5, 10, 30, 00),
      items: cartItems,
      totalPrice: cartItems.fold(
          0, (tot, item) => tot.toDouble() + item.product!.price)),
  SalesOrder(
      date: DateTime(2024, 10, 5, 10, 30, 00),
      items: cartItems,
      totalPrice: cartItems.fold(
          0, (tot, item) => tot.toDouble() + item.product!.price)),
  SalesOrder(
      date: DateTime(2024, 10, 5, 10, 30, 00),
      items: cartItems,
      totalPrice: cartItems.fold(
          0, (tot, item) => tot.toDouble() + item.product!.price)),
];
