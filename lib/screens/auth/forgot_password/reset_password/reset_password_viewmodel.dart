import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ismmart_ecommerce/helpers/app_routes.dart';

import '../../../../helpers/api_base_helper.dart';
import '../../../../helpers/common_function.dart';
import '../../../../helpers/global_variables.dart';
import '../../../../helpers/urls.dart';

class ResetPasswordViewModel extends GetxController {
  GlobalKey<FormState> resetPasswordFormKey = GlobalKey<FormState>();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  RxBool obscurePassword = true.obs;
  //Map<String, dynamic> param = <String, dynamic>{};
  //var param;
  @override
  void onReady() {
    ///param = Get.arguments;
    super.onReady();
  }

  Future<void> resetPswordApi() async {
    if (resetPasswordFormKey.currentState?.validate() ?? false) {
      try {
        if (Get.arguments != null) {
          Map<String, dynamic> param = Get.arguments;

          param['new_password'] = passwordController.text;
          param['confirm_password'] = confirmPasswordController.text;

          CommonFunction.debugPrint("eeeee $param");

          GlobalVariable.showLoader.value = true;

          await ApiBaseHelper()
              .putMethod(url: Urls.resetPassword, body: param)
              .then((parsedJson) {
            if (parsedJson['success'] == true) {
              gotoNextScreen();
            } else {
              error(parsedJson['message']);
            }
          });
        } else {
          error('Arguments are null');
        }
      } catch (e) {
        error(e.toString());
      }
    }
  }

  void gotoNextScreen() {
    GlobalVariable.showLoader.value = false;
    CommonFunction.showSnackBar(
      title: "success",
      message: "Reset Password Link send to your Email",
    );
    Get.toNamed(AppRoutes.successViewRoute);
  }

  void error(String message) {
    GlobalVariable.showLoader.value = false;
    CommonFunction.showSnackBar(
      title: "Error",
      message: message,
    );
  }
}
