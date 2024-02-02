import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:ismmart_ecommerce/helpers/app_colors.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

import 'package:path/path.dart' as p;

import '../../../../helpers/validator.dart';
import '../../../../widgets/custom_appbar.dart';
import '../../../../widgets/custom_bottom_sheet.dart';
import '../../../../widgets/custom_button.dart';
import '../../../../widgets/custom_image_widget/image_layout_container.dart';
import '../../../../widgets/custom_image_widget/pick_image.dart';
import '../../../../widgets/custom_textfield.dart';
import '../../../../widgets/loader_view.dart';
import '../../../../widgets/obscure_suffix_icon.dart';
import '../../login/login_view.dart';
import 'signup_viewmodel.dart';

class SignUp1View extends StatelessWidget {
  SignUp1View({super.key});

  final SignUpScreen1ViewModel viewModel = Get.put(SignUpScreen1ViewModel());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar2(
        title: 'Sign Up',
      ),
      backgroundColor: AppColors.white,
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              children: [
                Form(
                  key: viewModel.signUpFormKey1,
                  child: Padding(
                    padding: const EdgeInsets.only(
                      top: 10,
                      left: 20,
                      right: 20,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // titleAndBackBtn(),
                        // divider(),
                        Padding(
                          padding: const EdgeInsets.only(top: 60),
                          child: Text(
                            'Create an account',
                            // style: newFontStyleSize20,
                          ),
                        ),
                        nameField(),
                        emailTextField(),
                        phoneNumberTextField(),
                        genderTextField(),
                        // genderField(context),
                        cnicNumberField(),
                        cnicFrontImage(),
                        cnicBackImage(),
                        SizedBox(height: 10),
                        passwordTextField(),
                        confirmPasswordTextField(),
                        checkedStatement(),
                        signUpInBtn(),
                        SizedBox(height: 100)
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          const LoaderView()
        ],
      ),
    );
  }

  Widget checkedStatement() {
    return Padding(
      padding: const EdgeInsets.only(top: 20),
      child: InkWell(
        onTap: () {
          viewModel.isChecked.value = !viewModel.isChecked.value;
        },
        child: Obx(
          () => Row(
            children: [
              viewModel.isChecked.value == false
                  ? const Icon(
                      Icons.check_box_outline_blank,
                      color: Colors.grey,
                    )
                  : const Icon(
                      Icons.check_box,
                      color: Colors.blue,
                    ),
              SizedBox(width: 10),
              SizedBox(
                width: Get.width * 0.7,
                child: const Text(
                  'By creating your account you have to agree with our terms & conditions.',
                  overflow: TextOverflow.ellipsis,
                  maxLines: 3,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget divider() {
    return const Divider(
      color: Color(0xffEEEEEE),
      thickness: 1,
      height: 20,
    );
  }

  Widget nameField() {
    return Padding(
      padding: const EdgeInsets.only(top: 32, bottom: 15),
      child: CustomTextField1(
        keyboardType: TextInputType.text,
        prefixIcon: Icons.person,
        title: 'Full Name',
        hintText: 'John Doe',
        controller: viewModel.nameController,
        autoValidateMode: AutovalidateMode.onUserInteraction,
        validator: (value) {
          return Validator.validateDefaultField(value,
              errorMessage: 'Full Name is Required');
        },
      ),
    );
  }

  Widget emailTextField() {
    return CustomTextField1(
      prefixIcon: Icons.email_outlined,
      title: 'Email',
      hintText: 'hmirrani@gmail.com',
      controller: viewModel.emailController,
      autoValidateMode: AutovalidateMode.onUserInteraction,
      validator: (value) {
        return Validator.validateEmail(
          value,
        );
      },
      keyboardType: TextInputType.emailAddress,
    );
  }

  Widget phoneNumberTextField() {
    return Obx(
      () => Padding(
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: CountryCodePickerTextField2(
          validator: (value) {
            return Validator().validatePhoneNumber(value);
          },
          title: 'Phone Number',
          hintText: '111 11111111',
          keyboardType: TextInputType.number,
          controller: viewModel.phoneNumberController,
          initialValue: viewModel.countryCode.value,
          textStyle:
              const TextStyle(color: Colors.grey, fontWeight: FontWeight.w600),
          autoValidateMode: AutovalidateMode.onUserInteraction,
          inputFormatters: [
            FilteringTextInputFormatter.allow(RegExp(r'^\d+?\d*')),
          ],
          errorText: viewModel.phoneErrorText.value,
          onPhoneFieldChange: (value) {
            String newPhoneValue = viewModel.countryCode.value + value;
            viewModel.validatorPhoneNumber(newPhoneValue);
          },
          onChanged: (value) {
            viewModel.countryCode.value = value.dialCode ?? '+92';
            String newPhoneValue = viewModel.countryCode.value +
                viewModel.phoneNumberController.text;
            viewModel.validatorPhoneNumber(newPhoneValue);
          },
        ),
      ),
    );
  }

  Widget genderTextField() {
    return CustomTextField1(
      title: 'Gender',
      hintText: 'Select Gender',
      isDropDown: true,
      controller: viewModel.genderController,
      validator: (value) {
        return Validator.validateDefaultField(value,
            errorMessage: 'Gender is Required');
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
    );
  }

  // Widget genderField(BuildContext context) {
  //   return Column(
  //     children: [
  //       Align(
  //         alignment: Alignment.centerLeft,
  //         child: RichText(
  //           text: const TextSpan(
  //               text: 'Gender',
  //               style: TextStyle(
  //                   fontSize: 14,
  //                   color: Colors.black,
  //                   fontWeight: FontWeight.w700),
  //               children: [
  //                 // TextSpan(text: ' *', style: TextStyle(color: Colors.red))
  //               ]),
  //         ),
  //       ),
  //       SizedBox(height: 30, child: genderRadioBtns(context)),
  //     ],
  //   );
  // }

  // Widget genderRadioBtns(BuildContext buildContext) {
  //   return Padding(
  //     padding: const EdgeInsets.only(top: 10),
  //     child: Center(
  //       child: ListView.builder(
  //         itemCount: viewModel.gender.length,
  //         scrollDirection: Axis.horizontal,
  //         physics: const NeverScrollableScrollPhysics(),
  //         shrinkWrap: true,
  //         itemBuilder: (buildContext, index) {
  //           return radioButton(index, viewModel.gender[index]);
  //         },
  //       ),
  //     ),
  //   );
  // }
  //
  // Widget radioButton(int btnValue, String title) {
  //   return Obx(
  //     () => Row(
  //       mainAxisSize: MainAxisSize.min,
  //       mainAxisAlignment: MainAxisAlignment.start,
  //       children: <Widget>[
  //         Radio(
  //           fillColor: MaterialStateColor.resolveWith((states) => Colors.black),
  //           activeColor: Theme.of(Get.context!).primaryColor,
  //           value: viewModel.gender[btnValue],
  //           groupValue: viewModel.selectedGender.value,
  //           onChanged: (value) {
  //             viewModel.selectedGender.value = value ?? "";
  //           },
  //         ),
  //         Text(
  //           title,
  //           style: const TextStyle(
  //               color: Colors.black, fontSize: 14, fontWeight: FontWeight.w400),
  //         )
  //       ],
  //     ),
  //   );
  // }

  Widget cnicNumberField() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: CustomTextField1(
        keyboardType: TextInputType.number,
        inputFormatters: [
          MaskTextInputFormatter(
            mask: "#####-#######-#",
            type: MaskAutoCompletionType.lazy,
          ),
          // MaskedInputFormatter(
          //   "#####-#######-#",
          //   allowedCharMatcher: RegExp(r'[0-9]+'),
          // ),
        ],
        title: 'CNIC',
        hintText: '35404-4770789-7',
        controller: viewModel.cnicController,
        autoValidateMode: AutovalidateMode.onUserInteraction,
        validator: (value) {
          if (GetUtils.isBlank(value)!) {
            return "CNIC Required";
          } else if (value!.length != 15) {
            return "Enter Valid CNIC";
          } else {
            return null;
          }
        },
      ),
    );
  }

  Widget cnicFrontImage() {
    return Obx(
      () => ImageLayoutContainer(
        title: 'CNIC Front Image',
        filePath: viewModel.cnicFrontImage.value == ''
            ? ''
            : p.basename(viewModel.cnicFrontImage.value.path),
        onTap: () async {
          viewModel.myfocus.requestFocus();
          viewModel.cnicFrontImage.value =
              await PickImage().pickSingleImage() ?? File('');
          if (viewModel.cnicFrontImage.value.path.isNotEmpty) {
            viewModel.cnicFrontImageErrorVisibility.value = false;
          }
        },
        errorVisibility: viewModel.cnicFrontImageErrorVisibility.value,
        errorPrompt: 'CNIC Front Image is required',
      ),
    );
  }

  Widget cnicBackImage() {
    return Obx(
      () => ImageLayoutContainer(
        title: 'CNIC Back Image',
        filePath: viewModel.cnicBackImage.value == ''
            ? ''
            : p.basename(viewModel.cnicBackImage.value),
        onTap: () async {
          await viewModel.selectImage(
              viewModel.cnicBackImage, viewModel.cnicBackImageErrorVisibility);
        },
        errorVisibility: viewModel.cnicBackImageErrorVisibility.value,
        errorPrompt: 'CNIC Back Image is required',
      ),
    );
  }

  Widget passwordTextField() {
    return Obx(
      () => CustomTextField1(
        controller: viewModel.passwordController,
        title: 'Password',
        hintText: 'Hello@123',
        autoValidateMode: AutovalidateMode.onUserInteraction,
        validator: (value) {
          return Validator.validatePassword(value);
        },
        obscureText: viewModel.obscurePassword.value ? true : false,
        suffixIconButton: ObscureSuffixIcon(
          isObscured: viewModel.obscurePassword.value ? true : false,
          onPressed: () {
            viewModel.obscurePassword.value = !viewModel.obscurePassword.value;
          },
        ),
      ),
    );
  }

  Widget confirmPasswordTextField() {
    return Obx(
      () => Padding(
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: CustomTextField1(
          controller: viewModel.confirmPasswordController,
          title: 'Confirm Password',
          hintText: '*********',
          autoValidateMode: AutovalidateMode.onUserInteraction,
          validator: (value) {
            return Validator.validateConfirmPassword(
                value, viewModel.passwordController.text);
          },
          obscureText: viewModel.obscureConfirmPassword.value ? true : false,
          suffixIconButton: ObscureSuffixIcon(
            isObscured: viewModel.obscureConfirmPassword.value ? true : false,
            onPressed: () {
              viewModel.obscureConfirmPassword.value =
                  !viewModel.obscureConfirmPassword.value;
            },
          ),
        ),
      ),
    );
  }

  Widget signUpInBtn() {
    return Padding(
      padding: const EdgeInsets.only(top: 32),
      child: CustomTextBtn(
        radius: 30,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Create Account",
              // style: newFontStyleSize14.copyWith(
              //     fontWeight: FontWeight.w500, color: kWhiteColor),kWhiteColor
            ),
            SizedBox(width: 4),
            const Icon(
              Icons.arrow_forward,
              size: 20,
            ),
          ],
        ),
        onPressed: () {
          viewModel.signUpStep1();
          //  Get.to(SignUp2View());
        },
      ),
    );
  }

  Widget alreadyHaveAnAccount() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.only(top: 30),
        child: InkWell(
          borderRadius: BorderRadius.circular(12),
          onTap: () {
            Get.off(() => LogInView());
          },
          child: RichText(
            text: const TextSpan(
              children: [
                TextSpan(
                  text: 'Already have an account?',
                  style: TextStyle(
                    color: AppColors.lightGrey,
                  ),
                ),
                TextSpan(
                  text: 'Sign In',
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget orWidget() {
    return Row(
      children: [
        const Expanded(
          child: Divider(
            //color: newColorLightGrey,
            thickness: 1,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Text(
            "Or",
            //style: newFontStyle4,
          ),
        ),
        const Expanded(
          child: Divider(
            //color: newColorLightGrey,
            thickness: 1,
          ),
        ),
      ],
    );
  }
}
