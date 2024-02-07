import 'package:get/get.dart';
import 'package:ismmart_ecommerce/screens/user_profile/user_profile_model.dart';

import '../../helpers/global_variables.dart';

class UserProfileViewModel extends GetxController {
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

  getData() async {
    // GlobalVariable.showLoader.value = true;
    // await ApiBaseHelper().getMethod(url: Urls.getUserData).then((parsedJson) {
    //   GlobalVariable.showLoader.value = false;
    //   if (parsedJson['success'] == true &&
    //       parsedJson['message'] == "Profile fetched successuflly") {
    //     userProfileModel.value = UserProfileModel.fromJson(parsedJson['data']);
    //   }
    // }).catchError((e) {
    //   CommonFunction.debugPrint(e);
    // });
  }
}
