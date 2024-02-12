import 'package:get/get.dart';

import '../../../helpers/global_variables.dart';
import '../order_listing/order_listing_Model.dart';

class OrderDetailViewModel extends GetxController {
  Rx<OrderItem> orderItemModel = OrderItem().obs;
  RxList<Lineitem> lineItemList = <Lineitem>[].obs;

  @override
  void onInit() {
    //orderItemModel.value = Get.arguments['model'];
    lineItemList.addAll(orderItemModel.value.lineitems ?? []);
    super.onInit();
  }

  @override
  void onClose() {
    GlobalVariable.showLoader.value = false;
    super.onClose();
  }
}
