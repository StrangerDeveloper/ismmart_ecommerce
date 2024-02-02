import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../helpers/app_colors.dart';
import 'custom_text.dart';

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
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: CustomText(
              title: headingText!,
              style: GoogleFonts.inter(
                fontWeight: FontWeight.w700,
                fontSize: 20,
              ),
            ),
          ),
          CustomText(
            title: subHeadingText!,
            style: GoogleFonts.inter(
                fontWeight: FontWeight.w400,
                fontSize: 14,
                color: AppColors.grey2
            ),
          )
        ]
    );
  }
}