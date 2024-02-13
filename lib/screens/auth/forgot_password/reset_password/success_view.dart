import 'package:flutter/material.dart';

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
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    headings(),
                  ],
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
            child: CustomText(
              maxLines: 2,
              title: 'Set your new password',
              style: ThemeHelper.textTheme.bodyMedium
                  ?.copyWith(color: AppColors.grey2),
            )),
      ],
    );
  }

  Widget btn() {
    return Padding(
        padding: const EdgeInsets.only(top: 32),
        child: CustomTextBtn(
          radius: 30,
          child:const  Row(
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
}
