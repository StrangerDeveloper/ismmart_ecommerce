import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ismmart_ecommerce/helpers/app_colors.dart';
import 'package:ismmart_ecommerce/screens/auth/sign_up/signup_methods/signup_mehods_viewmodel.dart';
import 'package:ismmart_ecommerce/widgets/custom_heading_and_subheading_text.dart';
import 'package:ismmart_ecommerce/widgets/custom_text.dart';
import '../../../../helpers/app_routes.dart';
import '../../../../helpers/theme_helper.dart';
import '../../../../widgets/custom_appbar.dart';
import '../../../../widgets/custom_button.dart';
import '../../../../widgets/loader_view.dart';
import '../signup/signup_view.dart';

class SignUpMethodsView extends StatelessWidget {
  SignUpMethodsView({super.key});

  final SignupMehtodViewModel viewModel = Get.put(SignupMehtodViewModel());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Scaffold(
        appBar: appbar(),
        // backgroundColor: AppColors.white,
        body: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  logo(),
                  getOnBaordHeading(),
                  signUpEmail(),
                  // signupNumber(),
                  orWidget(),
                  if (Platform.isAndroid) googleLogInBtn(),
                  // facebooklogInBtn(),
                  if (Platform.isIOS) appleLogInBtn(),
                  const Spacer(),
                  Align(
                      alignment: Alignment.bottomCenter,
                      child: doNotHaveAnAccount()),
                ],
              ),
            ),
            const LoaderView(),
          ],
        ),
      ),
    );
  }

  Widget signUpEmail() {
    return Padding(
        padding: const EdgeInsets.only(top: 32),
        child: CustomTextBtn(
          radius: 30,
          child: const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomText(
                title: 'Continue with email',
                color: Colors.white,
                size: 14,
                weight: FontWeight.w500,
              ),
              SizedBox(width: 4),
              Icon(
                Icons.arrow_forward,
                size: 20,
              ),
            ],
          ),
          onPressed: () {
            Get.to(SignUpView());
            //
          },
        ));
  }

  Widget signupNumber() {
    return Padding(
        padding: const EdgeInsets.only(top: 16),
        child: CustomTextBtn(
          radius: 30,
          borderSide: const BorderSide(
            color: AppColors.kTextFieldBorderColor, // your color here
            width: 1.5,
          ),
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
          child: const CustomText(
            title: 'Continue with phone Number',
            color: AppColors.black3,
            size: 14,
            weight: FontWeight.w500,
          ),
          onPressed: () {
            Get.toNamed(AppRoutes.signUpViewRoute);
            // Get.to(SignUp1View());
            // Get.offNamed(Routes.dashboard);
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
              color: AppColors.kTextFieldBorderColor,
              thickness: 1,
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Text(
              "or",
            ),
          ),
          Expanded(
            child: Divider(
              color: AppColors.kTextFieldBorderColor,
              thickness: 1,
            ),
          ),
        ],
      ),
    );
  }

  Widget googleLogInBtn() {
    return customImageBtn(
        title: 'Sign Up with Gmail',
        imagePath: 'assets/icons/google_logo.png',
        onPressed: () {
          viewModel.googleLogIn();
        });
  }

  Widget appleLogInBtn() {
    return customImageBtn(
        title: 'Sign Up with Apple',
        imagePath: 'assets/icons/apple_logo.png',
        onPressed: () {
          viewModel.appleSignin();
        });
  }

  Widget doNotHaveAnAccount() {
    return Center(
      child: TextButton(
        onPressed: () {
          //Get.to(() => LogInView());
          Get.offNamed(AppRoutes.loginViewRoute);
        },
        child: RichText(
          text: TextSpan(
            children: [
              TextSpan(
                  text: 'Already have an account?',
                  style: ThemeHelper.textTheme.labelMedium!
                      .copyWith(color: AppColors.grey2)),
              TextSpan(
                  text: "\t\tLogin",
                  style: ThemeHelper.textTheme.bodyMedium!
                      .copyWith(fontWeight: FontWeight.w700))
            ],
          ),
        ),
      ),
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

  PreferredSizeWidget appbar() {
    return CustomAppBar2(
      title: 'Sign Up',
      titleTextStyle: ThemeHelper.textTheme.titleMedium,
      centerTitle: true,
      containsLeading: true,
    );
  }

  Widget getOnBaordHeading() {
    return const CustomHeadingAndSubHeadingText(
        headingText: 'Get onboard!', subHeadingText: 'Create your account');
  }
}
