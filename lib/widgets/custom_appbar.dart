import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ismmart_ecommerce/helpers/app_colors.dart';
import 'package:ismmart_ecommerce/helpers/theme_helper.dart';

import 'custom_text.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final bool? menuItem;
  final String? title;
  final List<Widget>? action;
  final Widget? leading;
  final double? height;
  final Widget? searchBar;
  final bool? centerTitle;
  final double? leadingWidth, elevation;
  final void Function()? onTap;
  final bool? backBtn;
  final Style? styleType;

  const CustomAppBar(
      {super.key,
      required this.title,
      this.menuItem,
      this.action,
      this.leading,
      this.height = 55,
      this.searchBar,
      this.centerTitle,
      this.leadingWidth,
      this.elevation = 0,
      this.onTap,
      this.backBtn = true,
      this.styleType});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: backBtn!,
      leadingWidth: leadingWidth,
      elevation: elevation ?? 0,
      centerTitle: centerTitle,
      //backgroundColor: kAppBarColor,
      actions: action,
      flexibleSpace: _getStyle(),
      title: Center(
        child: searchBar ??
            CustomText(
                title: title ?? '',
                // style: appBarTitleSize,
                style: ThemeHelper.textTheme.bodyMedium?.copyWith(
                  color: AppColors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                )),
      ),
      leading: leading ??
          (menuItem != null
              ? null
              : InkWell(
                  onTap: onTap ??
                      () {
                        Get.back();
                      },
                  child: const Icon(
                    Icons.arrow_back_ios,
                    // color: kPrimaryColor,
                    size: 20,
                  ),
                )),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(height!);

  _getStyle() {
    switch (styleType) {
      case Style.bgShadow:
        return Container(
          height: 44,
          width: double.maxFinite,
          decoration: const BoxDecoration(
            // color: whiteA700,
            boxShadow: [
              BoxShadow(
                // color: black900.withOpacity(0.05),
                spreadRadius: 2,
                blurRadius: 2,
                offset: Offset(0, 1),
              ),
            ],
          ),
        );
      case Style.bgShadow_1:
        return Container(
          height: 82,
          width: double.maxFinite,
          decoration: const BoxDecoration(
            // color: whiteA700,
            boxShadow: [
              BoxShadow(
                // color: black900.withOpacity(0.08),
                spreadRadius: 2,
                blurRadius: 2,
                offset: Offset(0, 1),
              ),
            ],
          ),
        );
      case Style.bgFill:
        return Container(
          height: 55,
          width: double.maxFinite,
          decoration: const BoxDecoration(
              // color: whiteA700,
              ),
        );
      default:
        return null;
    }
  }
}
//
// class CustomAppBar1 extends StatelessWidget implements PreferredSizeWidget {
//   const CustomAppBar1({
//     super.key,
//     this.height,
//     this.styleType,
//     this.leadingWidth,
//     this.leading,
//     this.title,
//     this.centerTitle,
//     this.actions,
//   });
//
//   final double? height;
//
//   final Style? styleType;
//
//   final double? leadingWidth;
//
//   final Widget? leading;
//
//   final Widget? title;
//
//   final bool? centerTitle;
//
//   final List<Widget>? actions;
//
//   @override
//   Widget build(BuildContext context) {
//     return AppBar(
//       elevation: 0,
//       toolbarHeight: height ?? 44,
//       automaticallyImplyLeading: false,
//       backgroundColor: Colors.transparent,
//       flexibleSpace: _getStyle(),
//       leadingWidth: leadingWidth ?? 0,
//       leading: leading,
//       title: title,
//       titleSpacing: 0,
//       centerTitle: centerTitle ?? false,
//       actions: actions,
//     );
//   }
//
//   @override
//   Size get preferredSize => Size(
//         mediaQueryData.size.width,
//         height ?? 44.v,
//       );
//
//   _getStyle() {
//     switch (styleType) {
//       case Style.bgShadow:
//         return Container(
//           height: 44.v,
//           width: double.maxFinite,
//           decoration: BoxDecoration(
//             // color: whiteA700,
//             boxShadow: [
//               BoxShadow(
//                 // color: black900.withOpacity(0.05),
//                 spreadRadius: 2.h,
//                 blurRadius: 2.h,
//                 offset: const Offset(0, 1),
//               ),
//             ],
//           ),
//         );
//       case Style.bgShadow_1:
//         return Container(
//           height: 82.v,
//           width: double.maxFinite,
//           decoration: BoxDecoration(
//             // color: whiteA700,
//             boxShadow: [
//               BoxShadow(
//                 // color: black900.withOpacity(0.08),
//                 spreadRadius: 2.h,
//                 blurRadius: 2.h,
//                 offset: const Offset(0, 1),
//               ),
//             ],
//           ),
//         );
//       case Style.bgFill:
//         return Container(
//           height: 55.v,
//           width: double.maxFinite,
//           decoration: const BoxDecoration(
//               // color: whiteA700,
//               ),
//         );
//       default:
//         return null;
//     }
//   }
// }

class CustomAppBar2 extends StatelessWidget implements PreferredSizeWidget {
  final String? title;
  final Widget? leading;
  final Color? appBarColor;
  final List<Widget>? actions;
  final PreferredSizeWidget? bottom;
  final TextStyle? titleTextStyle;
  final bool? centerTitle;
  final bool containsLeading;
  final VoidCallback? leadingOnPressed;

  const CustomAppBar2({
    super.key,
    this.title,
    this.centerTitle,
    this.appBarColor,
    this.actions,
    this.leading,
    this.bottom,
    this.titleTextStyle,
    this.containsLeading = false,
    this.leadingOnPressed
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: centerTitle,
      elevation: 1,
      shadowColor: AppColors.kTextFieldBorderColor,
      title: title != null
          ? Text(
              title!,
              style: titleTextStyle ??
                  GoogleFonts.inter(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: AppColors.black),
            )
          : null,
      backgroundColor: appBarColor ?? AppColors.white,
      leading: containsLeading
          ? leading ??
              IconButton(
                onPressed: leadingOnPressed ?? () {
                  Get.back();
                },
                icon: Icon(
                  Icons.arrow_back_ios_new_rounded,
                  color: AppColors.black,
                ),
              )
          : null,
      actions: actions,
      bottom: bottom,
      systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: Colors.white,
          statusBarIconBrightness: Brightness.dark,

          /// For Android
          statusBarBrightness: Brightness.light

          /// For iOS
          ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(
      kToolbarHeight + (bottom == null ? 0 : kBottomNavigationBarHeight));
}

enum Style {
  bgShadow,
  bgShadow_1,
  bgFill,
}
