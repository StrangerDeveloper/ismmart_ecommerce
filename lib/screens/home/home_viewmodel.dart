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
import '../product_details/model/product_model.dart';

class HomeViewModel extends GetxController {
  //Screen
  RxBool isScrolled = false.obs;
  ScrollController mainScrollController = ScrollController();

  //Collections
  List<CollectionModel> collectionList = <CollectionModel>[].obs;
  RxInt collectionCurrentIndex = 0.obs;
  String selectedCollectionId = '';

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
  List<HomeProductModel> flashProductList = <HomeProductModel>[].obs;

  //All Products
  RxList<HomeProductModel> allProductList = <HomeProductModel>[].obs;
  RxList<Product> productList = <Product>[].obs;
  RxBool paginationLoader = false.obs;
  int pageNo = 1;

  @override
  void onInit() {
    // mainScrollController.addListener(getAllProducts);
    mainScrollController.addListener(appBarSetting);
    super.onInit();
  }

  appBarSetting() {
    //change AppBar Settings -- linked to ScrollController listener
    if (mainScrollController.offset > 50) {
      isScrolled.value = true;
    } else {
      isScrolled.value = false;
    }
  }

  @override
  void onReady() {
    super.onReady();
    getCollections();
  }

  @override
  void onClose() {
    carouselTimer.cancel();
    timer?.cancel();
    carouselPageController.dispose();
    mainScrollController.dispose();
    super.onClose();
  }

  changeCollection(int index) {
    collectionCurrentIndex.value = index;
    selectedCollectionId =
        collectionList[collectionCurrentIndex.value].sId ?? '';

    // Clear data
    carouselList.clear();
    categoriesList.clear();
    bannerImage.value = '';
    flashProductList.clear();
    //Get all Products at Bottom...
    pageNo = 1;
    allProductList.clear();
    mainScrollController.animateTo(
      mainScrollController.position.minScrollExtent,
      duration: const Duration(milliseconds: 500),
      curve: Curves.fastOutSlowIn,
    );

    //Carousel & Banner
    int mediaLength =
        collectionList[collectionCurrentIndex.value].media?.length ?? 0;
    if (mediaLength > 1) {
      for (int i = 0; i < mediaLength - 1; i++) {
        carouselList
            .add(collectionList[collectionCurrentIndex.value].media?[i] ?? '');
      }
      bannerImage.value =
          collectionList[collectionCurrentIndex.value].media?.last ?? '';
      animateCarousel();
    } else {
      carouselList
          .add(collectionList[collectionCurrentIndex.value].media?[0] ?? '');
      appBarImage.value =
          collectionList[collectionCurrentIndex.value].media?[0] ?? '';
    }

    //Categories
    categoriesList
        .addAll(collectionList[collectionCurrentIndex.value].children ?? []);

    //Call other apis...
    getFlashTimer().then((value) {
      mainScrollController.removeListener(getAllProducts);
      mainScrollController.addListener(getAllProducts);
      getAllProducts();
    });
  }

  getCollections() async {
    GlobalVariable.showLoader.value = true;

    Map<String, String> params = {
      'fields[children]': '1',
      'fields[media]=1': '1',
      'fields[name]': '1',
      'level': '1',
      'limit': '0',
    };

    await ApiBaseHelper()
        .getMethodQueryParam(url: Urls.getCollection, params: params)
        .then((parsedJson) {
      GlobalVariable.showLoader.value = false;
      // clearValues();
      if (parsedJson['success'] == true &&
          parsedJson['data']['items'] != null) {
        var data = parsedJson['data']['items'] as List;

        collectionList.addAll(data.map((e) => CollectionModel.fromJson(e)));
        GlobalVariable.collectionList.addAll(collectionList);
        changeCollection(0);
        getNews();
      }
    }).catchError((e) {
      CommonFunction.debugPrint(e);
    });
  }

  getNews() async {
    Map<String, String> params = {
      'fields[name]': '1',
      'fields[description]': '1',
       'fields[type]': '1',
      'limit': '0',
    };

    await ApiBaseHelper()
        .getMethodQueryParam(url: Urls.getNews, params: params)
        .then((parsedJson) {
      newsList.clear();
      if (parsedJson['success'] == true &&
          parsedJson['data']['items'] != null) {
        var data = parsedJson['data']['items'] as List;
        newsList.addAll(data.map((e) => NewsModel.fromJson(e)));
      }
    }).catchError((e) {
      CommonFunction.debugPrint(e);
    });
  }

  Future getFlashTimer() async {
    Map<String, String> params = {
      'fields[name]': '1',
      'fields[start]': '1',
      'fields[end]': '1',
       'collection': selectedCollectionId,
    };

    await ApiBaseHelper()
        .getMethodQueryParam(url: Urls.getFlashDiscountTimer, params: params)
        .then((parsedJson) {
      discountModel = DiscountModel().obs;
      if (parsedJson['success'] == true &&
          parsedJson['data']['items'] != null) {
        var data = parsedJson['data']['items'] as List;
        if (data.isNotEmpty) {
          discountModel?.value = DiscountModel.fromJson(data[0]);

          //FlashDiscount Products
          if (discountModel?.value.sId != null) {
            getFlashProducts(discountModel!.value.sId!);
          }

          //Start Flash Timer
          if (discountModel?.value.end != null) {
            startTimer(discountModel!.value.end!);
          }
        }
      }
    }).catchError((e) {
      CommonFunction.debugPrint(e);
    });
  }

  getFlashProducts(String discountId) async {
    Map<String, String> params = {
      'limit': '6',
      'fields[name]': '1',
      'fields[image]': '1',
      'fields[quantity]': '1',
      'fields[inStock]': '1',
      'fields[totalReviews]': '1',
      'fields[rating]': '1',
      'fields[price]': '1',
      'fields[store][name]': '1',
      'fields[discount][percentage]': '1',
      // 'collection': selectedCollectionId,
      'discount': discountId,
    };

    await ApiBaseHelper()
        .getMethodQueryParam(url: Urls.getProducts, params: params)
        .then((parsedJson) {
      if (parsedJson['success'] == true &&
          parsedJson['data']['items'] != null) {
        var data = parsedJson['data']['items'] as List;
        flashProductList.addAll(data.map((e) => HomeProductModel.fromJson(e)));
        productList.addAll(data.map((e) => Product.fromJson(e)));
      }
    }).catchError((e) {
      CommonFunction.debugPrint(e);
    });
  }

  getAllProducts() async {
    Map<String, String> params = {
      'limit': '10',
      'fields[name]': '1',
      'fields[image]': '1',
      'fields[quantity]': '1',
      'fields[inStock]': '1',
      'fields[totalReviews]': '1',
      'fields[rating]': '1',
      'fields[price]': '1',
      'fields[store][name]': '1',
      'fields[discount][percentage]': '1',
      // 'collection': selectedCollectionId,
      'page': pageNo.toString(),
    };

    //Get Products Implementation
    if (pageNo == 1
        ? true
        : (mainScrollController.hasClients &&
            mainScrollController.position.maxScrollExtent ==
                mainScrollController.offset)) {
      pageNo++;
      paginationLoader.value = true;

      await ApiBaseHelper()
          .getMethodQueryParam(url: Urls.getProducts, params: params)
          .then((parsedJson) {
        paginationLoader.value = false;
        if (parsedJson['success'] == true &&
            parsedJson['data']['items'] != null) {
          var data = parsedJson['data']['items'] as List;
          if (data.isEmpty || data.length < 10) {
            mainScrollController.removeListener(getAllProducts);
          }
          allProductList.addAll(data.map((e) => HomeProductModel.fromJson(e)));
          productList.addAll(data.map((e) => Product.fromJson(e)));

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
}
