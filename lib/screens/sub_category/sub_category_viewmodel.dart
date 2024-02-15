import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ismmart_ecommerce/screens/sub_category/filter_model.dart';
import 'package:ismmart_ecommerce/screens/sub_category/sub_category_model.dart';

import '../../helpers/api_base_helper.dart';
import '../../helpers/common_function.dart';
import '../../helpers/global_variables.dart';
import '../../helpers/urls.dart';
import '../product_details/product_model.dart';

class SubCategoryViewModel extends GetxController {
  String parentId = '';

  //subCategory
  RxInt selectedSubCategoryIndex = 0.obs;
  List<SubCategoryModel> subCategoriesList = <SubCategoryModel>[].obs;

  //products
  ScrollController scrollController = ScrollController();
  int pageNo = 0;
  RxBool paginationLoader = false.obs;
  RxBool showListLoader = false.obs;
  Map<String, String> getProductsParams = {
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
  };
  List<Product> productList = <Product>[].obs;

  //filtration
  FilterModel filterModel = FilterModel();
  RxBool newArrivalValue = false.obs;
  RxString sortValue = ''.obs;
  RxBool topRatedValue = false.obs;
  RxDouble ratingTempValue = 0.0.obs;
  double ratingFilterValue = 0.0;
  RxDouble priceSliderMaxLimit = 0.0.obs;
  RxDouble filterStartPrice = 0.0.obs;
  RxDouble filterEndPrice = 0.0.obs;

  @override
  void onInit() {
    parentId = Get.arguments['id'];
    super.onInit();
  }

  @override
  void onReady() {
    getSubCategories();

    super.onReady();
  }

  getFilterSetting() async {
    GlobalVariable.showLoader.value = true;

    Map<String, String> params = {
      'collection': subCategoriesList[selectedSubCategoryIndex.value].sId ?? '',
    };

    await ApiBaseHelper()
        .getMethodQueryParam(url: Urls.getFilterSetting, params: params)
        .then((parsedJson) {
      GlobalVariable.showLoader.value = false;
      // clearValues();
      if (parsedJson['success'] == true && parsedJson['data'] != null) {
        filterModel = FilterModel.fromJson(parsedJson['data']);
        priceSliderMaxLimit.value = double.tryParse(filterModel.price!.max.toString()) ?? 0.0;
        filterEndPrice.value = priceSliderMaxLimit.value;
      }
    }).catchError((e) {
      CommonFunction.debugPrint(e);
    });
  }

  getSubCategories() async {
    GlobalVariable.showLoader.value = true;

    Map<String, String> params = {
      'fields[children]': '1',
      'fields[media]=1': '1',
      'fields[name]': '1',
      'limit': '0',
      'parent': parentId
    };

    await ApiBaseHelper()
        .getMethodQueryParam(url: Urls.getCollection, params: params)
        .then((parsedJson) {
      GlobalVariable.showLoader.value = false;
      // clearValues();
      if (parsedJson['success'] == true &&
          parsedJson['data']['items'] != null) {
        var data = parsedJson['data']['items'] as List;
        subCategoriesList.addAll(data.map((e) => SubCategoryModel.fromJson(e)));
        getProductsFromStart();
        getFilterSetting();
      }
    }).catchError((e) {
      CommonFunction.debugPrint(e);
    });
  }

  changeSubCategory(int index) {
    selectedSubCategoryIndex.value = index;
    getProductsFromStart();
  }

  getProductsFromStart() async {
    getProductsParams['collection'] =
        subCategoriesList[selectedSubCategoryIndex.value].sId ?? '';

    pageNo = 0;
    productList.clear();
    scrollController.removeListener(getProducts);
    showListLoader.value = true;
    if (!scrollController.hasListeners) {
      scrollController = ScrollController();
      scrollController.addListener(getProducts);
    }
    await getProducts();
    showListLoader.value = false;
  }

  getProducts() async {
    if (pageNo == 0
        ? true
        : (scrollController.hasClients &&
            scrollController.position.maxScrollExtent ==
                scrollController.offset)) {
      pageNo++;
      paginationLoader.value = true;

      getProductsParams['page'] = pageNo.toString();

      await ApiBaseHelper()
          .getMethodQueryParam(url: Urls.getProducts, params: getProductsParams)
          .then((parsedJson) {
        if (parsedJson['success'] == true &&
            parsedJson['data']['items'] != null) {
          var data = parsedJson['data']['items'] as List;
          productList.addAll(data.map((e) => Product.fromJson(e)));
          if (data.isEmpty || data.length < 10) {
            scrollController.removeListener(getProducts);
          }
          paginationLoader.value = false;
        }
      }).catchError((e) {
        CommonFunction.debugPrint(e);
      });
    }
  }

  //Filtration
  sortSelection(String value) {
    sortValue.value = value;
    if (value == 'ascending') {
      getProductsParams['sort["price]'] = '1';
    } else if (value == 'descending') {
      getProductsParams['sort["price]'] = '-1';
    } else {
      getProductsParams.remove('sort["price]');
    }
    getProductsFromStart();
  }

  newArrivalSelection() {
    newArrivalValue.value = !newArrivalValue.value;
    if (newArrivalValue.value) {
      getProductsParams['sort["createdAt]'] = '1';
    } else {
      getProductsParams.remove('sort["createdAt]');
    }
    getProductsFromStart();
  }

  topRatedSelection() {
    topRatedValue.value = !topRatedValue.value;
    if (topRatedValue.value) {
      getProductsParams['sort["rating]'] = '1';
    } else {
      getProductsParams.remove('sort["rating]');
    }
    getProductsFromStart();
  }

  applyFilterBtn() {
    Get.back();
    //Rating
    ratingFilterValue = ratingTempValue.value;
    if (ratingFilterValue != 0.0) {
      getProductsParams['rating'] = ratingFilterValue.toString();
    } else {
      getProductsParams.remove('rating');
    }

    //Price
    if (filterEndPrice.value != 0.0) {
      getProductsParams['price[min]'] = filterStartPrice.value.toString();
      getProductsParams['price[max]'] = filterEndPrice.value.toString();
    }

    getProductsFromStart();
  }

  clearBtn() {
    Get.back();
    ratingFilterValue = 0.0;
    ratingTempValue.value = 0.0;

    if (filterEndPrice.value != 0.0) {
      filterStartPrice.value = 0.0;
      filterEndPrice.value = priceSliderMaxLimit.value;
      getProductsParams['price[min]'] = filterStartPrice.value.toString();
      getProductsParams['price[max]'] = filterEndPrice.value.toString();
    }
    getProductsFromStart();
  }
}
