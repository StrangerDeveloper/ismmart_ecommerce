import 'package:get/get.dart';

class GlobalVariable {
  static String token =
      'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiI2NTc4MDlkNjYzNTM0ZTNmY2ZiMTljNzIiLCJuYW1lIjoic3llZCBXYWplZWggQWhzYW4gIiwiaWF0IjoxNzA0OTY5NDg0LCJleHAiOjE3MDc1NjE0ODR9.0ObCFtDKGu-omkTGtGTuAHpX9IoLVSaDjmsO23lXbkU';
  // static String token = "";
  static RxBool showLoader = false.obs;
  static RxBool noInternet = false.obs;
  static RxInt selectedIndex = 0.obs;
}
