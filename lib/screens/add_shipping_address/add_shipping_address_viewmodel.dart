import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../helpers/api_base_helper.dart';
import '../../helpers/common_function.dart';
import '../../helpers/global_variables.dart';
import '../../helpers/urls.dart';
import '../shipping_address_list/shipping_address_list_viewmodel.dart';
import 'cities_model.dart';
import 'countries_model.dart';
import 'location_model.dart';

class AddLocationViewModel extends GetxController {
  bool isEdit = false;
  LocationModel locationModel = LocationModel();
  GlobalKey<FormState> addLocationFormKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController countryController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController statusController = TextEditingController();
  TextEditingController provinceController = TextEditingController();
  TextEditingController searchController = TextEditingController();
  String selectedCityId = '';
  String selectedCountryId = '';

  //cities
  List<CitiesModel> allCitiesList = [];
  List<CitiesModel> filteredCitiesList = <CitiesModel>[].obs;

  //countries
  List<CountriesModel> allCountriesList = [];
  List<CountriesModel> filteredCountriesList = <CountriesModel>[].obs;

  //status
  RxInt statusSelectedIndex = 0.obs;
  List<String> statusList = const <String>['Active', 'In-Active'];

  @override
  void onInit() {
    if (Get.arguments != null) {
      isEdit = Get.arguments['editData'];
    }
    super.onInit();
  }

  @override
  void onReady() {
    getCountries();
    setData();
    super.onReady();
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

  setData() {
    if (isEdit) {
      locationModel = Get.arguments['model'];
      nameController.text = locationModel.name ?? '';
      countryController.text = locationModel.country?.name ?? '';
      selectedCountryId = locationModel.country?.sId ?? '';
      cityController.text = locationModel.city?.name ?? '';
      selectedCityId = locationModel.city?.sId ?? '';
      addressController.text = locationModel.address ?? '';
      statusSelectedIndex.value =
          statusList.indexOf(locationModel.status ?? '');
      statusController.text = locationModel.status ?? '';
    }
  }

  bool isFormChanged() {
    return nameController.text != locationModel.name ||
        countryController.text != locationModel.country?.name ||
        cityController.text != locationModel.city?.name ||
        addressController.text != locationModel.address ||
        statusController.text != locationModel.status;
  }

  resetForCitiesCountryValue({bool isCity = false}) {
    searchController.text = '';
    if (isCity) {
      filteredCitiesList.clear();
      filteredCitiesList.addAll(allCitiesList);
    } else {
      filteredCountriesList.clear();
      filteredCountriesList.addAll(allCountriesList);
    }
  }

  onSearchForCitiesCountries(String value, {bool isCity = false}) {
    if (isCity) {
      filteredCitiesList.clear();
      filteredCitiesList.addAll(allCitiesList.where(
          (e) => e.name?.toLowerCase().contains(value.toLowerCase()) ?? false));
    } else {
      filteredCountriesList.clear();
      filteredCountriesList.addAll(allCountriesList.where(
          (e) => e.name?.toLowerCase().contains(value.toLowerCase()) ?? false));
    }
  }

  saveAndCreateBtn() async {
    if (isFormChanged() == false) {
      Get.back();
      return;
    }

    if ((addLocationFormKey.currentState?.validate() ?? false) &&
        selectedCityId != '' &&
        selectedCountryId != '') {
      GlobalVariable.showLoader.value = true;
      Map<String, String> param = {
        "name": nameController.text,
        "country": selectedCountryId,
        "city": selectedCityId,
        "address": addressController.text,
        "province": provinceController.text,
        "status": statusList[statusSelectedIndex.value],
        // "phone": nameController.text,
      };

      if (isEdit) {
        await ApiBaseHelper()
            .putMethod(
                url: '${Urls.updateLocation}${locationModel.sId}', body: param)
            .then((parsedJson) {
          GlobalVariable.showLoader.value = false;
          if (parsedJson['success'] == true &&
              parsedJson['message'] == 'Location Updated Successfully') {
            ShippingAddressListViewModel viewModel = Get.find();
            viewModel.getLocationListApi();
            Get.back();
            // AppConstant.displaySnackBar('Success', parsedJson['message']);
          } else {
            // AppConstant.displaySnackBar('Error', parsedJson['message']);
          }
        }).catchError((e) {
          CommonFunction.debugPrint(e);
        });
      } else {
        await ApiBaseHelper()
            .postMethod(url: Urls.addLocation, body: param)
            .then((parsedJson) {
          GlobalVariable.showLoader.value = false;
          if (parsedJson['success'] == true &&
              parsedJson['message'] == 'Location added successfully') {
            ShippingAddressListViewModel viewModel = Get.find();
            viewModel.getLocationListApi();
            Get.back();
            // AppConstant.displaySnackBar('Success', parsedJson['message']);
          } else {
            // AppConstant.displaySnackBar('Error', parsedJson['message']);
          }
        }).catchError((e) {
          CommonFunction.debugPrint(e);
        });
      }
    }
  }

  //////////////////////////////////////

  getCountries() async {
    GlobalVariable.showLoader.value = true;
    await ApiBaseHelper().getMethod(url: Urls.getCountries).then((parsedJson) {
      if (parsedJson['success'] == true &&
          parsedJson['data']['items'] != null) {
        GlobalVariable.showLoader.value = false;
        var data = parsedJson['data']['items'] as List;
        allCountriesList.addAll(data.map((e) => CountriesModel.fromJson(e)));
        filteredCountriesList.addAll(allCountriesList);
      }
    }).catchError((e) {
      CommonFunction.debugPrint(e);
    });
  }

  getCities(String countryName) async {
    print("SELEDTED Country ------ $countryName");
    GlobalVariable.showLoader.value = true;
    await ApiBaseHelper()
        .getMethod(url: '${Urls.getCities}$countryName')
        .then((parsedJson) {
      allCitiesList.clear();
      GlobalVariable.showLoader.value = false;
      if (parsedJson['success'] == true &&
          parsedJson['data']['items'] != null) {
        var data = parsedJson['data']['items'] as List;
        allCitiesList.addAll(data.map((e) => CitiesModel.fromJson(e)));
        filteredCitiesList.addAll(allCitiesList);
      }
    }).catchError((e) {
      CommonFunction.debugPrint(e);
    });
  }
}
