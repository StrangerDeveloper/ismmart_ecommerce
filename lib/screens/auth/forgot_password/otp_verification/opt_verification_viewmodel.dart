import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class OtpVerificationViwModel extends GetxController
    with GetTickerProviderStateMixin {
  RxInt counter = 5.obs;
  Timer? timer;
  timerFunc() {
    Timer.periodic(const Duration(seconds: 1), (timer) {
      print(counter.value);
      if (counter.value <= 0) {
        timer.cancel();
      } else {
        counter.value--;
      }
    });
  }

  @override
  void onReady() {
    // TODO: implement onReady
    timerFunc();
  }
}
