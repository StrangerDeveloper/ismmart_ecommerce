import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:ismmart_ecommerce/helpers/global_variables.dart';

class CheckoutViewModel extends GetxController {
  RxString paymentRadioBtn = 'cod'.obs;

  @override
  void onReady() {
    GlobalVariable.token =
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiI2NWNjYWMwYzIwMDA0N2RiODc0NDJmNjIiLCJuYW1lIjoic2FpbWtoYW42ODM3MyIsImlhdCI6MTcwODA2NDk4OSwiZXhwIjoxNzEwNjU2OTg5fQ.cewEOv89887QoLSBIBsH6BA6rgvk4R7t8vIeLaJZcM8';
    // TODO: implement onReady
    super.onReady();
  }
}
