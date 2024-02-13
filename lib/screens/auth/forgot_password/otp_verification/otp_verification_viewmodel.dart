import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:ismmart_ecommerce/screens/auth/forgot_password/reset_password/reset_password_view.dart';

import '../../../../helpers/api_base_helper.dart';
import '../../../../helpers/common_function.dart';
import '../../../../helpers/global_variables.dart';
import '../../../../helpers/urls.dart';

class OtpVerificationViwModel extends GetxController {
  TextEditingController otpController = TextEditingController();
  RxString userEmail = ''.obs;
  @override
  void onReady() {
    userEmail.value = Get.arguments;
    startTimer();
  }

  RxString hours = '00'.obs;
  RxString minutes = '00'.obs;
  RxString seconds = '00'.obs;
  Timer? timer;

  //-------- Timer Show For OTP ---------
  startTimer() {
    /// Calculate duration

    // DateTime dateTime =
    //     DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'").parseUtc(endTime).toLocal();
    // DateTime currentTime = DateTime.now();
    int diffInSeconds = 180;
    // dateTime.difference(currentTime).inSeconds;

    if (diffInSeconds > 0) {
      Duration duration = Duration(seconds: diffInSeconds);
      timer = Timer.periodic(const Duration(seconds: 1), (flashSaleTimer) {
        duration = Duration(seconds: duration.inSeconds - 1);
        String twoDigits(int n) => n.toString().padLeft(2, "0");
        hours.value = twoDigits(duration.inHours);
        minutes.value = twoDigits(duration.inMinutes.remainder(60));
        seconds.value = twoDigits(duration.inSeconds.remainder(60));

        if (duration.inSeconds == 0) {
          flashSaleTimer.cancel();
        }
      });
    }
  }

  //------- Api Call for OTP Verify ------
  Map<String, dynamic> _parsedJson = {};
  Future<void> otpConfirmApi() async {
    try {
      Map<String, dynamic> param = {"otp": otpController.text, 'verify': true};
      CommonFunction.debugPrint("eeeee $param");
      GlobalVariable.showLoader.value = true;

      await ApiBaseHelper()
          .putMethod(url: Urls.resetPassword, body: param)
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

  void gotoNextScreen() {
    GlobalVariable.showLoader.value = false;
    CommonFunction.showSnackBar(
      title: "success",
      message: "Reset Password Link send to your Email",
    );
    var param = {'otp': otpController.text, 'email': userEmail.value};
    Get.to(() => ResetPasswordView(), arguments: param);
  }

  void error() {
    GlobalVariable.showLoader.value = false;
    CommonFunction.showSnackBar(
      title: "Error",
      message: "${_parsedJson['message']}",
    );
  }
}
