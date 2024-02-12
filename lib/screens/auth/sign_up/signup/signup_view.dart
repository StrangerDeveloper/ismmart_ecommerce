import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:ismmart_ecommerce/helpers/app_colors.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import '../../../../helpers/theme_helper.dart';
import '../../../../helpers/validator.dart';
import '../../../../widgets/custom_appbar.dart';
import '../../../../widgets/custom_bottom_sheet.dart';
import '../../../../widgets/custom_button.dart';
import '../../../../widgets/custom_heading_and_subheading_text.dart';
import '../../../../widgets/custom_textfield.dart';
import '../../../../widgets/loader_view.dart';
import '../../../../widgets/obscure_suffix_icon.dart';
import '../../login/login_view.dart';
import 'signup_viewmodel.dart';

class SignUpView extends StatelessWidget {
  SignUpView({super.key});

  final SignUpViewModel viewModel = Get.put(SignUpViewModel());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appbar(),
      backgroundColor: AppColors.white,
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Form(
              key: viewModel.signUpFormKey,
              child: Padding(
                  padding: const EdgeInsets.only(
                    top: 10,
                    left: 25,
                    right: 25,
                  ),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Gap(44),
                        getOnBaordHeading(),
                        nameField(),
                        emailTextField(),
                        Gap(15),
                        // phoneNumberTextField(),
                        genderTextField(),
                        cnicNumberField(),
                        passwordTextField(),
                        confirmPasswordTextField(),
                        checkedStatement(),
                        signUpInBtn(),
                        alreadyHaveAnAccount()
                        // SizedBox(height: 100)
                      ])),
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
                      Icons.check_box_rounded,
                      color: AppColors.black,
                    ),
              const SizedBox(width: 10),
              SizedBox(
                width: Get.width * 0.7,
                child: Text(
                    'By creating your account you have to agree with our terms & conditions.',
                    overflow: TextOverflow.ellipsis,
                    maxLines: 3,
                    style: ThemeHelper.textTheme.bodyMedium
                        ?.copyWith(color: AppColors.grey2)),
              ),
            ],
          ),
        ),
      ),
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
      padding: const EdgeInsets.only(top: 32, bottom: 15),
      child: CustomTextBtn(
        radius: 30,
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Create Account",
            ),
            SizedBox(width: 4),
            Icon(
              Icons.arrow_forward,
              size: 20,
            ),
          ],
        ),
        onPressed: () {
          viewModel.signUp();
        },
      ),
    );
  }

  Widget alreadyHaveAnAccount() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 15),
        child: InkWell(
          borderRadius: BorderRadius.circular(12),
          onTap: () {
            Get.off(() => LogInView());
          },
          child: RichText(
            text: TextSpan(
              children: [
                TextSpan(
                    text: 'Already have an account?',
                    style: ThemeHelper.textTheme.bodyMedium
                        ?.copyWith(color: AppColors.grey2)),
                TextSpan(
                    text: ' Sign In', style: ThemeHelper.textTheme.labelMedium),
              ],
            ),
          ),
        ),
      ),
    );
  }

  PreferredSizeWidget appbar() {
    return CustomAppBar2(
      title: 'Sign Up',
      titleTextStyle: ThemeHelper.textTheme.titleMedium,
      centerTitle: true,
    );
  }

  Widget getOnBaordHeading() {
    return const CustomHeadingAndSubHeadingText(
      headingText: 'Create Account',
      subHeadingText: 'Get onboard as a user',
    );
  }
}
