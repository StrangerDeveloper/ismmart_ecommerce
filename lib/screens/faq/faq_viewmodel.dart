import 'package:get/get.dart';
import 'package:ismmart_ecommerce/helpers/api_base_helper.dart';
import 'package:ismmart_ecommerce/helpers/global_variables.dart';
import 'package:ismmart_ecommerce/helpers/urls.dart';
import 'package:ismmart_ecommerce/screens/faq/faq_model.dart';

class FaqViewModel extends GetxController {
  List<FaqModel> faqsList = <FaqModel>[].obs;

  @override
  void onReady() {
    getData();
    super.onReady();
  }

  getData() {
    GlobalVariable.showLoader.value = true;

    ApiBaseHelper()
        .getMethod(url: Urls.getFAQs)
        .then((parsedJson) {
      GlobalVariable.showLoader.value = false;
      if (parsedJson['success'] == true) {
        var data = parsedJson['data'] as List;
        faqsList.addAll(data.map((e) => FaqModel.fromJson(e)));
      }
    }).catchError((e) {
      GlobalVariable.showLoader.value = false;
    });
  }
}
