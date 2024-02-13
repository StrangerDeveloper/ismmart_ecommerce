import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../helpers/api_base_helper.dart';
import '../../../../helpers/common_function.dart';
import '../../../../helpers/global_variables.dart';
import '../../../../helpers/urls.dart';
import '../otp_verification/otp_verification_view.dart';

class ForgotPasswordViewModel extends GetxController {
  GlobalKey<FormState> forgotPasswordFormKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();

  @override
  void onReady() {
    emailController.text = Get.arguments ?? "test@gmail.com";

    GlobalVariable.showLoader.value = false;

    super.onReady();
  }

  @override
  void onClose() {
    emailController.dispose();
    GlobalVariable.showLoader.value = false;
    super.onClose();
  }

  Map<String, dynamic> _parsedJson = {};
  void forgotApi() async {
    if (forgotPasswordFormKey.currentState?.validate() ?? false) {
      try {
        Map<String, dynamic> param = {"email": emailController.text};
        GlobalVariable.showLoader.value = true;
        await ApiBaseHelper()
            .postMethod(url: Urls.forgetPassword, body: param)
            .then((parsedJson) {
          _parsedJson = _parsedJson;
          if (parsedJson['success'] == true) {
            gotoNextScreen();
          } else {
            error();
          }
        });
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
    Get.to(() => OtpVerificationView(), arguments: emailController.text);
  }

  void error() {
    GlobalVariable.showLoader.value = false;
    CommonFunction.showSnackBar(
      title: "Error",
      message: "${_parsedJson['message']}",
    );
  }
}
