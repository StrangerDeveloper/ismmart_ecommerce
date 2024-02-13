import 'package:flutter/material.dart';
import 'package:ismmart_ecommerce/helpers/app_colors.dart';
import 'package:ismmart_ecommerce/helpers/theme_helper.dart';

class CustomText extends StatelessWidget {
  final String title;
  final double? size;
  final Color? color;
  final int? maxLines;
  final TextStyle? style;
  final FontWeight? weight;
  final TextAlign? textAlign;

  const CustomText({
    super.key,
    required this.title,
    this.style,
    this.size,
    this.color,
    this.textAlign,
    this.weight,
    this.maxLines = 2,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      overflow: TextOverflow.ellipsis,
      maxLines: maxLines,
      textAlign: textAlign ?? TextAlign.start,
      style: style ??
          ThemeHelper.textTheme.bodyMedium!.copyWith(
            fontSize: size ?? 13,
            color: color ?? AppColors.black,
            fontWeight: weight ?? FontWeight.w600,
          ),
    );
  }
}
