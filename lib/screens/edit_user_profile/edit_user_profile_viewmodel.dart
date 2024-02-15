import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:ismmart_ecommerce/screens/profile_details/profile_viewmodel.dart';

import '../../helpers/api_base_helper.dart';
import '../../helpers/common_function.dart';
import '../../helpers/global_variables.dart';
import '../../helpers/urls.dart';
import '../profile_details/profile_model.dart';

class EditUserProfileViewModel extends GetxController {
  Rx<File> userProfileImage = File('').obs;
  Rx<UserProfileModel> userProfileModel = UserProfileModel().obs;
  GlobalKey<FormState> userProfileFormKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController genderController = TextEditingController();

  //Gender
  RxInt genderSelectedIndex = 0.obs;
  List genderList = ['Male', 'Female', 'Other'];

  @override
  void onInit() {
    userProfileModel = Get.arguments['model'];
    super.onInit();
  }

  @override
  void onReady() {
    setData();
    super.onReady();
  }

  @override
  void onClose() {
    nameController.dispose();
    emailController.dispose();
    phoneNumberController.dispose();
    genderController.dispose();
    GlobalVariable.showLoader.value = false;
    super.onClose();
  }

  // validatorPhoneNumber(String? value) {
  //   if (GetUtils.isBlank(value)!) {
  //     phoneErrorText.value = 'Field required';
  //   } else if (value!.length > 16 || value.length < 7) {
  //     phoneErrorText.value = 'Phone numbers should be 7 to 16 digits long.';
  //   } else {
  //     phoneErrorText.value = null;
  //   }
  // }

  setData() {
    nameController.text = userProfileModel.value.name ?? '';
    emailController.text = userProfileModel.value.email ?? '';
    phoneNumberController.text = userProfileModel.value.phone ?? '';
    genderController.text = userProfileModel.value.gender ?? '';

    //gender
    int genderIndex =
        genderList.indexOf(userProfileModel.value.gender?.toLowerCase() ?? '');
    genderSelectedIndex.value = genderIndex != -1 ? genderIndex : 0;
  }

  saveAndCreateBtn() async {
    if (userProfileFormKey.currentState?.validate() ?? false) {
      List<http.MultipartFile> fileList = [];
      //profileImage
      if (userProfileImage.value.path == '' &&
          userProfileModel.value.image == null) {
        CommonFunction.showSnackBar(
            title: 'Error', message: 'Please upload profile image');
        return;
      }

      if (userProfileImage.value.path != '') {
        fileList.add(
          await http.MultipartFile.fromPath(
            'image',
            userProfileImage.value.path,
            // contentType: MediaType.parse('image/jpeg'),
          ),
        );
      }
      {
        Map<String, String> param = {
          "name": nameController.text,
          "email": emailController.text,
          "phone": phoneNumberController.text,
          "gender": genderList[genderSelectedIndex.value],
        };

        GlobalVariable.showLoader.value = true;
        await ApiBaseHelper()
            .putMethodForImage(
                url: Urls.editProfile, files: fileList, fields: param)
            .then((parsedJson) {
          GlobalVariable.showLoader.value = false;
          if (parsedJson['success'] == true &&
              parsedJson['message'] == 'Profile updated successuflly') {
            ProfileViewModel viewModel = Get.find();
            viewModel.getData();
            Get.back();
            CommonFunction.showSnackBar(
                title: 'Error', message: parsedJson['message']);
          } else {
            CommonFunction.showSnackBar(
                title: 'Error', message: parsedJson['message']);
          }
        }).catchError((e) {
          CommonFunction.debugPrint(e);
        });
      }
    }
  }
}
