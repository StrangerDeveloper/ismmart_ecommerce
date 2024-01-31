import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:ismmart_ecommerce/helpers/app_colors.dart';

import '../helpers/common_function.dart';
import '../helpers/theme_helper.dart';

//FINAL VERSION...
class CustomTextField1 extends StatelessWidget {
  final String? title;
  final String? hintText;
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final int maxLines;
  final int? minLines;
  final GestureTapCallback? onTap;
  final FormFieldValidator<String>? validator;
  final bool obscureText;
  final AutovalidateMode? autoValidateMode;
  final bool asterisk;
  final bool? showCursor;
  final bool readOnly;
  final ValueChanged<String>? onChanged;
  final String? errorText;
  final Color fillColor;
  final bool filled;
  final bool isDropDown;
  final IconData? suffixIcon;
  final Widget? suffixIconButton;
  final IconData? prefixIcon;
  final EdgeInsetsGeometry contentPadding;
  final TextStyle? textStyle;
  final List<TextInputFormatter>? inputFormatters;
  final void Function(String)? onFieldSubmitted;
  final void Function()? onIconTap;
  final bool refreshIconVisibility;

  ///USAGE INFORMATION:
  ///
  /// (Note) : Only one of these can be used at a time...
  ///
  ///1 - suffixIconButton :- (widget) used for Clickable suffixIcon
  ///
  ///2- suffixIcon :- (IconData) used for static Icon
  ///
  ///3- ( isDropDown:true,  onTap:(){} ) :- To make text-field look like a dropDown use these
  ///
  ///
  const CustomTextField1({
    super.key,
    this.contentPadding = const EdgeInsets.symmetric(
      horizontal: 10,
      vertical: 10,
    ),
    this.onIconTap,
    this.asterisk = false,
    this.validator,
    this.onChanged,
    this.obscureText = false,
    this.autoValidateMode,
    this.title,
    this.hintText,
    this.controller,
    this.keyboardType,
    this.maxLines = 1,
    this.refreshIconVisibility = false,
    this.onTap,
    this.minLines,
    this.showCursor,
    this.suffixIcon,
    this.fillColor = AppColors.grey3,
    this.errorText,
    this.readOnly = false,
    this.textStyle,
    this.filled = true,
    this.isDropDown = false,
    this.prefixIcon,
    this.suffixIconButton,
    this.inputFormatters,
    this.onFieldSubmitted,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        (title == null)
            ? const SizedBox()
            : Padding(
                padding: const EdgeInsets.only(bottom: 8.5),
                child: RichText(
                  text: TextSpan(
                    text: title,
                    style: const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w500,
                    ),
                    children: [
                      (asterisk)
                          ? const TextSpan(
                              text: '*',
                              style: TextStyle(
                                color: Colors.red,
                                fontSize: 16,
                              ),
                            )
                          : const TextSpan(text: '')
                    ],
                  ),
                ),
              ),
        refreshIconVisibility
            ? Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: Get.width * 0.8,
                    child: TextFormField(
                      onFieldSubmitted: onFieldSubmitted,
                      inputFormatters: inputFormatters,
                      controller: controller,
                      keyboardType: keyboardType,
                      onTapOutside: (event) {
                        CommonFunction.closeKeyboard();
                      },
                      minLines: minLines,
                      maxLines: maxLines,
                      onChanged: onChanged,
                      showCursor: readOnly ? false : showCursor,
                      readOnly: isDropDown ? true : readOnly,
                      autovalidateMode: autoValidateMode,
                      obscureText: obscureText,
                      validator: validator,
                      onTap: onTap,
                      style: const TextStyle(
                        color: AppColors.grey4,
                        fontWeight: FontWeight.w400,
                        fontSize: 14,
                      ),
                      decoration: InputDecoration(
                        errorText: errorText,
                        suffixIcon: (suffixIcon != null || isDropDown)
                            ? Icon(
                                suffixIcon ?? Icons.keyboard_arrow_down_rounded,
                                size: 20,
                                color: AppColors.grey2,
                              )
                            : suffixIconButton,
                        suffixIconConstraints:
                            BoxConstraints.tight(const Size(40, 40)),
                        prefixIcon: prefixIcon != null
                            ? Icon(
                                prefixIcon,
                                size: 20,
                                color: AppColors.grey2,
                              )
                            : null,
                        prefixIconConstraints:
                            BoxConstraints.tight(const Size(40, 40)),
                        contentPadding: contentPadding,
                        fillColor: fillColor,
                        filled: filled,
                        hintText: hintText,
                        hintStyle: const TextStyle(
                          color: AppColors.grey2,
                          fontWeight: FontWeight.w400,
                          fontSize: 14,
                        ),
                        isDense: true,
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: const BorderSide(
                              width: 1, color: AppColors.grey1),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: const BorderSide(
                              width: 1.5, color: AppColors.grey1),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide:
                              BorderSide(width: 1, color: Colors.red.shade700),
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide(
                              width: 1.3, color: Colors.red.shade700),
                        ),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: onIconTap,
                    child: const Icon(
                      Icons.refresh,
                      color: AppColors.grey2,
                    ),
                  )
                ],
              )
            : TextFormField(
                onFieldSubmitted: onFieldSubmitted,
                inputFormatters: inputFormatters,
                controller: controller,
                keyboardType: keyboardType,
                onTapOutside: (event) {
                  CommonFunction.closeKeyboard();
                },
                minLines: minLines,
                maxLines: maxLines,
                onChanged: onChanged,
                showCursor: readOnly ? false : showCursor,
                readOnly: isDropDown ? true : readOnly,
                autovalidateMode: autoValidateMode,
                obscureText: obscureText,
                validator: validator,
                onTap: onTap,
                style: const TextStyle(
                  color: AppColors.grey4,
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                ),
                decoration: InputDecoration(
                  errorText: errorText,
                  suffixIcon: (suffixIcon != null || isDropDown)
                      ? Icon(
                          suffixIcon ?? Icons.keyboard_arrow_down_rounded,
                          size: 20,
                          color: AppColors.grey2,
                        )
                      : suffixIconButton,
                  suffixIconConstraints:
                      BoxConstraints.tight(const Size(40, 40)),
                  prefixIcon: prefixIcon != null
                      ? Icon(
                          prefixIcon,
                          size: 20,
                          color: AppColors.grey2,
                        )
                      : null,
                  prefixIconConstraints:
                      BoxConstraints.tight(const Size(40, 40)),
                  contentPadding: contentPadding,
                  fillColor: fillColor,
                  filled: filled,
                  hintText: hintText,
                  hintStyle: const TextStyle(
                    color: AppColors.grey2,
                    fontWeight: FontWeight.w400,
                    fontSize: 14,
                  ),
                  isDense: true,
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide:
                        const BorderSide(width: 1, color: AppColors.grey1),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide:
                        const BorderSide(width: 1.5, color: AppColors.grey1),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide:
                        BorderSide(width: 1, color: Colors.red.shade700),
                  ),
                  focusedErrorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide:
                        BorderSide(width: 1.3, color: Colors.red.shade700),
                  ),
                ),
              ),
      ],
    );
  }
}
