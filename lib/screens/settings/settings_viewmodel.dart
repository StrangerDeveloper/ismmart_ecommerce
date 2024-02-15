import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class SettingsViewModel extends GetxController {
  RxBool onHelpPress = false.obs;
  RxBool onSettingPress = false.obs;

  RxString token = ''.obs;
  
  @override
  void onReady() {
    super.onReady();

    token.value = GetStorage().read('token');
  }
}
