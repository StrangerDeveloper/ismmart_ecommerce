import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ismmart_ecommerce/helpers/app_colors.dart';

import '../../helpers/theme_helper.dart';
import '../../helpers/validator.dart';
import '../../widgets/custom_appbar.dart';
import '../../widgets/custom_bottom_sheet.dart';
import '../../widgets/custom_button.dart';

import '../../widgets/custom_text_field.dart';
import '../../widgets/loader_view.dart';
import '../../widgets/pick_image.dart';
import '../../widgets/widget_models/custom_cached_network_image.dart';
import 'edit_user_profile_viewmodel.dart';

class EditUserProfileView extends StatelessWidget {
  EditUserProfileView({super.key});

  final EditUserProfileViewModel viewModel =
      Get.put(EditUserProfileViewModel());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appbar(),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              children: [
                Form(
                  key: viewModel.userProfileFormKey,
                  child: Padding(
                    padding: const EdgeInsets.only(
                        top: 16, left: 24, right: 24, bottom: 24),
                    child: Column(
                      children: [
                        profileImage(),
                        nameField(),
                        emailTextField(),
                        phoneNumberTextField(),
                        genderTextField(),
                        updateBtn(),
                        discardBtn(),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          const LoaderView(),
        ],
      ),
    );
  }

  Widget profileImage() {
    return Padding(
      padding: const EdgeInsets.only(top: 20, bottom: 25),
      child: Align(
        alignment: Alignment.center,
        child: Stack(
          alignment: Alignment.bottomRight,
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.shade200,
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: const Offset(0, 3), // changes position of shadow
                  ),
                ],
              ),
              child: Obx(
                () => (viewModel.userProfileImage.value.path != "")
                    ? Container(
                        height: 80,
                        width: 80,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                            image: FileImage(viewModel.userProfileImage.value),
                            fit: BoxFit.cover,
                          ),
                        ),
                      )
                    : CustomCachedNetworkImage(
                        height: 80,
                        width: 80,
                        imageUrl: viewModel.userProfileModel.value.image != null
                            ? viewModel.userProfileModel.value.image!
                            : '',
                      ),
              ),
            ),
            Positioned(
              right: 8,
              bottom: 4,
              child: InkWell(
                onTap: () async {
                  viewModel.userProfileImage.value =
                      await PickImage().pickSingleImage() ?? File('');
                },
                child: Container(
                  padding: const EdgeInsets.all(3.5),
                  decoration: BoxDecoration(
                    color: AppColors.black,
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white, width: 1.8),
                  ),
                  child: const Icon(
                    Icons.edit_outlined,
                    size: 14,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget nameField() {
    return CustomTextField1(
      title: 'Name',
      hintText: 'John Doe',
      controller: viewModel.nameController,
      validator: (value) {
        return Validator.validateDefaultField(value,
            errorMessage: 'Name is required');
      },
      autoValidateMode: AutovalidateMode.onUserInteraction,
    );
  }

  Widget emailTextField() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 18),
      child: CustomTextField1(
        title: 'Email',
        hintText: 'johndoe11@gmail.com',
        controller: viewModel.emailController,
        validator: (value) {
          return Validator.validateEmail(value);
        },
        autoValidateMode: AutovalidateMode.onUserInteraction,
        keyboardType: TextInputType.emailAddress,
      ),
    );
  }

  Widget phoneNumberTextField() {
    return CustomTextField1(
      title: 'Phone Number',
      hintText: '336 5563138',
      controller: viewModel.phoneNumberController,
      validator: (value) {
        return Validator().validatePhoneNumber(value);
      },
      autoValidateMode: AutovalidateMode.onUserInteraction,
      keyboardType: TextInputType.phone,
    );
  }

  // Widget phoneNumberTextField() {
  //   return Obx(
  //     () => CountryCodePickerTextField(
  //       validator: (value) {
  //         return Validator().validatePhoneNumber(value);
  //       },
  //       title: 'Phone Number',
  //       hintText: '336 5563138',
  //       keyboardType: TextInputType.number,
  //       controller: viewModel.phoneNumberController,
  //       initialValue: viewModel.countryCode.value,
  //       textStyle:
  //           const TextStyle(color: Colors.grey, fontWeight: FontWeight.w600),
  //       autoValidateMode: AutovalidateMode.onUserInteraction,
  //       inputFormatters: [
  //         FilteringTextInputFormatter.allow(RegExp(r'^\d+?\d*')),
  //       ],
  //       errorText: viewModel.phoneErrorText.value,
  //       onPhoneFieldChange: (value) {
  //         String newPhoneValue = viewModel.countryCode.value + value;
  //         viewModel.validatorPhoneNumber(newPhoneValue);
  //       },
  //       onChanged: (value) {
  //         viewModel.countryCode.value = value.dialCode ?? '+92';
  //         String newPhoneValue = viewModel.countryCode.value +
  //             viewModel.phoneNumberController.text;
  //         viewModel.validatorPhoneNumber(newPhoneValue);
  //       },
  //     ),
  //   );
  // }

  Widget genderTextField() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 18),
      child: CustomTextField1(
        title: 'Gender',
        hintText: 'Male',
        isDropDown: true,
        controller: viewModel.genderController,
        validator: (value) {
          return Validator.validateDefaultField(value,
              errorMessage: 'Gender is required');
        },
        autoValidateMode: AutovalidateMode.onUserInteraction,
        onTap: () {
          CustomBottomSheet1(
            selectedIndex: viewModel.genderSelectedIndex.value,
            list: viewModel.genderList,
            onValueSelected: (value) {
              viewModel.genderSelectedIndex.value = value;
              viewModel.genderController.text = viewModel.genderList[value];
            },
          ).show();
        },
      ),
    );
  }

  Widget updateBtn() {
    return Padding(
      padding: const EdgeInsets.only(top: 25, bottom: 5),
      child: CustomTextBtn(
        borderSide: const BorderSide(
          color: AppColors.black, // your color here
          width: 1.5,
        ),
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        title: 'Save & Update',
        textStyle: ThemeHelper.textTheme.bodySmall
            ?.copyWith(fontWeight: FontWeight.w600, color: AppColors.white),
        onPressed: () {
          viewModel.saveAndCreateBtn();
        },
      ),
    );
  }

  Widget discardBtn() {
    return CustomTextBtn(
      borderSide: const BorderSide(
        color: AppColors.black, // your color here
        width: 1.5,
      ),
      backgroundColor: Colors.white,
      foregroundColor: Colors.black,
      title: 'Discard',
      textStyle: ThemeHelper.textTheme.bodySmall
          ?.copyWith(fontWeight: FontWeight.w600),
      onPressed: () {
        Get.back();
      },
    );
  }

  PreferredSizeWidget appbar() {
    return CustomAppBar2(
      title: 'Profile Details',
      titleTextStyle: ThemeHelper.textTheme.bodyLarge,
      centerTitle: true,
    );
  }
}
