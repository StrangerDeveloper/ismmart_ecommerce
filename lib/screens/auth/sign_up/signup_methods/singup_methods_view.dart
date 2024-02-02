import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ismmart_ecommerce/screens/auth/sign_up/signup_methods/signup_mehods_viewmodel.dart';

import '../../../../widgets/custom_appbar.dart';
import '../../../../widgets/custom_button.dart';
import '../../../../widgets/custom_text.dart';
import '../../../../widgets/loader_view.dart';
import '../../login/login_view.dart';

class SingupMethodsView extends StatelessWidget {
  SingupMethodsView({super.key});
  final SignupMehtodsViewModel viewModel = Get.put(SignupMehtodsViewModel());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Scaffold(
        appBar: CustomAppBar2(
          title: 'Sign Up',
          // titleTextStyle: appbarFontStyle,
        ),
        backgroundColor: Colors.white,
        body: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 52, bottom: 10),
                    child: CustomText(
                      title: 'Get onboard!',
                      // style: newFontStyleSize20,
                    ),
                  ),
                  Padding(
                      padding:
                          const EdgeInsets.only(right: 20, bottom: 32, top: 16),
                      child: Text(
                        'Create your account',
                        // style: newFontStyleSize14)
                      )),
                  signUpEmail(),
                  // signupNumber(),

                  orWidget(),
                  googlelogInBtn(),
                  // facebooklogInBtn(),
                  //   if (Platform.isIOS) applelogInBtn(),
                  const Spacer(),
                  doNotHaveAnAccount(),
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
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Continue with email',
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
            // Get.to(SignUp1View());
            // Get.offNamed(Routes.dashboard);
            //
          },
        ));
  }

  Widget signupNumber() {
    return Padding(
        padding: const EdgeInsets.only(top: 22),
        child: CustomTextBtn(
          // padding: const EdgeInsets.only(top: 5),
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
          radius: 30,
          borderSide: const BorderSide(
            color: Colors.black, // your color here
            width: 1,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Continue with phone number',

                // style: newFontStyleSize14.copyWith(
                //     color: newColorDarkBlack, fontWeight: FontWeight.w600),
              ),
              SizedBox(width: 4),
              const Icon(
                Icons.arrow_forward,
                size: 20,
                // color: newColorDarkBlack,
              ),
            ],
          ),
          onPressed: () {
            // Get.to(SignUp1View());
            // Get.offNamed(Routes.dashboard);
            //
          },
        ));
  }

  Widget orWidget() {
    return Padding(
      padding: const EdgeInsets.only(top: 24, bottom: 24),
      child: Row(
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
              "or",
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
      ),
    );
  }

//Google Button
  Widget googlelogInBtn() {
    return customImageBtn(
        title: 'Sign in with Gmail',
        imagePath: 'assets/images/googleIcon.svg',
        onPressed: () {
          // viewModel.googleLogIn();
        });
  }

  Widget applelogInBtn() {
    return Padding(
      padding: const EdgeInsets.only(top: 20),
      child: CustomTextBtn(
        radius: 30,
        borderSide: const BorderSide(
          color: Colors.black, // your color here
          width: 1,
        ),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/logo/apple_logo.png',
            ),
            const SizedBox(
              width: 5,
            ),
            const Text(
              "Signin with Apple ID",
            ),
          ],
        ),
        onPressed: () {
          // viewModel.appleSignin();
        },
      ),
    );
  }

  Widget doNotHaveAnAccount() {
    return Padding(
      padding: const EdgeInsets.only(top: 133),
      child: Center(
        child: TextButton(
          onPressed: () {
            Get.to(() => LogInView());
          },
          child: RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: 'Already have an account?',
                  // style:
                  //     newFontStyleSize14.copyWith(color: newColorLightGrey2)
                ),
                TextSpan(
                  text: " Login",
                  // style: newFontStyleSize14.copyWith(
                  //     fontWeight: FontWeight.w700)),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
