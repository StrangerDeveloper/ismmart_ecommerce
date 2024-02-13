import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ismmart_ecommerce/helpers/api_base_helper.dart';
import 'package:ismmart_ecommerce/helpers/global_variables.dart';
import '../../helpers/urls.dart';
import 'categorized_products_model.dart';

class VendorStoreViewModel extends GetxController with GetTickerProviderStateMixin{

  ScrollController scrollController = ScrollController();
  PageController pageController = PageController();
  PageController sliderImagesController = PageController();
  late TabController tabController = TabController(length: 2, vsync: this);

  RxInt sliderIndex = 0.obs;
  late Timer? timer;
  RxBool isSliderLoading = true.obs;
  RxBool fetchingCategories = true.obs;
  RxBool isCategoriesLoading = false.obs;
  RxBool fetchingProducts = true.obs;
  RxBool noMoreRecords = false.obs;
  RxBool productsRetryCheck = false.obs;
  RxString storeLogoUrl = ''.obs;
  RxString storeName = ''.obs;
  RxList<Products> categoryProducts = <Products>[].obs;
  RxList<CategorizedProductsModel> categoriesList = <CategorizedProductsModel>[].obs;
  RxList<Products> sliderImages = <Products>[].obs;
  RxList<CategorizedProductsModel> homePageProductsList = <CategorizedProductsModel>[].obs;
  RxList<CategorizedProductsModel> allProductsPageProductList = <CategorizedProductsModel>[].obs;
  RxBool loadMore = false.obs;

  int limit = 10;
  int page = 0;

  @override
  void onInit() {
    getVendorStoreDetails();
    getSliderProducts();
    getVendorProductsCategories();
    scrollController.addListener(() {
      getVendorProducts();
    });
    getVendorProducts();
    super.onInit();
  }

  @override
  void onReady() {
    GlobalVariable.showLoader.value = true;
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
  
  getVendorStoreDetails() {

    Map<String, String> params = {
      'fields[name]': '1',
      'fields[logo]': '1',
      'id': '65b0dc2d9d21c52c7d22f1bf'
    };

    ApiBaseHelper().getMethodQueryParam(url: Urls.getVendorStoreDetails, params: params).then((parsedJson) {
      GlobalVariable.showLoader.value = false;
      if(parsedJson['success'] == true){
        storeLogoUrl.value = parsedJson['data']['items'][0]['logo'];
        storeName.value = parsedJson['data']['items'][0]['name'];
      }
    });
  }
  
  getSliderProducts() {

    Map<String, String> params = {
      'limit': '3',
      'popular': 'true',
      'store': '65b0dc2d9d21c52c7d22f1bf',
      'fields[name]': '1',
      'fields[image]': '1',
      'fields[id]': '1'
    };

    ApiBaseHelper().getMethodQueryParam(url: Urls.getProducts, params: params).then((parsedJson) {
      if(parsedJson['success'] == true) {
        final data = parsedJson['data']['items'] as List;
        if(data.isNotEmpty) {
          sliderImages.addAll(data.map((e) => Products.fromJson(e)));
          sliderImages.refresh();
          runSliderTimer();
        }
      }
    }).catchError((e) {

    });
  }
  
  getPopularDeals() {

    Map<String, String> params = {
      'onDiscount':'true',
      'popular': 'true',
      'fields[rating]': '1',
      'fields[reviews]': '1',
      'fields[price]': '1',
      'fields[discount]': '1',
      'fields[name]': '1',
      'fields[image]': '1',
      'store': '65b0dc2d9d21c52c7d22f1bf',
      'limit': '2'
    };

    ApiBaseHelper().getMethodQueryParam(url: Urls.getProducts, params: params).then((parsedJson) {
      if(parsedJson['success'] == true) {
        final data = parsedJson['data']['items'] as List;
        fetchingProducts.value = false;
        if(data.isNotEmpty) {
          homePageProductsList.insert(0, CategorizedProductsModel(
            name: 'Most Popular Deals',
            products: [],
          ));
          homePageProductsList[0].products?.addAll(data.map((e) => Products.fromJson(e)));
          homePageProductsList.refresh();
        } else if(homePageProductsList.isEmpty){
          noMoreRecords.value = true;
        }
      }
    });
  }

  getVendorProductsCategories() {

    Map<String, String> params = {
      'limit':'0',
      'fields[name]':'1',
      'store':'65b0dc2d9d21c52c7d22f1bf',
      'fields[media]':'1'
    };

    ApiBaseHelper().getMethodQueryParam(url: Urls.getCollection, params: params).then((parsedJson) {
      if(parsedJson['success'] == true) {
        final data = parsedJson['data']['items'] as List;
        fetchingCategories.value = false;
        if(data.isNotEmpty) {
          categoriesList.addAll(data.map((e) => CategorizedProductsModel.fromJson(e)));
          categoriesList.refresh();
        }
      }
    }).catchError((e) {});
  }

  getVendorProducts() {
    if(noMoreRecords.isFalse){
      if (page == 0
          ? true
          : (scrollController.hasClients &&
          scrollController.position.maxScrollExtent ==
              scrollController.offset)) {

        if (page != 0) {
          loadMore.value = true;
        }

        page++;

        Map<String, String> params = {
          'page': page.toString(),
          'limit': limit.toString(),
          'fields[name]': '1',
          'group': 'true',
          'fields[products][name]': '1',
          'fields[products][rating]': '1',
          'fields[products][reviews]': '1',
          'fields[products][image]': '1',
          'fields[products][discount]': '1',
          'fields[products][_id]': '1',
          'fields[products][price]': '1',
          'store': '65b0dc2d9d21c52c7d22f1bf'
        };

        ApiBaseHelper()
            .getMethodQueryParam(
            url: Urls.getProducts, params: params)
            .then((parsedJson) {
          if (parsedJson['success'] == true) {
            final data = parsedJson['data']['items'] as List;
            if(page == 1) {
              getPopularDeals();
            }
            if (data.isNotEmpty) {
              homePageProductsList.addAll(data.map((e) => CategorizedProductsModel.fromJson(e)));
              allProductsPageProductList.addAll(data.map((e) => CategorizedProductsModel.fromJson(e)));
              homePageProductsList.refresh();
              allProductsPageProductList.refresh();
              loadMore.value = false;
            }
          }
        }).catchError((e) {
          productsRetryCheck.value = true;
        });
      }
    }
  }
}