import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../helpers/api_base_helper.dart';
import '../../../../helpers/common_function.dart';
import '../../../../helpers/global_variables.dart';
import '../../../../helpers/urls.dart';

class ForgotPasswordViewModel extends GetxController {
  GlobalKey<FormState> forgotPasswordFormKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  Map<String, dynamic> parsedJson = {};

  @override
  void onReady() {
    GlobalVariable.showLoader.value = false;
    emailController.text = Get.arguments['email'] ?? "test@gmail.com";

    super.onReady();
  }

  @override
  void onClose() {
    emailController.dispose();
    GlobalVariable.showLoader.value = false;
    super.onClose();
  }

  void sendBtn() async {
    if (forgotPasswordFormKey.currentState?.validate() ?? false) {
      try {
        Map<String, dynamic> param = {"email": emailController.text};
        GlobalVariable.showLoader.value = true;
        parsedJson = await ApiBaseHelper()
            .postMethod(url: Urls.forgetPassword, body: param);

        if (parsedJson['success'] == true) {
          GlobalVariable.showLoader.value = false;
          CommonFunction.showSnackBar(
            title: "success",
            message: "Reset Password Link send to your Email",
          );
          Future.delayed(const Duration(seconds: 3), () => Get.back());
        } else {
          GlobalVariable.showLoader.value = false;
          CommonFunction.showSnackBar(
            title: "succErroress",
            message: "${parsedJson['message']}",
          );
        }
      } catch (e) {
        GlobalVariable.showLoader.value = false;
        CommonFunction.showSnackBar(
          title: "Error",
          message: "${parsedJson['message']}",
        );
      }
    }
  }
}
