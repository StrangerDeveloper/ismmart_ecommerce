import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:ismmart_ecommerce/helpers/global_variables.dart';
import 'package:ismmart_ecommerce/screens/home/model/collection_model.dart';
import 'package:ismmart_ecommerce/screens/home/model/discount_model.dart';
import 'package:ismmart_ecommerce/screens/home/model/discounted_product_model.dart';
import 'package:ismmart_ecommerce/screens/home/model/news_model.dart';

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

  //News
  List<NewsModel> newsList = <NewsModel>[].obs;

  //Discount
  Rx<DiscountModel>? discountModel = DiscountModel().obs;
  RxString hours = '00'.obs;
  RxString minutes = '00'.obs;
  RxString seconds = '00'.obs;
  Timer? timer;
  List<DiscountedProductModel> flashProductList =
      <DiscountedProductModel>[].obs;

  //All Products
  List<DiscountedProductModel> allProductList = <DiscountedProductModel>[].obs;
  RxBool paginationLoader = false.obs;
  int pageNo = 0;

  @override
  void onInit() {
    mainScrollController.addListener(getAllProducts);
    // mainScrollController = ScrollController()
    //   ..addListener(() {
    //     if (mainScrollController.offset > 50) {
    //       isScrolled.value = true;
    //     } else {
    //       isScrolled.value = false;
    //     }
    //     // isScrolled.value =
    //     //     mainScrollController.hasClients && mainScrollController.offset > 50;
    //   });
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
     getCollections(0);
     // getAllProductsPagination();
  }

  @override
  void onClose() {
    carouselTimer.cancel();
    timer?.cancel();
    carouselPageController.dispose();
    mainScrollController.dispose();
    super.onClose();
  }

  getData() {
    getNews();
    getFlashTimer();
  }

  getAllProductsPagination() async {
    pageNo = 0;
    allProductList.clear();
    // mainScrollController.removeListener(getAllProducts);
    paginationLoader.value = true;
    // if (!mainScrollController.hasListeners) {
    //   mainScrollController = ScrollController();
    //   mainScrollController.addListener(getAllProducts);
    // }
    await getAllProducts();
    paginationLoader.value = false;
  }

  clearValues() {
    collectionList.clear();
    carouselList.clear();
    categoriesList.clear();
    bannerImage.value = '';
    flashProductList.clear();
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
        getAllProductsPagination();

        //Call other apis...
        getData();

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

  getNews() async {
    // GlobalVariable.showLoader.value = true;
    await ApiBaseHelper().getMethod(url: Urls.getNews).then((parsedJson) {
      // GlobalVariable.showLoader.value = false;

      if (parsedJson['success'] == true &&
          parsedJson['data']['items'] != null) {
        var data = parsedJson['data']['items'] as List;
        newsList.addAll(data.map((e) => NewsModel.fromJson(e)));
      }
    }).catchError((e) {
      CommonFunction.debugPrint(e);
    });
  }

  getFlashTimer() async {
    String collectionId = collectionList[collectionCurrentIndex.value].sId!;
    // GlobalVariable.showLoader.value = true;
    await ApiBaseHelper()
        .getMethod(url: Urls.getDiscount + collectionId)
        .then((parsedJson) {
      // GlobalVariable.showLoader.value = false;

      if (parsedJson['success'] == true &&
          parsedJson['data']['items'] != null) {
        var data = parsedJson['data']['items'] as List;
        if (data.isNotEmpty) {
          discountModel?.value = DiscountModel.fromJson(data[0]);
          if (discountModel?.value.sId != null) {
            getFlashProducts(discountModel!.value.sId!, collectionId);
          }
          // getAllProductsPagination();
          if (discountModel?.value.end != null) {
            startTimer(discountModel!.value.end!);
          }
        }
      }
    }).catchError((e) {
      CommonFunction.debugPrint(e);
    });
  }

  getFlashProducts(String discountId, String collectionId) async {
    // GlobalVariable.showLoader.value = true;
    await ApiBaseHelper()
        .getMethod(
            url:
                '${Urls.getDiscountedProducts}$discountId&collection=$collectionId')
        .then((parsedJson) {
      // GlobalVariable.showLoader.value = false;

      if (parsedJson['success'] == true &&
          parsedJson['data']['items'] != null) {
        var data = parsedJson['data']['items'] as List;
        flashProductList
            .addAll(data.map((e) => DiscountedProductModel.fromJson(e)));
      }
    }).catchError((e) {
      CommonFunction.debugPrint(e);
    });
  }

  getAllProducts() async {
        if (mainScrollController.offset > 50) {
          isScrolled.value = true;
        } else {
          isScrolled.value = false;
        }
    if (pageNo == 0
        ? true
        : (mainScrollController.hasClients &&
            mainScrollController.position.maxScrollExtent ==
                mainScrollController.offset)) {
      pageNo++;
      paginationLoader.value = true;

      //String collectionId = collectionList[collectionCurrentIndex.value].sId!;

      await ApiBaseHelper()
          .getMethod(url: '${Urls.getSimpleProducts}&page=$pageNo')
          .then((parsedJson) {
        if (parsedJson['success'] == true &&
            parsedJson['data']['items'] != null) {
          var data = parsedJson['data']['items'] as List;
          // if (data.isEmpty || data.length<10) {
          //   mainScrollController.removeListener(getAllProducts);
          // }
          allProductList
              .addAll(data.map((e) => DiscountedProductModel.fromJson(e)));

          allProductList.add(DiscountedProductModel.fromJson(data[0]));
          allProductList.add(DiscountedProductModel.fromJson(data[0]));
          allProductList.add(DiscountedProductModel.fromJson(data[0]));
          allProductList.add(DiscountedProductModel.fromJson(data[0]));
          allProductList.add(DiscountedProductModel.fromJson(data[0]));
          allProductList.add(DiscountedProductModel.fromJson(data[0]));
          allProductList.add(DiscountedProductModel.fromJson(data[0]));
          allProductList.add(DiscountedProductModel.fromJson(data[0]));
          allProductList.add(DiscountedProductModel.fromJson(data[0]));

          paginationLoader.value = false;
        }
      }).catchError((e) {
        CommonFunction.debugPrint(e);
      });
    }
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

  startTimer(String endTime) {
    /// Calculate duration

    DateTime dateTime =
        DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'").parseUtc(endTime).toLocal();
    DateTime currentTime = DateTime.now();
    int diffInSeconds = dateTime.difference(currentTime).inSeconds;

    if (diffInSeconds > 0) {
      Duration duration = Duration(seconds: diffInSeconds);
      timer = Timer.periodic(const Duration(seconds: 1), (flashSaleTimer) {
        duration = Duration(seconds: duration.inSeconds - 1);
        String twoDigits(int n) => n.toString().padLeft(2, "0");
        hours.value = twoDigits(duration.inHours);
        minutes.value = twoDigits(duration.inMinutes.remainder(60));
        seconds.value = twoDigits(duration.inSeconds.remainder(60));

        if (duration.inSeconds == 0) {
          flashSaleTimer.cancel();
        }
      });
    }
  }

  String calculatePercentage(int index) {
    double percentage =
        double.tryParse((flashProductList[index].discount).toString()) ?? 0.0;
    double price =
        double.tryParse((flashProductList[index].price).toString()) ?? 0.0;
    double finalPrice = price - (percentage * price);
    return finalPrice.toString();
  }

  String calculatePercentage2(int index) {
    double percentage =
        double.tryParse((allProductList[index].discount).toString()) ?? 0.0;
    double price =
        double.tryParse((allProductList[index].price).toString()) ?? 0.0;
    double finalPrice = price - (percentage * price);
    return finalPrice.toString();
  }
}
