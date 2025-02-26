import 'dart:io';
import 'package:get/get.dart';

import '../../../screens/order/order_details/order_detail_model.dart';
import '../../../helpers/api_base_helper.dart';
import '../../../helpers/common_function.dart';
import '../../../helpers/global_variables.dart';
import '../../../helpers/urls.dart';

class OrderDetailViewModel extends GetxController {
  Rx<File> userProfileImage = File('').obs;
  Rx<OrderItemIdModel> orderItemModel = OrderItemIdModel().obs;
  RxList<Lineitems> lineItemList = <Lineitems>[].obs;
  RxString itemId = ''.obs;
  @override
  void onInit() {
    if (Get.arguments['itemId'] != null) {
      itemId.value = Get.arguments['itemId'];
    }
    getaorderById();
    super.onInit();
  }

  Future<void> getaorderById() async {
    Map<String, String> params = {
      "id": itemId.value,
    };
    await ApiBaseHelper()
        .getMethodQueryParam(url: Urls.getOrders, params: params)
        .then((response) {
      var data = response['data']['items'][0]['lineitems'] as List;

      if (response['success'] == true) {
        GlobalVariable.showLoader.value = false;
        lineItemList.clear();
        lineItemList.addAll(data.map((e) => Lineitems.fromJson(e)));
        orderItemModel.value =
            OrderItemIdModel.fromJson(response['data']['items'][0]);
      } else {
        CommonFunction.showSnackBar(
            title: 'Error', message: response['message']);
      }
    });
  }

  @override
  void onClose() {
    GlobalVariable.showLoader.value = false;
    super.onClose();
  }
}
