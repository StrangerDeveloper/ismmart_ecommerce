import 'package:get/get.dart';

class GlobalVariable {
  static String token =
      'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiI2NThkNWVhY2QyMjViNjM0NzJiZWU1YzIiLCJuYW1lIjoiaGFzbmFpbiIsImlhdCI6MTcwNjI2Mzk5NCwiZXhwIjoxNzA4ODU1OTk0fQ.x0hgmcnU7uP7GgEZC5OT2BGI22G8HE3ZC_JyBEt9PTk';
  // static String token = "";
  static RxBool showLoader = false.obs;
  static RxBool noInternet = false.obs;
  static RxInt selectedIndex = 0.obs;
}
