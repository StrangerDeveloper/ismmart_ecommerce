import 'dart:io';

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:ismmart_ecommerce/helpers/app_colors.dart';
import 'package:ismmart_ecommerce/helpers/theme_helper.dart';
import 'package:ismmart_ecommerce/widgets/custom_text.dart';
import '../../../helpers/app_routes.dart';
import '../../../helpers/validator.dart';
import '../../../widgets/custom_button.dart';
import '../../../widgets/custom_text_field.dart';
import '../../../widgets/loader_view.dart';
import '../../../widgets/obscure_suffix_icon.dart';
import '../forgot_password/forget_password/forgot_password_view.dart';
import 'login_viewmodel.dart';

class LogInView extends StatelessWidget {
  LogInView({super.key});
  final LogInViewModel viewModel = Get.put(LogInViewModel());
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        body: Stack(
          children: [
            SingleChildScrollView(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 26, horizontal: 25),
                child: Form(
                  key: viewModel.signInFormKey,
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Gap(26),
                        login(),
                        logo(),
                        wellcomeBackText(),
                        emailTextField(),
                        passwordTextField(),
                        forgotPassword(),
                        logInBtn(),

                        orWidget(),
                        googlelogInBtn(),
                        // facebooklogInBtn(),
                        if (Platform.isIOS) applelogInBtn(),
                        const Gap(54),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            doNotHaveAnAccount(),
            const LoaderView()
          ],
        ),
      ),
    );
  }

  Widget emailTextField() {
    return CustomTextField1(
      prefixIcon: Icons.person,
      title: 'Email',
      hintText: 'Email  ',
      controller: viewModel.emailController,
      autoValidateMode: AutovalidateMode.onUserInteraction,
      validator: (value) {
        return Validator.validateDefaultField(value,
            errorMessage: "Required Email");
      },
      keyboardType: TextInputType.emailAddress,
    );
  }

  Widget passwordTextField() {
    return Obx(
      () => Padding(
        padding: const EdgeInsets.only(
          top: 16,
        ),
        child: CustomTextField1(
          prefixIcon: Icons.lock,
          controller: viewModel.passwordController,
          title: "Password",
          hintText: '***********',
          autoValidateMode: AutovalidateMode.onUserInteraction,
          validator: (value) {
            return Validator.validatePassword(value);
          },
          obscureText: viewModel.obscurePassword.value ? true : false,
          suffixIconButton: ObscureSuffixIcon(
            isObscured: viewModel.obscurePassword.value ? true : false,
            onPressed: () {
              viewModel.obscurePassword.value =
                  !viewModel.obscurePassword.value;
            },
          ),
        ),
      ),
    );
  }

  //Facebook Button
  // Widget facebooklogInBtn() {
  //   return Padding(
  //     padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
  //     child: CustomRoundedTextBtn(
  //       borderSide: const BorderSide(
  //         color: Colors.black, // your color here
  //         width: 1,
  //       ),
  //       backgroundColor: Colors.white,
  //       foregroundColor: Colors.black,
  //       child: Row(
  //         mainAxisAlignment: MainAxisAlignment.center,
  //         children: [
  //           ClipRRect(
  //             borderRadius: BorderRadius.circular(50.0),
  //             child: Image.asset(
  //               'assets/logo/fb_logo.png',
  //               width: 36,
  //               height: 36,
  //             ),
  //           ),
  //           const SizedBox(
  //             width: 5,
  //           ),
  //           const Text(
  //             "Continue in with Facebok",
  //             // style: newFontStyle3,
  //           ),
  //         ],
  //       ),
  //       onPressed: () {
  //         // viewModel.signInWithApple();
  //       },
  //     ),
  //   );
  // }
  Widget forgotPassword() {
    return Align(
      alignment: Alignment.bottomRight,
      child: TextButton(
          onPressed: () {
            Get.to(() => ForgotPasswordView1(),
                arguments: viewModel.emailController.text);
          },
          child: Text(
            'Forget Password?',
            style: ThemeHelper.textTheme.labelMedium?.copyWith(
                fontWeight: FontWeight.w600, color: AppColors.black3),
          )),
    );
  }

  Widget logInBtn() {
    return Padding(
        padding: const EdgeInsets.only(top: 32),
        child: CustomTextBtn(
          radius: 30,
          child: const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomText(
                title: "Login",
                size: 14,
                color: AppColors.white,
                weight: FontWeight.w500,
              ),
              SizedBox(width: 2),
              Icon(
                Icons.arrow_forward,
                size: 20,
              ),
            ],
          ),
          onPressed: () {
            viewModel.signIn();
            //
          },
        ));
  }

  Widget orWidget() {
    return const Padding(
      padding: EdgeInsets.only(top: 24, bottom: 24),
      child: Row(
        children: [
          Expanded(
            child: Divider(
              //color: newColorLightGrey,
              thickness: 1,
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Text(
              "Or",
              style: TextStyle(
                  color: AppColors.black, fontWeight: FontWeight.w500),
            ),
          ),
          Expanded(
            child: Divider(
              //color: newColorLightGrey,
              thickness: 1,
            ),
          ),
        ],
      ),
    );
  }

  //Google Button
  Widget googlelogInBtn() {
    return customImageBtn(
        isSvg: true,
        title: 'Sign in with Gmail',
        imagePath: 'assets/images/googleIcon.svg',
        onPressed: () {
          viewModel.googleLogIn();
        });
  }

  Widget applelogInBtn() {
    return customImageBtn(
        title: 'Sign in with Gmail',
        imagePath: 'assets/icons/apple_logo.png',
        onPressed: () {
          viewModel.appleSignin();
        });
  }

  Widget doNotHaveAnAccount() {
    return Padding(
      padding: EdgeInsets.only(top: Get.height * .9),
      child: TextButton(
        onPressed: () {
          Get.offNamed(AppRoutes.singupMethodsViewRoute);
        },
        child: Center(
          child: RichText(
            text: TextSpan(
              children: [
                TextSpan(
                    text: "Don't have an account?",
                    style: ThemeHelper.textTheme.bodyMedium
                        ?.copyWith(color: AppColors.grey2)),
                TextSpan(
                    text: " Create Account",
                    style: ThemeHelper.textTheme.bodyMedium
                        ?.copyWith(fontWeight: FontWeight.w700)),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget login() {
    return Row(
      //mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        InkWell(
          onTap: () => Get.back(),
          child: const Icon(
            Icons.arrow_back_ios_new_rounded,
          ),
        ),
        Expanded(
          child: Align(
            alignment: Alignment.center,
            child: Text(
              "Login",
              style: ThemeHelper.textTheme.titleMedium,
            ),
          ),
        ),
      ],
    );
  }

  Widget logo() {
    return Padding(
      padding:
          const EdgeInsets.only(left: 128.0, right: 128, top: 41, bottom: 41),
      child: ClipRRect(
          borderRadius: BorderRadius.circular(1.0),
          child: Image.asset(
            //semanticsLabel: 'My SVG Picture',
            'assets/images/logo1.png',
            //fit: BoxFit.fill,
          )),
    );
  }

  wellcomeBackText() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Welcome Back!',
          style: ThemeHelper.textTheme.titleSmall,
        ),
        Padding(
            padding: const EdgeInsets.only(
              top: 8,
              right: 20,
              bottom: 32,
            ),
            child: Text(
              maxLines: 2,
              'Please login or sign up to continue our app',
              style: ThemeHelper.textTheme.bodyMedium
                  ?.copyWith(color: AppColors.grey2),
            )),
      ],
    );
  }
}
