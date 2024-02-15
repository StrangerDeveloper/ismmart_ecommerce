import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:ismmart_ecommerce/screens/search_detail/search_detail_view.dart';

class SearchViewModel extends GetxController {
  TextEditingController searchTxtFieldController = TextEditingController();
  List<String> recentSearchesList = <String>[].obs;

  @override
  void onReady() {
    getRecentSearch();
    super.onReady();
  }

  @override
  void onClose() {
    searchTxtFieldController.dispose();
    super.onClose();
  }

  searchTheText(String value) {
    saveRecentSearch(value);
    Get.to(() => SearchDetailView(), arguments: {'search_text': value});
  }

  getRecentSearch() {
    List<dynamic> tempList = GetStorage().read('recent_search') ?? [];
    recentSearchesList.addAll(tempList.map((e) => e));
  }

  saveRecentSearch(String value) {
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
