import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProductDetailsViewModel extends GetxController {
  List<String> carouselList = <String>[
    'https://ismmart.com/cdn/shop/files/STN-13-Bluetooth-Stereo-Headphone-1_1.jpg',
    'https://ismmart.com/cdn/shop/files/ADI02840.jpg',
    'https://ismmart.com/cdn/shop/files/ADI02876.jpg',
  ];

  RxInt carouselIndex = 0.obs;
  PageController pageViewController = PageController(initialPage: 0);

  @override
  void onInit() {
    super.onInit();
  }
}
