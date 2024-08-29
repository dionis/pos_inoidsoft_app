import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pos_inoidsoft_app/presentation/providers/item_sales_provider.dart';
import 'package:pos_inoidsoft_app/presentation/screens/Detail/details_screen.dart';

class ProductEditScreen extends ConsumerWidget {
  const ProductEditScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedProduct = ref.watch(selectedProductProvider);

    return DetailScreen(
      product: selectedProduct,
    );
  }
}
