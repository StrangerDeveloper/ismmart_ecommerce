import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ismmart_ecommerce/screens/add_shipping_address/add_shipping_address_viewmodel.dart';

import '../../helpers/validator.dart';
import '../../widgets/custom_appbar.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_textfield.dart';
import '../../widgets/loader_view.dart';

class AddShippingAddressView extends StatelessWidget {
  AddShippingAddressView({super.key});

  final AddShippingAddressViewModel viewModel =
      Get.put(AddShippingAddressViewModel());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar2(
        title: viewModel.isEdit
            ? 'Update Shipping Address'
            : 'Add Shipping Address',
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Form(
              key: viewModel.addLocationFormKey,
              child: Column(
                children: [
                  addressNameTxtField(),
                  const SizedBox(height: 18),
                  provinceTxtField(),
                  countryTxtField(),
                  cityTxtField(),
                  addressTxtField(),
                  const SizedBox(height: 18),
                  zipCodeTxtField(),
                  Padding(
                    padding: const EdgeInsets.only(top: 40, bottom: 5),
                    child: CustomTextBtn(
                      title: viewModel.isEdit ? 'Update' : 'Save & Add',
                      onPressed: () {
                        // viewModel.saveAndCreateBtn();
                      },
                    ),
                  ),
                  CustomTextBtn(
                    foregroundColor: Colors.black,
                    borderSide: const BorderSide(),
                    title: 'Discard',
                    backgroundColor: Colors.transparent,
                    onPressed: () {
                      Get.back();
                    },
                  ),
                ],
              ),
            ),
          ),
          const LoaderView(),
        ],
      ),
    );
  }

  Widget addressNameTxtField() {
    return CustomTextField1(
      controller: viewModel.nameController,
      title: 'Name',
      hintText: 'e.g. Beverly Center, Islamabad',
      validator: (value) {
        return Validator.validateDefaultField(value,
            errorMessage: 'Name is required');
      },
      autoValidateMode: AutovalidateMode.onUserInteraction,
    );
  }

  Widget provinceTxtField() {
    return CustomTextField1(
      controller: viewModel.nameController,
      title: 'Province',
      hintText: 'Select the province',
      onTap: () {
        // viewModel.resetForCitiesCountryValue();
        // itemsBottomSheet();
      },
      isDropDown: true,
      validator: (value) {
        return Validator.validateDefaultField(value,
            errorMessage: 'Name is required');
      },
      autoValidateMode: AutovalidateMode.onUserInteraction,
    );
  }

  Widget countryTxtField() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 18),
      child: CustomTextField1(
        title: 'Country',
        controller: viewModel.countryController,
        hintText: 'Select the country',
        onTap: () {
          // viewModel.resetForCitiesCountryValue();
          // itemsBottomSheet();
        },
        isDropDown: true,
        validator: (value) {
          return Validator.validateDefaultField(value,
              errorMessage: 'Country is required');
        },
        autoValidateMode: AutovalidateMode.onUserInteraction,
      ),
    );
  }

  Widget cityTxtField() {
    return CustomTextField1(
      title: 'City ',
      hintText: 'Select the city',
      controller: viewModel.cityController,
      isDropDown: true,
      onTap: () {
        // viewModel.resetForCitiesCountryValue(isCity: true);
        // itemsBottomSheet(isCity: true);
      },
      validator: (value) {
        return Validator.validateDefaultField(value,
            errorMessage: 'City is required');
      },
      autoValidateMode: AutovalidateMode.onUserInteraction,
    );
  }

  Widget addressTxtField() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 18),
      child: CustomTextField1(
        controller: viewModel.addressController,
        title: 'Address',
        hintText: 'Enter your Address here...',
        maxLines: 8,
        filled: false,
        validator: (value) {
          return Validator.validateDefaultField(value,
              errorMessage: 'Address is required');
        },
        autoValidateMode: AutovalidateMode.onUserInteraction,
      ),
    );
  }

  Widget zipCodeTxtField() {
    return CustomTextField1(
      controller: viewModel.nameController,
      title: 'Zip Code (Postal Code)',
      hintText: 'Enter the zip code',
      validator: (value) {
        return Validator.validateDefaultField(value,
            errorMessage: 'ZipCode is required');
      },
      autoValidateMode: AutovalidateMode.onUserInteraction,
    );
  }

  itemsBottomSheet({bool isCity = false}) {
    showModalBottomSheet(
      context: Get.context!,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      constraints: BoxConstraints(maxHeight: Get.height * 0.9),
      builder: (BuildContext context) {
        return Padding(
          padding: const EdgeInsets.fromLTRB(16, 10, 10, 3),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Icon(
                    Icons.menu,
                    color: Colors.black,
                  ),
                  const SizedBox(width: 10),
                  Text(
                    'Select ${isCity ? 'City' : 'Country'}',
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                      fontSize: 16,
                    ),
                  ),
                  const Spacer(),
                  IconButton(
                    onPressed: () {
                      Get.back();
                    },
                    icon: const Icon(
                      Icons.close,
                      color: Colors.red,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              CustomTextField1(
                hintText: 'Search ${isCity ? 'City' : 'Country'}...',
                controller: viewModel.searchController,
                onChanged: (value) {
                  // viewModel.onSearchForCitiesCountries(value, isCity: isCity);
                },
              ),
              Obx(
                () => ((isCity)
                        ? viewModel.filteredCitiesList.isNotEmpty
                        : viewModel.filteredCountriesList.isNotEmpty)
                    ? Expanded(
                        child: ListView.separated(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          itemCount: (isCity)
                              ? viewModel.filteredCitiesList.length
                              : viewModel.filteredCountriesList.length,
                          itemBuilder: (context, index) {
                            return InkWell(
                              borderRadius: BorderRadius.circular(8),
                              onTap: () {
                                Get.back();
                                if (isCity) {
                                  viewModel.cityController.text = viewModel
                                          .filteredCitiesList[index].name ??
                                      '';
                                  viewModel.selectedCityId =
                                      viewModel.filteredCitiesList[index].sId ??
                                          '';
                                } else {
                                  viewModel.countryController.text = viewModel
                                          .filteredCountriesList[index].name ??
                                      '';
                                  viewModel.getCities(viewModel
                                          .filteredCountriesList[index].sId ??
                                      '');
                                  viewModel.selectedCountryId = viewModel
                                          .filteredCountriesList[index].sId ??
                                      '';
                                }
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(12),
                                child: Text((isCity)
                                    ? viewModel
                                            .filteredCitiesList[index].name ??
                                        ''
                                    : viewModel.filteredCountriesList[index]
                                            .name ??
                                        ''),
                              ),
                            );
                          },
                          separatorBuilder: (context, index) {
                            return const SizedBox(height: 3);
                          },
                        ),
                      )
                    : Padding(
                        padding: const EdgeInsets.only(top: 30),
                        child: Text('No ${isCity ? 'City' : 'Country'} Found'),
                      ),
              )
            ],
          ),
        );
      },
    );
  }
}
