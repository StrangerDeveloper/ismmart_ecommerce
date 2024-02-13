import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ismmart_ecommerce/screens/auth/forgot_password/reset_password/reset_password_viewmodel.dart';
import 'package:ismmart_ecommerce/widgets/custom_appbar.dart';
import 'package:ismmart_ecommerce/widgets/loader_view.dart';

import '../../../../helpers/app_colors.dart';
import '../../../../helpers/theme_helper.dart';
import '../../../../helpers/validator.dart';
import '../../../../widgets/custom_button.dart';
import '../../../../widgets/custom_text.dart';
import '../../../../widgets/custom_text_field.dart';
import '../../../../widgets/obscure_suffix_icon.dart';

class ResetPasswordView extends StatelessWidget {
  ResetPasswordView({super.key});
  final viewModel = Get.put(ResetPasswordViewModel());
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Scaffold(
        appBar: appbar(),
        backgroundColor: Colors.white,
        body: Stack(
          children: [
            SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: Form(
                  key: viewModel.resetPasswordFormKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      logo(),
                      headings(),
                      _password(),
                      _passwordConfirm(),
                      resetBtn(),
                    ],
                  ),
                ),
              ),
            ),
            const LoaderView()
          ],
        ),
      ),
    );
  }

  PreferredSizeWidget appbar() {
    return CustomAppBar2(
      title: 'Reset Password',
      titleTextStyle: ThemeHelper.textTheme.titleMedium,
      centerTitle: true,
    );
  }

  Widget headings() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Reset Password',
          style: ThemeHelper.textTheme.titleSmall,
        ),
        Padding(
            padding: const EdgeInsets.only(
              top: 8,
              right: 20,
              bottom: 16,
            ),
            child: Text(
              maxLines: 2,
              'Set your new password',
              style: ThemeHelper.textTheme.bodyMedium
                  ?.copyWith(color: AppColors.grey2),
            )),
      ],
    );
  }

  Widget _password() {
    return Obx(
      () => Padding(
        padding: const EdgeInsets.only(top: 32),
        child: CustomTextField1(
          prefixIcon: Icons.lock,
          title: 'New Password',
          hintText: '********',
          obscureText: viewModel.obscurePassword.value ? true : false,
          suffixIconButton: ObscureSuffixIcon(
            isObscured: viewModel.obscurePassword.value ? true : false,
            onPressed: () {
              viewModel.obscurePassword.value =
                  !viewModel.obscurePassword.value;
            },
          ),
          controller: viewModel.passwordController,
          autoValidateMode: AutovalidateMode.onUserInteraction,
          validator: (value) {
            return Validator.validatePassword(value);
          },
          keyboardType: TextInputType.emailAddress,
        ),
      ),
    );
  }

  Widget _passwordConfirm() {
    return Obx(
      () => Padding(
        padding: const EdgeInsets.only(top: 22),
        child: CustomTextField1(
          prefixIcon: Icons.lock,
          title: 'Confirm Password',
          hintText: '********',
          obscureText: viewModel.obscurePassword.value ? true : false,
          suffixIconButton: ObscureSuffixIcon(
            isObscured: viewModel.obscurePassword.value ? true : false,
            onPressed: () {
              viewModel.obscurePassword.value =
                  !viewModel.obscurePassword.value;
            },
          ),
          controller: viewModel.confirmPasswordController,
          autoValidateMode: AutovalidateMode.onUserInteraction,
          validator: (value) {
            return Validator.validateConfirmPassword(
                value, viewModel.passwordController.text);
          },
          keyboardType: TextInputType.emailAddress,
        ),
      ),
    );
  }

  Widget logo() {
    return Padding(
      padding:
          const EdgeInsets.only(left: 35.0, right: 35, top: 41, bottom: 41),
      child: ClipRRect(
          borderRadius: BorderRadius.circular(1.0),
          child: Image.asset(
            //semanticsLabel: 'My SVG Picture',
            'assets/images/reset_password_img.png',
            //fit: BoxFit.fill,
          )),
    );
  }

  Widget resetBtn() {
    return Padding(
        padding: const EdgeInsets.only(top: 32),
        child: CustomTextBtn(
          radius: 30,
          child: const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomText(
                title: "Reset",
                size: 14,
                color: AppColors.white,
                weight: FontWeight.w500,
              ),
            ],
          ),
          onPressed: () {
            viewModel.resetPswordApi();
          },
        ));
  }
}
