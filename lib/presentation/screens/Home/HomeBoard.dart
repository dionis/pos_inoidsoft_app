import 'package:flutter/material.dart';
import '../../../constant.dart';
import 'package:pos_inoidsoft_app/models/product.dart';
import '../../../presentation/widgets/product_cart.dart';

import '../../widgets/categories.dart';
import '../../widgets/custom_app_bar.dart';
import '../../widgets/custom_image_slider.dart';
import '../../widgets/search_bar.dart';

class Homeboard extends StatelessWidget {
  final int currentSlider = 0;
  const Homeboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //const SizedBox(height: 35),
              // for custom app bar
              //const CustomAppBar(),
              //const SizedBox(height: 25),
              // for main items search
              const CustomSearchBar(),
              const SizedBox(height: 25),
              // for image slide
              CustomImageSlider(
                  currentSlider: currentSlider,
                  onChange: (value) {
                    //currentSlider = value;
                  }),
              const SizedBox(height: 25),
              //for category selection
              //https://youtu.be/UHUSqJDKe-Q?list=LL&t=1660
              const Categories(),
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Special For you',
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.w800),
                  ),
                  Text("See all",
                      style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 16,
                          color: Colors.black54)),
                ],
              ),
              // for shoppin item list
              //most item sales
              GridView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 0.78,
                    crossAxisSpacing: 20,
                    mainAxisSpacing: 20),
                itemCount: products.length,
                itemBuilder: (context, index) {
                  return ProductCard(product: products[index]);
                },
              )
              //Finish Copy in:
              //https://youtu.be/UHUSqJDKe-Q?list=LL&t=2311
            ],
          ),
        ),
      ),
    );
  }
}
