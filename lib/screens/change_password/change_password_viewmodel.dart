import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:ismmart_ecommerce/helpers/api_base_helper.dart';
import 'package:ismmart_ecommerce/helpers/common_function.dart';
import 'package:ismmart_ecommerce/helpers/global_variables.dart';

import '../../helpers/urls.dart';

class ChangePasswordViewModel extends GetxController{

  /// TextEditingControllers and Global Key
  TextEditingController currentPasswordController = TextEditingController();
  TextEditingController newPasswordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  /// Obscure Password variables
  RxBool obscureCurrentPassword = true.obs;
  RxBool obscureNewPassword = true.obs;
  RxBool obscureConfirmPassword = true.obs;

  /// General Variables
  RxBool isFocused = false.obs;

  @override
  void onClose() {
    disposeControllers();
    super.onClose();
  }

  validateCharacterLength(String? value) {
    if(value == null || value == '' || value.isEmpty) {
      return 'Field cannot be empty';
    } else if(value.length < 6){
      return 'Password must be 6 characters long';
    } else {
      return null;
    }
  }

  changePassword() {

    FocusManager.instance.primaryFocus?.unfocus();
    GlobalVariable.showLoader.value = true;

    Map<String, dynamic> params = {
      "old_password": currentPasswordController.text,
      "new_password": newPasswordController.text,
      "confirm_password": confirmPasswordController.text
    };

    ApiBaseHelper().putMethod(url: Urls.resetPassword, body: params).then((parsedJson) {
      if(parsedJson['success'] == true) {
        GlobalVariable.showLoader.value = false;
        Get.back();
        CommonFunction.showSnackBar(
          title: 'Success',
          message: 'Password changes successfully'
        );
      } else {
        GlobalVariable.showLoader.value = false;
        CommonFunction.showSnackBar(
          title: 'Error',
          message: parsedJson['message']
        );
      }
    }).catchError((e) {
      GlobalVariable.showLoader.value = false;
      CommonFunction.showSnackBar(title: 'Error', message: 'Couldn\'t change password. Retry');
    });
  }

  disposeControllers() {
    currentPasswordController.dispose();
    newPasswordController.dispose();
    confirmPasswordController.dispose();
  }
}