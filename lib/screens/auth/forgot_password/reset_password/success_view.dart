import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:ismmart_ecommerce/helpers/app_routes.dart';

import '../../../../helpers/app_colors.dart';
import '../../../../helpers/theme_helper.dart';
import '../../../../widgets/custom_button.dart';
import '../../../../widgets/custom_text.dart';

class SuccessView extends StatelessWidget {
  const SuccessView({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Stack(
          children: [
            SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      headings(),
                      Gap(82),
                      Text(
                        "Password Reset",
                        style: ThemeHelper.textTheme.bodyLarge,
                      ),
                      Gap(10),
                      Icon(
                        Icons.check,
                        size: 24,
                        color: AppColors.limeGreen,
                      ),
                      Gap(10),
                      Text(
                        textAlign: TextAlign.center,
                        "Your password has been reset. Please login with new password.",
                        style: ThemeHelper.textTheme.bodySmall?.copyWith(
                            color: AppColors.grey2,
                            fontWeight: FontWeight.w500),
                      ),
                      Gap(82),
                      logInBtn(),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget headings() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Gap(126),
        Text(
          'Successful!',
          style: ThemeHelper.textTheme.headlineLarge,
        ),
      ],
    );
  }

  Widget btn() {
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
            // viewModel.resetPswordApi();
          },
        ));
  }

  Widget logInBtn() {
    return Padding(
        padding: const EdgeInsets.only(top: 32),
        child: CustomTextBtn(
          radius: 30,
          child: const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.arrow_back,
                size: 20,
              ),
              SizedBox(width: 2),
              CustomText(
                title: "Back to login",
                size: 14,
                color: AppColors.white,
                weight: FontWeight.w500,
              ),
            ],
          ),
          onPressed: () {
            Get.toNamed(AppRoutes.loginViewRoute);
            //
          },
        ));
  }
}
