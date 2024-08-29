import 'package:flutter/material.dart';
import 'package:pos_inoidsoft_app/constant.dart';

import '../../../data/models/product.dart';

class ItemDetails extends StatelessWidget {
  final Product product;

  TextEditingController _quantityController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();
  TextEditingController _priceController = TextEditingController();

  ItemDetails({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(product.title,
            style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 25)),
        Row(children: [
          const Text("Precio: ",
              style:
                  const TextStyle(fontWeight: FontWeight.w800, fontSize: 12)),
          // Expanded(
          //   child: TextField(
          //       controller: _priceController,
          //       decoration: InputDecoration(
          //         border: InputBorder.none,
          //         hintText: "\$${product.price}",
          //         hintStyle: const TextStyle(color: Colors.grey),
          //       )),
          // )
          Positioned(
            bottom: 100,
            left: 0, //0 is starting at left, use it to give left-margin
            right: 0, //0 is ending at right, use it to give right-margin
            child: Container(
              child: TextField(
                  controller: _priceController,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: "\$${product.price}",
                    hintStyle: const TextStyle(color: Colors.grey),
                  )),
            ),
          )
        ]),
        const SizedBox(height: 5),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 155,
                  height: 40,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: kprimaryColor),
                  alignment: Alignment.center,
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const Icon(Icons.stars_outlined,
                          size: 15, color: Colors.white),
                      const SizedBox(
                        width: 5,
                      ),
                      const Text(
                        "Cantidad: ",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontSize: 15),
                      ),
                      const SizedBox(
                        width: 3,
                      ),
                      Text(
                        product.rate.toString(),
                        style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                            fontSize: 20),
                      )
                    ],
                  ),
                ),
                Row(
                  children: [
                    IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.qr_code_outlined,
                          size: 30,
                        )),
                    const SizedBox(
                      width: 5,
                    ),
                    IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.local_print_shop_outlined,
                          size: 30,
                        )),
                  ],
                ),
              ],
            ),
            const SizedBox(
              width: 5,
            ),
            Text(
              product.description
                  .substring(0, (product.description.length / 3).toInt()),
              style: const TextStyle(color: Colors.black, fontSize: 15),
            )
          ],
        ),

        // const Spacer(),
        // const Text.rich(
        //     TextSpan(text: "Seller: ", style: TextStyle(fontSize: 16)))
      ],
    );
  }

  Widget customTextField({label, hint, controller, isDesc = false}) {
    return TextFormField(
      maxLines: isDesc ? 4 : 1,
      decoration: InputDecoration(
          label: Text(label),
          hintText: hint,
          hintStyle: const TextStyle(color: Colors.grey),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Colors.white)),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Colors.white))),
      controller: controller,
    );
  }
}
