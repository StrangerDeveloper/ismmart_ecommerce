import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ismmart_ecommerce/screens/sub_category/sub_category_model.dart';

import '../../helpers/api_base_helper.dart';
import '../../helpers/common_function.dart';
import '../../helpers/global_variables.dart';
import '../../helpers/urls.dart';
import '../product_details/product_model.dart';

class SubCategoryViewModel extends GetxController {
  String subCategoryId = '';
  RxInt selectedSubCategoryIndex = 0.obs;
  List<SubCategoryModel> subCategoriesList = <SubCategoryModel>[].obs;
  List<Product> productList = <Product>[].obs;

  //products
  ScrollController scrollController = ScrollController();
  int pageNo = 0;
  RxBool paginationLoader = false.obs;
  RxBool showListLoader = false.obs;

  //filtration
  RxBool newArrivalValue = false.obs;
  RxString sortValue = 'top-to-bottom'.obs;
  RxBool topRatedValue = false.obs;

  @override
  void onInit() {
    subCategoryId = Get.arguments['id'];
    super.onInit();
  }

  @override
  void onReady() {
    getSubCategories();
    super.onReady();
  }

  sortSelection(String value) {
    sortValue.value = value;
    // if (value == 'all') {
    //   radioBtnUrlValue = '';
    // } else {
    //   radioBtnUrlValue = '&status=$value';
    // }
  }

  //for testing purpose...
  getSubCategories() async {
    GlobalVariable.showLoader.value = true;

    Map<String, String> params = {
      'fields[children]': '1',
      'fields[media]=1': '1',
      'fields[name]': '1',
      'limit': '0',
      'parent': subCategoryId
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
        getDataFromStart();
      }
    }).catchError((e) {
      CommonFunction.debugPrint(e);
    });
  }

  changeSubCategory(int index) {
    selectedSubCategoryIndex.value = index;
    getDataFromStart();
  }

  getDataFromStart() async {
    pageNo = 0;
    productList.clear();
    scrollController.removeListener(getData);
    showListLoader.value = true;
    if (!scrollController.hasListeners) {
      scrollController = ScrollController();
      scrollController.addListener(getData);
    }
    await getData();
    showListLoader.value = false;
  }

  getData() async {
    if (pageNo == 0
        ? true
        : (scrollController.hasClients &&
            scrollController.position.maxScrollExtent ==
                scrollController.offset)) {
      pageNo++;
      paginationLoader.value = true;

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
        'collection':
            subCategoriesList[selectedSubCategoryIndex.value].sId ?? '',
        'page': pageNo.toString(),
      };

      await ApiBaseHelper()
          .getMethodQueryParam(url: Urls.getProducts, params: params)
          .then((parsedJson) {
        if (parsedJson['success'] == true &&
            parsedJson['data']['items'] != null) {
          var data = parsedJson['data']['items'] as List;
          productList.addAll(data.map((e) => Product.fromJson(e)));
          if (data.isEmpty || data.length < 10) {
            scrollController.removeListener(getData);
          }
          paginationLoader.value = false;
        }
      }).catchError((e) {
        CommonFunction.debugPrint(e);
      });
    }
  }
}
