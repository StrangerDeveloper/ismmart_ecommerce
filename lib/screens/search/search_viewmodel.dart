import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../../helpers/app_routes.dart';

class SearchViewModel extends GetxController {
  RxBool showSuffix = false.obs;
  TextEditingController searchTxtFieldController = TextEditingController();
  List<String> recentSearchesList = <String>[].obs;

  @override
  void onInit() {
    print('onInit');
    super.onInit();
  }

  @override
  void onReady() {
    print('onReady');
    getRecentSearch();
    super.onReady();
  }

  @override
  void onClose() {
    print('onClose');
    searchTxtFieldController.dispose();
    super.onClose();
  }

  searchTheText(String value, {bool saveRecentSearch = false}) {
    if (saveRecentSearch) {
      storeRecentSearch(value);
    }
    Get.toNamed(
      AppRoutes.searchDetail,
      arguments: {'search_text': value},
      preventDuplicates: false,
    );
  }

  getRecentSearch() {
    List<dynamic> tempList = GetStorage().read('recent_search') ?? [];
    recentSearchesList.addAll(tempList.map((e) => e));
  }

  storeRecentSearch(String value) {
    List<dynamic> tempList = GetStorage().read('recent_search') ?? [];
    if (tempList.length > 9) {
      tempList.removeLast();
    }
    tempList = [value, ...tempList];
    GetStorage().write('recent_search', tempList);
  }

  removeRecentSearch(String value) {
    recentSearchesList.remove(value);
    List<dynamic> tempList = GetStorage().read('recent_search') ?? [];
    tempList.remove(value);
    GetStorage().write('recent_search', tempList);
  }
}
