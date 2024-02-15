import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class SearchViewModel extends GetxController {
  List<String> recentSearchesList = <String>[].obs;

  @override
  void onReady() {
    getRecentSearch();
    super.onReady();
  }

  onFieldSubmitted(String value) {
    saveRecentSearch(value);
    // Get.to(()=>newscreen);
  }

  getRecentSearch() {
    List<dynamic> tempList = GetStorage().read('recent_search') ?? [];
    print(GetStorage().read('recent_search'));
    print(tempList.length);
    // recentSearchesList.clear();
    recentSearchesList.addAll(tempList.map((e) => e));
  }

  saveRecentSearch(String value) {
    List<dynamic> tempList = GetStorage().read('recent_search') ?? [];
    print(tempList.length);
    tempList.add(value);
    GetStorage().write('recent_search', tempList);

    recentSearchesList.clear();
    recentSearchesList.addAll(tempList.map((e) => e));
  }

  removeRecentSearch(String value){
    List<dynamic> tempList = GetStorage().read('recent_search') ?? [];
    tempList.remove(value);
    GetStorage().write('recent_search', tempList);
  }

}
