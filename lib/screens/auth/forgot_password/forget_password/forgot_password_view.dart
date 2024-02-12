import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import '../../../../helpers/app_colors.dart';
import '../../../../helpers/theme_helper.dart';
import '../../../../helpers/validator.dart';
import '../../../../widgets/custom_appbar.dart';
import '../../../../widgets/custom_button.dart';
import '../../../../widgets/custom_text.dart';
import '../../../../widgets/custom_text_field.dart';
import '../../../../widgets/loader_view.dart';
import '../otp_verification/otp_verification_view.dart';
import 'forgot_password_viewmodel.dart';

class ForgotPasswordView1 extends StatelessWidget {
  ForgotPasswordView1({super.key});
  final ForgotPasswordViewModel viewModel = Get.put(ForgotPasswordViewModel());

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
                padding:
                    const EdgeInsets.symmetric(horizontal: 25, vertical: 26),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    logo(),
                    headings(),
                    emailTextField(),
                    resetBtn(),
                    remeberMe(),
                  ],
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
      title: 'Forget Password',
      titleTextStyle: ThemeHelper.textTheme.titleMedium,
      centerTitle: true,
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
            errorMessage: "Required Email/Phone No");
      },
      keyboardType: TextInputType.emailAddress,
    );
  }

  Widget title() {
    return Padding(
      padding: const EdgeInsets.only(top: 50.0),
      child: Align(
        alignment: Alignment.center,
        child: Text(
          "Forget Password",
          style: ThemeHelper.textTheme.titleMedium,
        ),
      ),
    );
  }

  Widget logo() {
    return Padding(
      padding:
          const EdgeInsets.only(left: 35.0, right: 35, top: 41, bottom: 41),
      child: Container(
        // color: Colors.green,

        child: ClipRRect(
            borderRadius: BorderRadius.circular(1.0),
            child: Image.asset(
              //semanticsLabel: 'My SVG Picture',
              'assets/images/forgetpassword_Img.png',
              //fit: BoxFit.fill,
            )),
      ),
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
              bottom: 32,
            ),
            child: Text(
              maxLines: 2,
              'Enter Email account to reset your password',
              style: ThemeHelper.textTheme.bodyMedium
                  ?.copyWith(color: AppColors.grey2),
            )),
      ],
    );
  }

  Widget resetBtn() {
    return Padding(
        padding: const EdgeInsets.only(top: 32),
        child: CustomTextBtn(
          radius: 30,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const CustomText(
                title: "Reset",
                size: 14,
                color: AppColors.white,
                weight: FontWeight.w500,
              ),
              SizedBox(width: 2),
              const Icon(
                Icons.arrow_forward,
                size: 20,
              ),
            ],
          ),
          onPressed: () {
            Get.to(() => OtpVerificationView());
            // viewModel.signIn();
            //
          },
        ));
  }

  Widget remeberMe() {
    return Padding(
      padding: EdgeInsets.only(top: Get.height * .17),
      child: TextButton(
        onPressed: () {
          // Get.to(() => SignUpMethodsView());
          // Get.toNamed(AppRoutes.singupMethodsViewRoute);
        },
        child: Center(
          child: RichText(
            text: TextSpan(
              children: [
                TextSpan(
                    text: "Remember your account?",
                    style: ThemeHelper.textTheme.bodyMedium
                        ?.copyWith(color: AppColors.grey2)),
                TextSpan(
                    text: " Sign In", style: ThemeHelper.textTheme.labelMedium),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
