import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pos_inoidsoft_app/constant.dart';

import '../providers/item_sales_provider.dart';

class CustomSearchBar extends ConsumerWidget {
  bool advanceSearch = false;
  CustomSearchBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      height: 55,
      width: double.infinity,
      decoration: BoxDecoration(
          color: kcontentColor, borderRadius: BorderRadius.circular(30)),
      padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 5),
      child: Row(
        children: [
          const Icon(
            Icons.search,
            color: Colors.grey,
            size: 30,
          ),
          const SizedBox(width: 10),
          Flexible(
              child: TextField(
                  onChanged: (value) {
                    if (value.isNotEmpty) {
                      ref
                          .read(itemSalesProvider.notifier)
                          .filteredItemSalesByName(value);
                    }
                  },
                  decoration: InputDecoration(
                      hintText: "Search...", border: InputBorder.none))),
          Container(
            height: 35,
            width: 1.5,
            color: Colors.grey,
          ),
          IconButton(
              onPressed: () {},
              icon: const Icon(Icons.tune, color: Colors.grey))
        ],
      ),
    );
  }
}
