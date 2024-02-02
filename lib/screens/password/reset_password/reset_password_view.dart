import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ismmart_ecommerce/screens/password/reset_password/reset_password_viewMOdel.dart';
import 'package:ismmart_ecommerce/widgets/custom_appbar.dart';

import '../../../helpers/app_colors.dart';
import '../../../helpers/validator.dart';
import '../../../widgets/custom_button.dart';
import '../../../widgets/custom_network_image.dart';
import '../../../widgets/custom_text.dart';
import '../../../widgets/custom_text_field.dart';
import '../../../widgets/obscure_suffix_icon.dart';

class ResetPasswordView extends StatelessWidget {
  final viewModel = Get.put(ResetPasswordViewModel());
  ResetPasswordView({super.key});

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
            const CustomNetworkImage(
              imageUrl: 'assets/images/forgot_password.png',
            ),
            _resetPasswordForm(context),
            _resetPasswordBtn(),
          ],
        ),
      ),
    );
  }

  Widget _resetPasswordForm(BuildContext context) {
    return Padding(
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
          const CustomText(title: "Set your new password"),
          _password("New Password"),
          _password("Confirm Password"),
        ],
      ),
    );
  }

  Widget _password(String title) {
    return Obx(
      () => Padding(
        padding: const EdgeInsets.only(top: 32),
        child: CustomTextField1(
          prefixIcon: Icons.lock,
          title: title,
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
            return Validator.validateEmail(value);
          },
          keyboardType: TextInputType.emailAddress,
        ),
      ),
    );
  }

  Widget _resetPasswordBtn() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: CustomTextBtn(
        width: 200,
        backgroundColor: AppColors.black,
        radius: 30,
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Reset",
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
