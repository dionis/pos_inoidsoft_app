import 'product.dart';

class CartItem {
  int quantity;
  Product? product;

  CartItem({required this.quantity, required this.product});
}

List<CartItem> cartItems = [
  // CartItem(quantity: 2, product: products[0]),
  CartItem(quantity: products[1].rate.toInt(), product: products[1]),
  CartItem(quantity: products[2].rate.toInt(), product: products[2]),
  CartItem(quantity: products[3].rate.toInt(), product: products[3]),
  CartItem(quantity: products[4].rate.toInt(), product: products[4]),
  // CartItem(quantity: 1, product: products[5]),
  // CartItem(quantity: 1, product: products[6]),
  CartItem(quantity: products[7].rate.toInt(), product: products[7]),
];
