import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ismmart_ecommerce/helpers/api_base_helper.dart';
import 'package:ismmart_ecommerce/screens/vendor_store/models/categories_model.dart';
import 'package:ismmart_ecommerce/screens/vendor_store/models/popular_product_model.dart';
import '../../helpers/urls.dart';
import 'models/categorized_products_model.dart';

class VendorStoreViewModel extends GetxController with GetTickerProviderStateMixin{

  ScrollController scrollController = ScrollController();
  PageController pageController = PageController();
  PageController sliderImagesController = PageController();
  late TabController tabController = TabController(length: 2, vsync: this);

  RxInt sliderIndex = 0.obs;
  late Timer? timer;
  RxBool isSliderLoading = true.obs;
  RxBool fetchingCategories = true.obs;
  RxBool noSliderImages = false.obs;
  RxBool isCategoriesLoading = false.obs;
  RxBool noCategoriesFound = false.obs;
  RxList<Product> categoryProducts = <Product>[
    Product(id: "0", name: 'TMA-2 HD Wireless', imageURL: '', actualPrice: 1000, discountedPrice: 900, reviewsNumber: 85, reviewStar: 4.5),
    Product(id: "1", name: 'TMA-2 HD Wireless', imageURL: '', actualPrice: 1200, discountedPrice: 800, reviewsNumber: 20, reviewStar: 4.1),
    Product(id: "0", name: 'TMA-2 HD Wireless', imageURL: '', actualPrice: 1000, discountedPrice: 900, reviewsNumber: 85, reviewStar: 4.5),
    Product(id: "1", name: 'TMA-2 HD Wireless', imageURL: '', actualPrice: 1200, discountedPrice: 800, reviewsNumber: 20, reviewStar: 4.1),
    Product(id: "0", name: 'TMA-2 HD Wireless', imageURL: '', actualPrice: 1000, discountedPrice: 900, reviewsNumber: 85, reviewStar: 4.5),
    Product(id: "1", name: 'TMA-2 HD Wireless', imageURL: '', actualPrice: 1200, discountedPrice: 800, reviewsNumber: 20, reviewStar: 4.1),
    Product(id: "0", name: 'TMA-2 HD Wireless', imageURL: '', actualPrice: 1000, discountedPrice: 900, reviewsNumber: 85, reviewStar: 4.5),
    Product(id: "1", name: 'TMA-2 HD Wireless', imageURL: '', actualPrice: 1200, discountedPrice: 800, reviewsNumber: 20, reviewStar: 4.1),
  ].obs;
  RxList<VendorProductCategories> categoriesList = <VendorProductCategories>[].obs;
  RxList<PopularProductModel> sliderImages = <PopularProductModel>[].obs;
  RxList<CategorizedProductsModel> lists = <CategorizedProductsModel>[
    CategorizedProductsModel(
      categoryName: 'Tech and Gears',
      productList: [
        Product(
          id: "0",
          name: 'TMA-2 HD Wireless',
          imageURL: '',
          actualPrice: 1000,
          discountedPrice: 900,
          reviewsNumber: 85,
          reviewStar: 4.5
        ),
        Product(
            id: "1",
            name: 'TMA-2 HD Wireless',
            imageURL: '',
            actualPrice: 1200,
            discountedPrice: 800,
            reviewsNumber: 20,
            reviewStar: 4.1
        ),
      ]
    ),
    CategorizedProductsModel(
        categoryName: 'Shoes',
        productList: [
          Product(
              id: "0",
              name: 'Air Jordan',
              imageURL: '',
              actualPrice: 1000,
              discountedPrice: 900,
              reviewsNumber: 10,
              reviewStar: 5
          ),
          Product(
              id: "1",
              name: 'Air Max',
              imageURL: '',
              actualPrice: 1200,
              discountedPrice: 800,
              reviewsNumber: 45,
              reviewStar: 3.5
          ),
        ]
    ),
  ].obs;

  @override
  void onInit() {
    getSliderProducts();
    getVendorProductsCategories();
    super.onInit();
  }

  @override
  void onReady() {

    super.onReady();
  }

  void runSliderTimer() {
    isSliderLoading.value = false;
    timer = Timer.periodic(const Duration(seconds: 3), (Timer timer) {
      if (sliderIndex.value < sliderImages.length - 1) {
        sliderIndex.value = sliderIndex.value + 1;
      } else {
        sliderIndex.value = 0;
      }
      if (sliderImagesController.hasClients) {
        sliderImagesController.animateToPage(
          sliderIndex.value,
          duration: const Duration(milliseconds: 350),
          curve: Curves.easeInOutCubicEmphasized,
        );
      }
    });
  }
  
  getSliderProducts() {
    ApiBaseHelper().getMethod(url: Urls.getSliderProducts).then((parsedJson) {
      if(parsedJson['success'] == true) {
        final data = parsedJson['data']['items'] as List;
        if(data.isNotEmpty) {
          sliderImages.addAll(data.map((e) => PopularProductModel.fromJson(e)));
          sliderImages.refresh();
          runSliderTimer();
        } else {
          noSliderImages.value = true;
        }
      }
    }).catchError((e) {

    });
  }

  getVendorProductsCategories() {
    ApiBaseHelper().getMethod(url: Urls.getVendorProductsCategories).then((parsedJson) {
      if(parsedJson['success'] == true) {
        final data = parsedJson['data']['items'] as List;
        if(data.isNotEmpty) {
          categoriesList.addAll(data.map((e) => VendorProductCategories.fromJson(e)));
          categoriesList.refresh();
          fetchingCategories.value = false;
        } else {
          noCategoriesFound.value = true;
        }
      }
    }).catchError((e) {});
  }

  getVendorProducts() {

  }
}