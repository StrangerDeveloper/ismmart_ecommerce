import 'package:get/get.dart';
import 'package:ismmart_ecommerce/screens/profile_details/profile_model.dart';

import '../../helpers/api_base_helper.dart';
import '../../helpers/common_function.dart';
import '../../helpers/global_variables.dart';
import '../../helpers/urls.dart';

class ProfileViewModel extends GetxController {
  Rx<UserProfileModel> userProfileModel = UserProfileModel().obs;

  bool showAppBar = false;
  @override
  void onInit() {
    showAppBar = Get.arguments != null ? Get.arguments['showAppBar'] : false;
    super.onInit();
  }

  @override
  void onReady() {
    getData();
    super.onReady();
  }

  @override
  void onClose() {
    GlobalVariable.showLoader.value = false;
    super.onClose();
  }

  Future<void> getData() async {
    GlobalVariable.showLoader.value = true;
    await ApiBaseHelper().getMethod(url: Urls.getProfile).then((parsedJson) {
      print("profile---------$parsedJson");
      GlobalVariable.showLoader.value = false;
      if (parsedJson['success'] == true &&
          parsedJson['message'] == "Profile fetched successuflly") {
        userProfileModel.value = UserProfileModel.fromJson(parsedJson['data']);
        print(userProfileModel.value);
      }
    }).catchError((e) {
      CommonFunction.debugPrint(e);
    });
  }
}
