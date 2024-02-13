import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:ismmart_ecommerce/helpers/api_base_helper.dart';
import 'package:ismmart_ecommerce/helpers/global_variables.dart';

import '../../../helpers/urls.dart';
import '../categorized_products_model.dart';

class CategoryProductsViewModel extends GetxController {

  RxList<Products> categoryProducts = <Products>[].obs;
  RxString categoryID = ''.obs;
  RxString categoryName = ''.obs;
  RxBool reachedLimit = false.obs;
  RxBool loadMore = false.obs;
  RxBool retryCheck = false.obs;
  ScrollController scrollController = ScrollController();
  int limit = 10;
  int page = 0;

  @override
  void onInit() {
    categoryID.value = Get.arguments['id'];
    categoryName.value = Get.arguments['name'];
    scrollController.addListener(() {
      getCategoryProducts();
    });
    getCategoryProducts();
    super.onInit();
  }

  @override
  void onReady() {
    GlobalVariable.showLoader.value = true;
    super.onReady();
  }

  getCategoryProducts() {
    if (reachedLimit.isFalse) {
      if (page == 0 ? true : (scrollController.hasClients &&
          scrollController.position.maxScrollExtent ==
              scrollController.offset)) {

        if(page != 0) {
          loadMore.value = true;
        }

        page++;

        Map<String, String> params = {
          'fields[rating]': '1',
          'fields[totalReviews]': '1',
          'fields[price]': '1',
          'fields[discount][percentage]': '1',
          'fields[name]': '1',
          'fields[inStock]': '1',
          'fields[image]': '1',
          'store': '65b0dc2d9d21c52c7d22f1bf',
          'limit': limit.toString(),
          'page': page.toString(),
        };

        if(categoryID.value == '') {
          params.addAll({
            'onDiscount': 'true',
            'popular': 'true',
          });
        } else {
          params.addAll({
            'collection': categoryID.value
          });
        }

        ApiBaseHelper().getMethodQueryParam(url: categoryID.value == '' ?
        Urls.getProducts : Urls.getCollectionProducts, params: params
        ).then((parsedJson) {
          if(parsedJson['success'] == true) {
            final data = parsedJson['data']['items'] as List;
            GlobalVariable.showLoader.value = false;
            if(data.isNotEmpty) {
              categoryProducts.addAll(data.map((e) => Products.fromJson(e)));
              categoryProducts.refresh();
              loadMore.value = false;
            }
          }
        }).catchError((e) {
          GlobalVariable.showLoader.value = false;
          retryCheck.value = true;
        });
      }
    }
  }
}