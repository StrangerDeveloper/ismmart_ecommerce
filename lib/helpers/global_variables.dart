import 'package:get/get.dart';
import '../screens/home/model/collection_model.dart';
import '../screens/profile_details/profile_details_model.dart';

class GlobalVariable {
  static String token =
      'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiI2NTc3ZWY3ZmI2NGUxY2UwOWY5ZDAwYWIiLCJuYW1lIjoiVGVzdCBDdXN0b21lciIsImlhdCI6MTcwMjM1ODk4MCwiZXhwIjoxNzA0OTUwOTgwfQ.gEtHoNIqEpOhNuzaIgFkd40_zkFajELhM900I3mbcC0';
  // static String token = "";
  static RxBool showLoader = false.obs;
  static RxBool noInternet = false.obs;
  static RxInt selectedIndex = 0.obs;
  static String notificationsToken = '';
  static Rx<UserProfileModel> userModel = UserProfileModel().obs;

  static List<CollectionModel> collectionList = <CollectionModel>[].obs;
}
