import 'dart:io';

import 'package:get/get.dart';

class SingupViewModel extends GetxController {
  Rx<File> cnicFrontImage = File('').obs;
  RxBool cnicFrontImageErrorVisibility = false.obs;
}
