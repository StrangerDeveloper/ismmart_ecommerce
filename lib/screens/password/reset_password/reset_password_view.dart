import 'package:flutter/material.dart';
import 'package:ismmart_ecommerce/widgets/custom_appbar.dart';

import '../../../helpers/app_colors.dart';
import '../../../helpers/app_strings.dart';
import '../../../widgets/custom_button.dart';
import '../../../widgets/custom_image_widget/custom_image_view.dart';
import '../../../widgets/custom_text.dart';
import '../../../widgets/custom_text_field.dart';

class ResetPasswordView extends StatelessWidget {
  const ResetPasswordView({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: CustomAppBar2(
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back_ios,
              color: AppColors.black,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: Column(
          children: [
            CustomImageView(
              imagePath: 'assets/images/forgot_password.png',
              height: 200,
              width: 200,
              fit: BoxFit.cover,
              alignment: Alignment.center,
            ),
            _resetPasswordForm(context),
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
            CustomText(title: "Set your new password"),
            _newPassword(),
            _confirmPassword(),
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: _resetPasswordBtn(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _newPassword() {
    return Padding(
      padding: const EdgeInsets.only(top: 32),
      child: CustomTextField1(
        prefixIcon: Icons.lock,
        suffixIcon: Icons.remove_red_eye_outlined,
        title: 'New Password',
        hintText: '********',
        //controller: viewModel.emailController,
        autoValidateMode: AutovalidateMode.onUserInteraction,
        validator: (value) {
          //return Validator.validateEmail(value);
        },
        keyboardType: TextInputType.emailAddress,
      ),
    );
  }

  Widget _confirmPassword() {
    return Padding(
      padding: const EdgeInsets.only(top: 32),
      child: CustomTextField1(
        prefixIcon: Icons.lock,
        suffixIcon: Icons.remove_red_eye_outlined,
        title: 'Confirm Password',
        hintText: '********',
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
              // style: newFontStyleSize14.copyWith(
              //     fontWeight: FontWeight.w500, color: kWhiteColor),kWhiteColor
            ),
          ],
        ),
        onPressed: () {
          //viewModel.signIn();
          //
        },
      ),
    );
  }
}
