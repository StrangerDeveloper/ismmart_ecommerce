import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ismmart_ecommerce/screens/auth/forgot_password/reset_password/success_view.dart';
import 'package:ismmart_ecommerce/screens/auth/login/login_view.dart';

import '../../../../helpers/api_base_helper.dart';
import '../../../../helpers/common_function.dart';
import '../../../../helpers/global_variables.dart';
import '../../../../helpers/urls.dart';

class ResetPasswordViewModel extends GetxController {
  GlobalKey<FormState> resetPasswordFormKey = GlobalKey<FormState>();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  RxBool obscurePassword = true.obs;
  var param;
  @override
  void onReady() {
    param = Get.arguments;
    // TODO: implement onReady
    super.onReady();
  }

  Map<String, dynamic> parsedJson = {};
  Future<void> resetPswordApi() async {
    if (resetPasswordFormKey.currentState?.validate() ?? false) {
      try {
        Map<String, dynamic> _param = param;
        param['new_password'] = passwordController.text;
        param['confirm_password'] = confirmPasswordController.text;

        print("eeeee ${_param}");
        GlobalVariable.showLoader.value = true;
        parsedJson = await ApiBaseHelper()
            .putMethod(url: Urls.resetPassword, body: _param);
        if (parsedJson['success'] == true) {
          gotoNextScreen();
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
    Get.to(() => SuccessView());
  }

  void error() {
    GlobalVariable.showLoader.value = false;
    CommonFunction.showSnackBar(
      title: "Error",
      message: "${parsedJson['message']}",
    );
  }
}
