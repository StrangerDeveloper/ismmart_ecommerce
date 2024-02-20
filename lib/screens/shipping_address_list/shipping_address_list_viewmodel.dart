import 'package:get/get.dart';
import 'package:ismmart_ecommerce/helpers/api_base_helper.dart';
import 'package:ismmart_ecommerce/helpers/global_variables.dart';
import 'package:ismmart_ecommerce/helpers/urls.dart';
import 'package:ismmart_ecommerce/screens/shipping_address_list/shipingAdress_model.dart';

import '../../helpers/common_function.dart';

class ShippingAddressListViewModel extends GetxController {
  @override
  void onReady() {
    getLocationListApi();

    // TODO: implement onReady
    super.onReady();
  }

  RxList<ShippingAdressModel> shippingAddrList = <ShippingAdressModel>[].obs;
  RxInt checkIndex = 0.obs;
  RxBool isEditShippingAdrr = false.obs;
  RxMap<String, String> selectedAdress =
      {"name": "test", "adress": "adr", "country": "c"}.obs;

  //------Get location List-----------
  var _parsedJson;
  Future<void> getLocationListApi() async {
    shippingAddrList.clear();
    print("location List Api Call  -------- >>>> $shippingAddrList");
    GlobalVariable.showLoader.value = true;
    ApiBaseHelper().getMethod(url: Urls.getShippingAdress).then((parsedJson) {
      GlobalVariable.showLoader.value = false;
      _parsedJson = parsedJson;
      if (parsedJson['success'] == true &&
          parsedJson['data']['items'] != null) {
        var data = parsedJson['data']['items'] as List;
        shippingAddrList
            .addAll(data.map((e) => ShippingAdressModel.fromJson(e)));
      } else {
        error();
      }
    });
  }

  void error() {
    CommonFunction.showSnackBar(
      title: "Error",
      message: _parsedJson['message'],
    );

    GlobalVariable.showLoader.value = false;
  }
}
