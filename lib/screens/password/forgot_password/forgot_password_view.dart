import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ismmart_ecommerce/helpers/app_colors.dart';
import 'package:ismmart_ecommerce/helpers/app_strings.dart';
import 'package:ismmart_ecommerce/widgets/custom_text.dart';

import '../../../widgets/custom_button.dart';
import '../../../widgets/custom_image_widget/custom_image_view.dart';
import '../../../widgets/custom_text_field.dart';
import '../reset_password/reset_password_view.dart';

class ForgotPasswordView extends StatelessWidget {
  const ForgotPasswordView({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            const Padding(
              padding: EdgeInsets.all(20.0),
              child: CustomText(
                title: "Forgot Password",
                size: 20,
                weight: FontWeight.bold,
              ),
            ),
            CustomImageView(
              imagePath: 'assets/images/forgot_password.png',
              height: 200,
              width: 200,
              fit: BoxFit.cover,
              alignment: Alignment.center,
            ),
            _resetPasswordForm(context),
            _rememberAccount(),
          ],
        ),
      ),
    );
  }

  Widget _resetPasswordForm(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.only(top: 8.0, bottom: 8),
              child: CustomText(
                title: "Resest Password",
                size: 20,
                weight: FontWeight.bold,
              ),
            ),
            CustomText(title: AppStrings.resetPassword),
            emailTextField(),
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: _resetPasswordBtn(),
            ),
          ],
        ),
      ),
    );
  }

  Widget emailTextField() {
    return Padding(
      padding: const EdgeInsets.only(top: 32),
      child: CustomTextField1(
        prefixIcon: Icons.person,
        title: 'Email / Phone Number',
        hintText: 'asha****iq11@gmail.com',
        //controller: viewModel.emailController,
        autoValidateMode: AutovalidateMode.onUserInteraction,
        validator: (value) {
          //return Validator.validateEmail(value);
        },
        keyboardType: TextInputType.emailAddress,
      ),
    );
  }

  Widget _resetPasswordBtn() {
    return Padding(
      padding: const EdgeInsets.only(top: 32),
      child: CustomTextBtn(
        backgroundColor: AppColors.black,
        radius: 30,
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Reset",
            ),
            SizedBox(width: 4),
            Icon(
              Icons.arrow_forward,
              size: 20,
            ),
          ],
        ),
        onPressed: () {
          //viewModel.signIn();
          Get.to(() => const ResetPasswordView());
        },
      ),
    );
  }

  Widget _rememberAccount() {
    return Align(
      alignment: Alignment.bottomCenter,
      child: TextButton(
        onPressed: () {
          //Get.to(() => SingupMethodsView());
        },
        child: Center(
          child: RichText(
            text: const TextSpan(
              children: [
                TextSpan(
                  text: "Remember your account?",
                  style: TextStyle(
                    color: AppColors.grey4,
                  ),
                ),
                TextSpan(
                  text: " Sign In",
                  style: TextStyle(
                    color: AppColors.black,
                    fontWeight: FontWeight.bold,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
