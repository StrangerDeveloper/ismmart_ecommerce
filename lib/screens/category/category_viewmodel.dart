import 'package:get/get.dart';
import 'package:ismmart_ecommerce/helpers/global_variables.dart';

import '../../helpers/api_base_helper.dart';
import '../../helpers/common_function.dart';
import '../../helpers/urls.dart';
import '../home/model/collection_model.dart';

class CategoryViewModel extends GetxController{

  RxInt collectionCurrentIndex = 0.obs;
  List<Children> categoriesList = <Children>[].obs;

  @override
  void onReady() {
    getCollections();
    // changeCollection(0);
    super.onReady();
  }

  changeCollection(int index){
    // collectionCurrentIndex.value = index;
    categoriesList.clear();
    categoriesList.addAll(GlobalVariable.collectionList[collectionCurrentIndex.value].children ?? []);
  }

  //for testing purpose...
  getCollections() async {
    GlobalVariable.showLoader.value = true;

    Map<String, String> params = {
      'fields[children]': '1',
      'fields[media]=1': '1',
      'fields[name]': '1',
      'level': '1',
      'limit': '0',
    };

    await ApiBaseHelper()
        .getMethodQueryParam(url: Urls.homeCollections, params: params)
        .then((parsedJson) {
      GlobalVariable.showLoader.value = false;
      // clearValues();
      if (parsedJson['success'] == true &&
          parsedJson['data']['items'] != null) {
        var data = parsedJson['data']['items'] as List;

        // collectionList.addAll(data.map((e) => CollectionModel.fromJson(e)));
        GlobalVariable.collectionList.addAll(data.map((e) => CollectionModel.fromJson(e)));
      }
    }).catchError((e) {
      CommonFunction.debugPrint(e);
    });
  }


}