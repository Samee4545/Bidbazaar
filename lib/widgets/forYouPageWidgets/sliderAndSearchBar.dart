import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

List sliderImgList = [
  {"id": 1, "imgPath": "assets/images/slider_images/1.jpg"},
  {"id": 2, "imgPath": "assets/images/slider_images/ai.jpg"},
  {"id": 3, "imgPath": "assets/images/slider_images/1.jpg"},
  {"id": 4, "imgPath": "assets/images/slider_images/ai.jpg"},
];

final CarouselController carouselController = CarouselController();

Widget sliderAndSearchBar(context, screenScrolled) {
  return Stack(
    children: [
      SizedBox(
        height: 220,
        child: Align(
          alignment: Alignment.topCenter,
          child: CarouselSlider(
            options: CarouselOptions(
              scrollPhysics: const BouncingScrollPhysics(),
              autoPlay: true,
              aspectRatio: 2,
              viewportFraction: 1,
            ),
            items: sliderImgList
                .map((item) => Center(
                    child: Image.asset(item['imgPath'],
                        fit: BoxFit.cover, width: double.infinity)))
                .toList(),
            carouselController: carouselController,
          ),
        ),
      ),
      screenScrolled
          ? const SizedBox()
          : Positioned(
              bottom: 0,
              right: MediaQuery.of(context).size.width / 11,
              left: MediaQuery.of(context).size.width / 11,
              child: Container(
                width: MediaQuery.of(context).size.width / 1.22,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Colors.grey.shade300,
                  border: Border.all(
                    color: Colors.black.withOpacity(.9),
                  ),
                ),
                child: const ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(15)),
                  child: TextField(
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.search),
                      filled: true,
                      hintText: "Search...",
                      prefixIconColor: Colors.black,
                      border: InputBorder.none,
                    ),
                  ),
                ),
              ),
            )
    ],
  );
}
