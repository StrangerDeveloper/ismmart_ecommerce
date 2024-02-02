import 'dart:core';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class Validator {
  /////////////////////  Formatters  /////////////////////////
  ///Number should start from + sign...
  final List<TextInputFormatter>? phoneNumberFormatter = [
    FilteringTextInputFormatter.allow(RegExp(r'^(?:[+])?\d*'))
  ];

  /////////////////////  Validators  /////////////////////////
  ///EmptyField
  static String? validateDefaultField(String? value,
      {String errorMessage = 'Field is required'}) {
    if (GetUtils.isBlank(value)!) {
      return errorMessage;
    } else {
      return null;
    }
  }

  ///EmptyField
  String? validateDefaultTxtField(String? value, {String? errorPrompt}) {
    if (GetUtils.isBlank(value)!) {
      if (errorPrompt == null) {
        return "Field is Required";
      } else {
        return errorPrompt;
      }
    } else {
      return null;
    }
  }

  // ///Category Field
  // String? validateCategoryField(CategoryModel category){
  //   if(category.id == null || category.id == 0){
  //     return langKey.categoryReq.tr;
  //   } else{
  //     return null;
  //   }
  // }
  //
  // ///Sub-Category Field
  // String? validateSubCategoryField(SubCategory subCategory){
  //   if(subCategory.id == null || subCategory.id == 0){
  //     return langKey.selectSubCategory.tr;
  //   } else{
  //     return null;
  //   }
  // }
  //
  // ///Country
  // String? validateCountry(CountryModel country){
  //   if(country.id == null || country.id == 0){
  //     return langKey.countryReq.tr;
  //   } else{
  //     return null;
  //   }
  // }
  //
  // ///City
  // String? validateCity(CountryModel city){
  //   if(city.id == null || city.id == 0){
  //     return langKey.cityReq.tr;
  //   } else{
  //     return null;
  //   }
  // }
  //
  // ///Address
  // String? validateAddress(String? value) {
  //   RegExp regex = RegExp(r'^[#.0-9a-zA-Z\s,-]+$');
  //   if (GetUtils.isBlank(value)!) {
  //     return langKey.shopAddressReq.tr;
  //   } else if (!regex.hasMatch(value!)) {
  //     return langKey.incorrectAddress.tr;
  //   } else {
  //     return null;
  //   }
  // }
  //
  ///CNIC
  static String? validateCNIC(String? value) {
    if (GetUtils.isBlank(value)!) {
      return "CNIC Required";
    } else if (value!.length != 15) {
      return "Enter Valid CNIC";
    } else {
      return null;
    }
  }

  //
  // ///Name
  String? validateName(String? value, {String? errorToPrompt}) {
    if (GetUtils.isBlank(value)!) {
      return errorToPrompt;
    } else {
      return null;
    }
  }

  //
  // // String? validateName(String? value) {
  // //   RegExp regex = RegExp(r'^[a-zA-Z -]+$');
  // //   if (GetUtils.isBlank(value)!) {
  // //     return langKey.fieldIsRequired.tr;
  // //   } else if (!regex.hasMatch(value!)) {
  // //     return langKey.nameAlphabaticReq.tr;
  // //   } else {
  // //     return null;
  // //   }
  // // }
  //
  ///Phone Number : that should NOT start from + sign...
  String? validatePhoneNumber(String? value) {
    if (GetUtils.isBlank(value)!) {
      return 'Phone No is required';
    } else if (value!.length > 16 || value.length < 7) {
      return 'char length should be between 7 to 16';
    } else {
      return null;
    }
  }

  // ///NTN
  // String? validateNTN(String? value) {
  //   if (GetUtils.isBlank(value)!) {
  //     return null;
  //   } else if (value!.length < 7 || value.length > 9) {
  //     return langKey.incorrectNTN.tr;
  //   } else {
  //     return null;
  //   }
  // }
  //
  ///Email
  static String? validateEmail(String? value) {
    if (GetUtils.isBlank(value)!) {
      return "Email is Required";
    } else if (!GetUtils.isEmail(value!)) {
      return "Enter Valid Email";
    } else {
      return null;
    }
  }

  //
  // ///Bank Account
  // String? validateBankAcc(String? value) {
  //   if (GetUtils.isBlank(value)!) {
  //     return langKey.bankAccountReq.tr;
  //   } else {
  //     VendorSignUp3ViewModel vendorSignUp3ViewModel = Get.find();
  //     if (value!.length < 14 || value.length > 33) {
  //       Future.delayed(Duration(milliseconds: 500), () {
  //         vendorSignUp3ViewModel.enableBranchCode.value = false;
  //       });
  //       return langKey.incorrectAccOrIbanNo.tr;
  //     } else {
  //       if (RegExp(r'^-?(([0-9]*)|(([0-9]*)\.([0-9]*)))$').hasMatch(value)) {
  //         Future.delayed(Duration(milliseconds: 500), () {
  //           vendorSignUp3ViewModel.enableBranchCode.value = true;
  //         });
  //         return null;
  //       } else {
  //         Future.delayed(Duration(milliseconds: 500), () {
  //           vendorSignUp3ViewModel.enableBranchCode.value = false;
  //         });
  //         return null;
  //       }
  //     }
  //   }
  // }
  //
  // ///Branch Code
  // String? validateBranchCode(String? value, String bankAcc) {
  //   if (GetUtils.isBlank(value)!) {
  //     if (bankAcc.isEmpty || bankAcc == '') {
  //       return null;
  //     } else if (RegExp(r'^-?(([0-9]*)|(([0-9]*)\.([0-9]*)))$')
  //         .hasMatch(bankAcc)) {
  //       return langKey.enterBranchCode.tr;
  //     } else {
  //       return null;
  //     }
  //   } else if (value?.length != 4) {
  //     return langKey.incorrectBranchCode.tr;
  //   } else {
  //     return null;
  //   }
  // }
  //
  ///Password
  static String? validatePassword(String? value) {
    if (GetUtils.isBlank(value)!) {
      return "Password is Required";
    } else if (GetUtils.isLengthLessThan(value, 8)) {
      return "atleast 8 character";
    } else {
      return null;
    }
  }

  //
  ///Confirm Password
  static String? validateConfirmPassword(String? value1, String? value2) {
    if (GetUtils.isBlank(value1)!) {
      return "Confirm Password Required";
    } else if (value1 != value2) {
      return "Password Not Matched";
    } else {
      return null;
    }
  }
  //
  // ///Weight
  // String? validateWeightField(String value) {
  //   if (GetUtils.isBlank(value)!) {
  //     return langKey.weightIsReq.tr;
  //   } else {
  //     return null;
  //   }
  // }
}
