import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pos_inoidsoft_app/presentation/providers/config_state_variables.dart';

import '../../data/models/category.dart';

class Categories extends ConsumerWidget {
  Function() onSelected;

  Categories({super.key, required this.onSelected}) {
    itemCategoriesEsMap.forEach((key, value) {
      if (value != '') {
        categories.add(Category(title: key, image: value));
      }
    });
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SizedBox(
      height: 130,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              ref.read(categorySelectedProvider.notifier).update =
                  categories[index];
              onSelected();
            },
            child: Column(
              children: [
                Container(
                    height: 65,
                    width: 65,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                            image: AssetImage(categories[index].image),
                            fit: BoxFit.cover))),
                const SizedBox(height: 5),
                Text(
                  categories[index].title,
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.bold),
                )
              ],
            ),
          );
        },
        separatorBuilder: (context, index) => const SizedBox(width: 20),
      ),
    );
  }
}
