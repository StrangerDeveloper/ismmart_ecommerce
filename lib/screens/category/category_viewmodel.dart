import 'package:get/get.dart';
import 'package:ismmart_ecommerce/helpers/global_variables.dart';
import '../home/model/collection_model.dart';

class CategoryViewModel extends GetxController{

  RxInt collectionCurrentIndex = 0.obs;
  List<Children> categoriesList = <Children>[].obs;

  @override
  void onReady() {
    changeCollection(0);
    super.onReady();
  }

  changeCollection(int index){
    collectionCurrentIndex.value = index;
    categoriesList.clear();
    categoriesList.addAll(GlobalVariable.collectionList[collectionCurrentIndex.value].children ?? []);
  }



}