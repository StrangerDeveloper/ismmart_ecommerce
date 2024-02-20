import 'package:get/get.dart';
import '../screens/home/model/collection_model.dart';
import '../screens/profile_details/profile_model.dart';

class GlobalVariable {
  static String token =
      'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiI2NWMxZjY3YzkwMzA2OGZjYTIyODY4MjUiLCJuYW1lIjoiVGF1aGVlZCBCdXR0IiwiaWF0IjoxNzA3OTk3MTc4LCJleHAiOjE3MTA1ODkxNzh9.4it9RuQW6mPwfKMPpECBWU-fmSEbq8-CeWgh6N3Si9o';
  // static String token = "";
  static RxBool showLoader = false.obs;
  static RxBool noInternet = false.obs;
  static RxInt selectedIndex = 0.obs;
  static RxBool auth_From_CheckOut = false.obs;
  static String notificationsToken = '';
  static Rx<UserProfileModel> userModel = UserProfileModel().obs;

  static List<CollectionModel> collectionList = <CollectionModel>[].obs;
}
