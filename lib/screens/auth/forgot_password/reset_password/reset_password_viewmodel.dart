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

  @override
  void onReady() {
    ///param = Get.arguments;
    super.onReady();
  }

  Map<String, dynamic> _parsedJson = {};
  Future<void> resetPasswordApi() async {
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
            _parsedJson = parsedJson;
            if (parsedJson['success'] == true) {
              gotoNextScreen();
            } else {
              error();
            }
          });
        } else {
          error();
        }
      } catch (e) {
        error();
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

  void error() {
    GlobalVariable.showLoader.value = false;
    CommonFunction.showSnackBar(
      title: "Error",
      message: "${_parsedJson['message']}",
    );
  }
}
