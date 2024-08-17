import 'package:flutter/material.dart';

class CustomImageSlider extends StatelessWidget {
  final Function(int) onChange;
  final int currentSlider;
  int imageToShowIndex = 0;

  CustomImageSlider(
      {super.key, required this.currentSlider, required this.onChange})
      : imageToShowIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SizedBox(
            height: 220,
            width: double.infinity,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: PageView(
                scrollDirection: Axis.horizontal,
                allowImplicitScrolling: true,
                physics: const ClampingScrollPhysics(),
                children: [
                  Image.asset(
                    "images/slider.jpg",
                    fit: BoxFit.cover,
                  ),
                  Image.asset(
                    "images/image1.png",
                    fit: BoxFit.cover,
                  ),
                  Image.asset(
                    "images/slider3.png",
                    fit: BoxFit.cover,
                  )
                ],
              ),
            )),
        Positioned.fill(
            bottom: 10,
            child: Align(
                alignment: Alignment.bottomCenter,
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(3, (index) {
                      imageToShowIndex = index;
                      return AnimatedContainer(
                          duration: const Duration(microseconds: 300),
                          width: imageToShowIndex == index ? 15 : 8,
                          height: 8,
                          margin: const EdgeInsets.only(right: 3),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: currentSlider == index
                                  ? Colors.black
                                  : Colors.transparent,
                              border: Border.all(color: Colors.black)));
                    }))))
      ],
    );
  }
}
