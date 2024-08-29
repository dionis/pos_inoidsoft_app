import 'package:flutter/material.dart';

class MyImageSlider extends StatelessWidget {
  final Function(int) onChange;
  String image;

  MyImageSlider({super.key, required this.onChange, required this.image}) {
    image = validateItemImage(image);
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 250,
      child: PageView.builder(
        onPageChanged: onChange,
        itemBuilder: (context, index) {
          return Image.asset(image);
        },
      ),
    );
  }

  String validateItemImage(image) {
    return image == null || image == '' ? "assets/no-image.jpg" : image;
  }
}
