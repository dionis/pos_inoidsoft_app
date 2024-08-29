import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pos_inoidsoft_app/constant.dart';
import 'package:pos_inoidsoft_app/data/models/product.dart';
import 'package:pos_inoidsoft_app/presentation/providers/item_sales_provider.dart';
import 'package:pos_inoidsoft_app/presentation/screens/Detail/image_slider.dart';
import 'package:pos_inoidsoft_app/presentation/screens/Detail/item_detail.dart';

import 'detail_app_bar.dart';

class DetailScreen extends ConsumerStatefulWidget {
  Product product;

  DetailScreen({super.key, required this.product});

  @override
  ConsumerState<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends ConsumerState<DetailScreen> {
  int currentImage = 0;

  int currentColor = 1;

  int currentSlider = 0;

  //From video
  //https://youtu.be/UHUSqJDKe-Q?list=LL&t=3626

  //Bibliografy:
  //Take a photo o search in galery
  // https://docs.flutter.dev/cookbook/plugins/picture-using-camera
  //
  // https://pub.dev/packages/image_picker
  //
  // About add Item or Update
  //
  //https://www.youtube.com/watch?v=h3-9LJDOlIA&t=28s

  @override
  Widget build(BuildContext context) {
    widget.product = ref.watch(selectedProductProvider);

    return Scaffold(
      backgroundColor: kcontentColor,
      body: SafeArea(
          child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // for back button share and favorite
            DetailAppBar(),
            // for detail image slider
            MyImageSlider(
                onChange: (index) {
                  currentImage = index;
                },
                image: widget.product.image),
            //const SizedBox(height: 15),
            Column(
              children: [
                Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(3, (index) {
                      currentImage = index;
                      return AnimatedContainer(
                          duration: const Duration(microseconds: 300),
                          width: currentImage == index ? 15 : 8,
                          height: 8,
                          margin: const EdgeInsets.only(right: 3),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: currentSlider == index
                                  ? Colors.black
                                  : Colors.transparent,
                              border: Border.all(color: Colors.black)));
                    })),
                const SizedBox(
                  height: 5,
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
              width: double.infinity,
              decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(40),
                      topLeft: Radius.circular(40))),
              padding: const EdgeInsets.only(
                  left: 20, right: 20, top: 20, bottom: 100),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                          onPressed: () {},
                          icon: const Icon(
                            Icons.camera_alt_rounded,
                            size: 30,
                          )),
                      const SizedBox(
                        width: 5,
                      ),
                      IconButton(
                          onPressed: () {},
                          icon: const Icon(Icons.photo_library_outlined),
                          style: IconButton.styleFrom(
                              backgroundColor: Colors.white,
                              padding: const EdgeInsets.all(15))),
                    ],
                  ),
                  ItemDetails(product: widget.product),
                  const SizedBox(
                    height: 20,
                  ),
                  const Text(
                    "Color: ",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: List.generate(
                        widget.product.colors.length,
                        (index) => GestureDetector(
                            onTap: () {
                              setState(() {
                                currentColor = index;
                              });
                            },
                            child: AnimatedContainer(
                              duration: Duration(milliseconds: 300),
                              width: 40,
                              height: 40,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: currentColor == index
                                    ? Colors.white
                                    : widget.product.colors[index],
                                border:
                                    currentColor == index ? Border.all() : null,
                              ),
                              padding: currentColor == index
                                  ? const EdgeInsets.all(2)
                                  : null,
                              margin: EdgeInsets.only(right: 10),
                              child: Container(
                                width: 35,
                                height: 35,
                                decoration: BoxDecoration(
                                    color: widget.product.colors[index],
                                    shape: BoxShape.circle),
                              ),
                            ))),
                  )
                ],
              ),
            )
          ],
        ),
      )),
    );
  }
}
