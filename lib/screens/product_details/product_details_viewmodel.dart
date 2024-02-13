import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProductDetailsViewModel extends GetxController
    with GetSingleTickerProviderStateMixin {
  // These keys are used for scrolling to specific container
  GlobalKey reviewsKey = GlobalKey();
  GlobalKey vendorKey = GlobalKey();
  GlobalKey similarProductKey = GlobalKey();
  ScrollController scrollController = ScrollController();
  //late TabController tabController;

  RxBool selectedTabIndex = true.obs;

  List<String> carouselList = <String>[
    'https://ismmart.com/cdn/shop/files/STN-13-Bluetooth-Stereo-Headphone-1_1.jpg',
    'https://ismmart.com/cdn/shop/files/ADI02840.jpg',
    'https://ismmart.com/cdn/shop/files/ADI02876.jpg',
  ];

  RxInt carouselIndex = 0.obs;
  PageController pageViewController = PageController(initialPage: 0);

  TextEditingController productQtyController = TextEditingController();

  Map<String, dynamic> variantsMap = <String, dynamic>{
    'Size': ['S', 'M', 'L', 'XL'],
    'Color': ['Black', 'Blue', 'Green'],
  };

  List<dynamic> reviewsList = [
    {
      'profileImage': 'https://ismmart.com/cdn/shop/files/IMG_8550.jpg',
      'name': 'Madelina',
      'rating': 4.5,
      'reviews':
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
      'duration': '1 month',
      'images': [
        'https://ismmart.com/cdn/shop/files/whatsapp_image_2024-01-15_at_7.18.07_pm.jpg',
        'https://ismmart.com/cdn/shop/files/whatsapp_image_2024-01-15_at_7.18.07_pm.jpg',
        'https://ismmart.com/cdn/shop/files/whatsapp_image_2024-01-15_at_7.18.07_pm.jpg',
        ''
      ],
    },
    {
      'profileImage': 'https://ismmart.com/cdn/shop/files/IMG_8550.jpg',
      'name': 'Madelina',
      'rating': 4.5,
      'reviews':
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
      'duration': '1 month',
      'images': [
        'https://ismmart.com/cdn/shop/files/whatsapp_image_2024-01-15_at_7.18.07_pm.jpg',
        'https://ismmart.com/cdn/shop/files/whatsapp_image_2024-01-15_at_7.18.07_pm.jpg',
        'https://ismmart.com/cdn/shop/files/whatsapp_image_2024-01-15_at_7.18.07_pm.jpg',
        ''
      ],
    },
  ];

 

  void scrollTo(GlobalKey key) {
    final RenderObject renderObject = key.currentContext!.findRenderObject()!;
    final position = renderObject.semanticBounds.top;
    scrollController.animateTo(
      position,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  }

  @override
  void onClose() {
    pageViewController.dispose();
    scrollController.dispose();
    super.onClose();
  }
}
