import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ismmart_ecommerce/screens/add_shipping_address/cities_model.dart';
import 'package:ismmart_ecommerce/screens/add_shipping_address/countries_model.dart';

import '../../helpers/global_variables.dart';

class AddShippingAddressViewModel extends GetxController{
  bool isEdit = false;
  // LocationModel locationModel = LocationModel();
  GlobalKey<FormState> addLocationFormKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController countryController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController statusController = TextEditingController();
  TextEditingController searchController = TextEditingController();
  String selectedCityId = '';
  String selectedCountryId = '';

  //cities
  List<CitiesModel> allCitiesList = [];
  List<CitiesModel> filteredCitiesList = <CitiesModel>[].obs;

  //countries
  List<CountriesModel> allCountriesList = [];
  List<CountriesModel> filteredCountriesList = <CountriesModel>[].obs;


  @override
  void onInit() {
    if (Get.arguments != null) {
      isEdit = Get.arguments['editData'];
    }
    super.onInit();
  }


  @override
  void onClose() {
    nameController.dispose();
    countryController.dispose();
    cityController.dispose();
    addressController.dispose();
    statusController.dispose();
    searchController.dispose();
    GlobalVariable.showLoader.value = false;
    super.onClose();
  }

  //////////////////////////////////////

  getCountries() async {
    // GlobalVariable.showLoader.value = true;
    // await ApiBaseHelper().getMethod(url: Urls.getCountries).then((parsedJson) {
    //   if (parsedJson['success'] == true &&
    //       parsedJson['data']['items'] != null) {
    //     GlobalVariable.showLoader.value = false;
    //     var data = parsedJson['data']['items'] as List;
    //     allCountriesList.addAll(data.map((e) => CountriesModel.fromJson(e)));
    //     filteredCountriesList.addAll(allCountriesList);
    //   }
    // }).catchError((e) {
    //   CommonFunction.debugPrint(e);
    // });
  }

  getCities(String countryName) async {
    // GlobalVariable.showLoader.value = true;
    // await ApiBaseHelper()
    //     .getMethod(url: '${Urls.getCities}$countryName')
    //     .then((parsedJson) {
    //   GlobalVariable.showLoader.value = false;
    //   if (parsedJson['success'] == true &&
    //       parsedJson['data']['items'] != null) {
    //     var data = parsedJson['data']['items'] as List;
    //     allCitiesList.addAll(data.map((e) => CitiesModel.fromJson(e)));
    //     filteredCitiesList.addAll(allCitiesList);
    //   }
    // }).catchError((e) {
    //   CommonFunction.debugPrint(e);
    // });
  }


}