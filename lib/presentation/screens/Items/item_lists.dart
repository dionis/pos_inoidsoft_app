import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pos_inoidsoft_app/constant.dart';
import 'package:pos_inoidsoft_app/presentation/providers/item_sales_provider.dart';

import '../../../data/models/cart_item.dart';
import '../../../data/models/product.dart';
import '../../providers/config_state_variables.dart';
import '../../widgets/cart_tile.dart';
import '../../widgets/categories.dart';
import '../../widgets/search_bar.dart';

class ItemListsScreen extends ConsumerWidget {
  late BuildContext oldDialogContext;

  ItemListsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    //final itemLists = ref.watch(itemSalesCurrentFilterProvider);

    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
          //padding: const EdgeInsets.all(20),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        //const SizedBox(height: 35),
        // for custom app bar
        //const CustomAppBar(),
        //const SizedBox(height: 25),
        // for main items search
        const CustomSearchBar(),
        const SizedBox(height: 5),
        const Categories(),
        const SizedBox(height: 5),
        Expanded(
          child: ListView.builder(
            shrinkWrap: true,
            padding: const EdgeInsets.all(20),
            itemBuilder: (context, index) {
              Product itemProduct = ref.read(itemSalesProvider)[index];
              final cartItemShow = CartItem(
                  quantity: itemProduct.rate.toInt(), product: itemProduct);

              return CarTile(
                item: cartItemShow,
                onRemove: () {
                  if (cartItemShow.quantity != 1) {
                    itemProduct.rate = (cartItemShow.quantity--).toDouble();
                  }

                  ref
                      .read(itemSalesProvider.notifier)
                      .updateProduct(itemProduct, index);
                },
                onAdd: () {
                  itemProduct.rate = (cartItemShow.quantity++).toDouble();
                  ref
                      .read(itemSalesProvider.notifier)
                      .updateProduct(itemProduct, index);
                },
                onDeleteItem: () {
                  ref.read(itemSalesProvider.notifier).deleteProduct(index);
                },
                onEditItem: () {
                  ref
                      .read(selectedProductProvider.notifier)
                      .setProduct(itemProduct);
                  ref
                      .read(itemSalesCurrentFilterProvider.notifier)
                      .changeCurrentFilter(FilterType.updateItemList);

                  ref
                      .read(selectedProductIndexProvider.notifier)
                      .updateEditSelectedItem(index);
                  ref
                      .read(currentIndexProvider.notifier)
                      .updateCurrentMainWidget("ProductEditScreen", 6);
                },
              );
            },
            //separatorBuilder: (context, index) => const SizedBox(height: 5),
            itemCount: ref.watch(itemSalesProvider).length,
          ),
        )
      ])),
      floatingActionButton: FloatingActionButton(
        backgroundColor: kprimaryColor,
        tooltip: ADD_PRODUCT,
        onPressed: () {
          ref
              .read(selectedProductProvider.notifier)
              .setProduct(Product(title: '', price: 0.0, rate: 1));
          ref
              .read(itemSalesCurrentFilterProvider.notifier)
              .changeCurrentFilter(FilterType.updateItemList);
          ref
              .read(currentIndexProvider.notifier)
              .updateCurrentMainWidget("ProductEditScreen", 6);
        },
        child: const Icon(Icons.add, color: Colors.white, size: 28),
      ),
    );
  }
}
