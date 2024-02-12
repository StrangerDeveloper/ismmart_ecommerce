import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ismmart_ecommerce/helpers/global_variables.dart';
import 'package:ismmart_ecommerce/screens/home/collection_model.dart';

import '../../helpers/api_base_helper.dart';
import '../../helpers/common_function.dart';
import '../../helpers/urls.dart';

class HomeViewModel extends GetxController {
  //Screen
  RxBool isScrolled = false.obs;
  ScrollController mainScrollController = ScrollController();

  //Collections
  List<CollectionModel> collectionList = <CollectionModel>[].obs;
  RxInt collectionCurrentIndex = 0.obs;

  //Carousel
  PageController carouselPageController = PageController(viewportFraction: 1.0);
  late Timer carouselTimer;
  RxInt carouselCurrentIndex = 0.obs;
  List<String> carouselList = <String>[].obs;
  RxString appBarImage = ''.obs;
  RxString bannerImage = ''.obs;

  //Categories
  List<Children> categoriesList = <Children>[].obs;

  @override
  void onInit() {
    mainScrollController = ScrollController()
      ..addListener(() {
        if (mainScrollController.offset > 50) {
          isScrolled.value = true;
        } else {
          isScrolled.value = false;
        }
        // isScrolled.value =
        //     mainScrollController.hasClients && mainScrollController.offset > 50;
      });
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
    getCollections(0);
  }

  @override
  void onClose() {
    carouselPageController.dispose();
    mainScrollController.dispose();
    super.onClose();
  }

  clearValues() {
    collectionList.clear();
    carouselList.clear();
    categoriesList.clear();
    bannerImage.value = '';
  }

  getCollections(int index) async {
    collectionCurrentIndex.value = index;
    GlobalVariable.showLoader.value = true;
    await ApiBaseHelper()
        .getMethod(url: Urls.homeCollections)
        .then((parsedJson) {
      GlobalVariable.showLoader.value = false;
      clearValues();
      if (parsedJson['success'] == true &&
          parsedJson['data']['items'] != null) {
        var data = parsedJson['data']['items'] as List;

        //Collections
        collectionList.addAll(data.map((e) => CollectionModel.fromJson(e)));

        //Carousel & Banner
        int mediaLength =
            collectionList[collectionCurrentIndex.value].media?.length ?? 0;
        if (mediaLength > 1) {
          for (int i = 0; i < mediaLength - 1; i++) {
            carouselList.add(
                collectionList[collectionCurrentIndex.value].media?[i] ?? '');
          }
          bannerImage.value =
              collectionList[collectionCurrentIndex.value].media?.last ?? '';
          animateCarousel();
        } else {
          carouselList.add(
              collectionList[collectionCurrentIndex.value].media?[0] ?? '');
        }

        //Categories
        categoriesList.addAll(
            collectionList[collectionCurrentIndex.value].children ?? []);
      }
    }).catchError((e) {
      CommonFunction.debugPrint(e);
    });
  }

  animateCarousel() {
    carouselTimer = Timer.periodic(const Duration(seconds: 4), (Timer timer) {
      if (carouselCurrentIndex.value < carouselList.length) {
        carouselCurrentIndex.value++;
      } else {
        carouselCurrentIndex.value = 0;
      }

      if (carouselPageController.hasClients) {
        carouselPageController.animateToPage(
          carouselCurrentIndex.value,
          duration: const Duration(milliseconds: 800),
          curve: Curves.easeIn,
        );
      }
    });
  }
}
