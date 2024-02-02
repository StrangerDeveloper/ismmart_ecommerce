import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:ismmart_ecommerce/helpers/app_colors.dart';
import 'package:ismmart_ecommerce/widgets/custom_text.dart';

import 'custom_image_widget/custom_image_view.dart';

//FINAL VERSION...
class CustomTextBtn extends StatelessWidget {
  final String title;
  final VoidCallback? onPressed;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final double height;
  final double width;
  final Widget? child;
  final double radius;
  final EdgeInsetsGeometry? padding;
  final MaterialTapTargetSize? tapTargetSize;
  final OutlinedBorder? shape;
  final BorderSide borderSide;

  const CustomTextBtn({
    super.key,
    this.height = 40,
    this.title = "",
    this.width = double.infinity,
    required this.onPressed,
    this.backgroundColor = AppColors.primary,
    this.foregroundColor = Colors.white,
    this.child,
    this.radius = 8,
    this.padding,
    this.tapTargetSize,
    this.borderSide = BorderSide.none,
    this.shape,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      style: TextButton.styleFrom(
        padding: padding,
        tapTargetSize: tapTargetSize,
        backgroundColor: backgroundColor,
        foregroundColor: foregroundColor,
        minimumSize: Size(width, height),
        side: borderSide,
        shape: (shape != null)
            ? shape
            : RoundedRectangleBorder(
                side: borderSide,
                borderRadius: BorderRadius.circular(radius),
              ),
      ),
      child: child ??
          Text(
            title,
            style: const TextStyle(fontSize: 12),
          ),
    );
  }
}

//FINAL VERSION...
class CustomIconTextBtn extends StatelessWidget {
  final String title;
  final VoidCallback? onPressed;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final double height;
  final double width;
  final double radius;
  final EdgeInsetsGeometry? padding;
  final MaterialTapTargetSize? tapTargetSize;
  final OutlinedBorder? shape;
  final BorderSide borderSide;
  final IconData icon;

  const CustomIconTextBtn({
    super.key,
    this.height = 40,
    required this.title,
    this.width = double.minPositive,
    required this.onPressed,
    this.backgroundColor = AppColors.primary,
    this.foregroundColor = Colors.white,
    this.radius = 8,
    this.padding,
    this.tapTargetSize,
    this.borderSide = BorderSide.none,
    this.shape,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      style: TextButton.styleFrom(
        padding: padding,
        tapTargetSize: tapTargetSize,
        backgroundColor: backgroundColor,
        foregroundColor: foregroundColor,
        minimumSize: Size(width, height),
        side: borderSide,
        shape: (shape != null)
            ? shape
            : RoundedRectangleBorder(
                side: borderSide,
                borderRadius: BorderRadius.circular(radius),
              ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              size: 16,
            ),
            const Gap(8),
            CustomText(
              title: title,
              size: 10,
            ),
          ],
        ),
      ),
    );
  }
}

//img Btn

Widget customImageBtn(
    {required String title,
    required Function()? onPressed,
    required String imagePath}) {
  return CustomTextBtn(
      radius: 30,
      borderSide: const BorderSide(
        // color: newColorLightGrey, // your color here
        width: 1,
      ),
      backgroundColor: Colors.white,
      foregroundColor: Colors.black,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(50.0),
            child: CustomImageView(
              imagePath: imagePath,
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          Text(title),
        ],
      ),
      onPressed: onPressed);
}

// //FINAL VERSION...
// class CustomIconBtn extends StatelessWidget {
//   final IconData icon;
//   final bool enabled;
//   final double? iconSize;
//   final void Function()? onTap;
//
//   const CustomIconBtn({
//     super.key,
//     this.iconSize,
//     this.enabled = true,
//     required this.icon,
//     this.onTap,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return InkWell(
//       onTap: onTap,
//       borderRadius: BorderRadius.circular(8),
//       child: Container(
//         padding: const EdgeInsets.all(8),
//         child: Icon(
//                 icon,
//                 color: enabled ? null : Colors.grey.shade400,
//                 size: iconSize ?? 15,
//               )
//       ),
//     );
//   }
// }
//
//FINAL VERSION...
class CustomIconBtn2 extends StatelessWidget {
  final IconData icon;
  final void Function()? onTap;
  final Color? color;

  const CustomIconBtn2({
    super.key,
    required this.icon,
    this.onTap,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Icon(icon, size: 15, color: color ?? Colors.black),
      ),
    );
  }
}
