import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../helpers/app_routes.dart';
import '../../helpers/global_variables.dart';

class SplashScreenViewModel extends GetxController {
  var getStorage;
  @override
  void onReady() async {
    getStorage = GetStorage();
    Future.delayed(const Duration(seconds: 4), () {
      navigateToNextScreen();
    });
    super.onReady();
  }

  navigateToNextScreen() {
    Get.offAllNamed(AppRoutes.bottomNavigationViewRoute);

    // String token = getStorage.read('token') ?? "";
    // GlobalVariable.token = token;
    // if (token != '') {
    //   Get.offAllNamed(AppRoutes.bottomNavigationViewRoute);
    // } else {
    //   Get.offAllNamed(AppRoutes.loginViewRoute);
    // }
  }
}
