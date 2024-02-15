import 'package:flutter/material.dart';
import 'package:ismmart_ecommerce/helpers/theme_helper.dart';
import '../helpers/app_colors.dart';

class CustomHeadingAndSubHeadingText extends StatelessWidget {
  final String? headingText;
  final String? subHeadingText;

  const CustomHeadingAndSubHeadingText({
    super.key,
    required this.headingText,
    required this.subHeadingText,
  });

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Padding(
        padding: const EdgeInsets.only(bottom: 10),
        child: Text(headingText!, style: ThemeHelper.textTheme.titleLarge

            // GoogleFonts.inter(
            //   fontWeight: FontWeight.w700,
            //   fontSize: 20,
            // ),
            ),
      ),
      Text(
        subHeadingText!,
        style:
            ThemeHelper.textTheme.bodyMedium!.copyWith(color: AppColors.grey2),
      )
    ]);
  }
}
