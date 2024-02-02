import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../helpers/app_colors.dart';

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
                        // CommonFunction.closeKeyboard();
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
                  // CommonFunction.closeKeyboard();
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

//FINAL VERSION...
class CustomTextField5 extends StatelessWidget {
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
  final String? initialValue;
  final bool isDropDown;
  final IconData? suffixIcon;
  final Widget? suffixIconButton;
  final IconData? prefixIcon;
  final EdgeInsetsGeometry contentPadding;
  final TextStyle? textStyle;
  final List<TextInputFormatter>? inputFormatters;

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
  const CustomTextField5({
    super.key,
    this.contentPadding = const EdgeInsets.symmetric(
      horizontal: 10,
      vertical: 10,
    ),
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
    this.initialValue,
    this.inputFormatters,
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
                      color: AppColors.grey2,
                      fontWeight: FontWeight.w500,
                      fontSize: 12,
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
        TextFormField(
          inputFormatters: inputFormatters,
          controller: controller,
          initialValue: initialValue,
          keyboardType: keyboardType,
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
            suffixIconConstraints: BoxConstraints.tight(const Size(40, 30)),
            prefixIcon: prefixIcon != null
                ? Icon(
                    prefixIcon,
                    size: 20,
                    color: AppColors.grey2,
                  )
                : null,
            prefixIconConstraints: BoxConstraints.tight(const Size(40, 40)),
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
              borderSide: const BorderSide(width: 1, color: AppColors.grey1),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(width: 1.5, color: AppColors.grey1),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(width: 1, color: Colors.red.shade700),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(width: 1.3, color: Colors.red.shade700),
            ),
          ),
        ),
      ],
    );
  }
}

// class CustomTextField2 extends StatelessWidget {
//   final String? title;
//   final String? hintText;
//   final IconData? prefixIcon;
//   final Widget? suffixIcon;
//   final String? label;
//   final EdgeInsetsGeometry? contentPadding;
//   final bool obscureText;
//   final TextStyle? titleTextStyle;
//   final TextEditingController? controller;
//   final Color? fillColor;
//   final Color? titleColor;
//   final FocusNode? focusNode;
//   final bool readOnly;
//   final bool enabled;
//   final bool? showCursor;
//   final String? initialValue;
//   final AutovalidateMode? autoValidateMode;
//   final FormFieldValidator<String>? validator;
//   final List<TextInputFormatter>? inputFormatters;
//   final TextInputType? keyboardType;
//   final void Function(String)? onChanged;
//   final void Function()? onTap;
//
//   const CustomTextField2({
//     super.key,
//     this.showCursor,
//     this.readOnly = false,
//     this.fillColor,
//     this.onChanged,
//     this.focusNode,
//     this.titleColor,
//     this.onTap,
//     this.initialValue,
//     this.enabled = true,
//     this.contentPadding = const EdgeInsets.all(8),
//     this.controller,
//     this.suffixIcon,
//     this.obscureText = false,
//     this.hintText,
//     this.prefixIcon,
//     this.label,
//     this.title,
//     this.autoValidateMode,
//     this.validator,
//     this.inputFormatters,
//     this.keyboardType,
//     this.titleTextStyle
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         if (title != null)
//           Padding(
//             padding: const EdgeInsets.only(bottom: 5),
//             child: Text(title!, style: titleTextStyle ?? newFontStyle1),
//           ),
//         TextFormField(
//           initialValue: initialValue,
//           onTap: onTap,
//           focusNode: focusNode,
//           enabled: enabled,
//           keyboardType: keyboardType,
//           inputFormatters: inputFormatters,
//           validator: validator,
//           autovalidateMode: autoValidateMode,
//           showCursor: showCursor,
//           readOnly: readOnly,
//           controller: controller,
//           obscureText: obscureText,
//           onChanged: onChanged,
//           style: GoogleFonts.inter(
//             color: Colors.black,
//             fontSize: 15,
//           ),
//           decoration: InputDecoration(
//             labelText: label,
//             labelStyle: GoogleFonts.lato(
//               fontSize: 14,
//               color: Colors.black54,
//             ),
//             floatingLabelStyle: GoogleFonts.lato(
//               color: Colors.black,
//               fontSize: 17,
//               fontWeight: FontWeight.w600,
//             ),
//             // hintStyle: TextStyle(fontWeight: FontWeight.w400, fontSize: 14, color: Colors.green),
//             // prefixIcon: prefixIcon,
//             prefixIcon: prefixIcon != null
//                 ? Icon(
//                     prefixIcon,
//                     color: kPrimaryColor,
//                     size: 22,
//                   )
//                 : null,
//             contentPadding: contentPadding,
//             suffixIcon: suffixIcon,
//
//             // suffixIconConstraints: BoxConstraints.expand(width: 40),
//             filled: true,
//             fillColor: kContainerFillColor,
//             hintText: hintText,
//             hintStyle: GoogleFonts.inter(color: newColorLightGrey2),
//
//             errorStyle: GoogleFonts.inter(
//               color: Colors.red,
//             ),
//             disabledBorder: OutlineInputBorder(
//               borderSide:
//                   const BorderSide(color: kTextfieldBorderColor, width: 0.8),
//               borderRadius: BorderRadius.circular(9),
//             ),
//             enabledBorder: OutlineInputBorder(
//               borderSide:
//                   const BorderSide(color: kTextfieldBorderColor, width: 1.2),
//               borderRadius: BorderRadius.circular(9),
//             ),
//             focusedBorder: OutlineInputBorder(
//               borderSide:
//                   const BorderSide(color: kTextfieldBorderColor, width: 1.2),
//               borderRadius: BorderRadius.circular(8),
//             ),
//             errorBorder: OutlineInputBorder(
//               borderSide: BorderSide(color: Colors.red.shade700, width: 1.2),
//               borderRadius: BorderRadius.circular(8),
//             ),
//             focusedErrorBorder: OutlineInputBorder(
//               borderSide: BorderSide(color: Colors.red.shade700),
//               borderRadius: BorderRadius.circular(8),
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }
//
// class CustomTextField3 extends StatelessWidget {
//   final String? title;
//   final String? hintText;
//   final Widget? suffixIcon;
//   final Widget? prefixIcon;
//   final String? addedTitleText;
//   final EdgeInsetsGeometry? contentPadding;
//   final bool obscureText;
//   final TextEditingController? controller;
//   final bool readOnly;
//   final Color? fillColor;
//   final TextStyle? titleTextStyle;
//   final TextStyle? addedTitleTextStyle;
//   final bool? showCursor;
//   final AutovalidateMode? autoValidateMode;
//   final FormFieldValidator<String>? validator;
//   final List<TextInputFormatter>? inputFormatters;
//   final TextInputType? keyboardType;
//   final void Function(String)? onChanged;
//   final bool required;
//   final bool enabled;
//   final Icon? textFieldIcon;
//
//   const CustomTextField3({
//     super.key,
//     this.textFieldIcon,
//     this.showCursor,
//     this.readOnly = false,
//     this.onChanged,
//     this.contentPadding = EdgeInsets.zero,
//     this.controller,
//     this.suffixIcon,
//     this.prefixIcon,
//     this.obscureText = false,
//     this.hintText,
//     this.title,
//     this.fillColor,
//     this.autoValidateMode,
//     this.validator,
//     this.enabled = true,
//     this.inputFormatters,
//     this.keyboardType,
//     this.required = true,
//     this.titleTextStyle,
//     this.addedTitleTextStyle,
//     this.addedTitleText,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.only(bottom: 8.0),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           if (title != null)
//             Padding(
//               padding: const EdgeInsets.only(bottom: 5),
//               child: RichText(
//                 text: TextSpan(
//                   text: title!,
//                   style: titleTextStyle ?? newFontStyleSize14.copyWith(
//                       fontWeight: FontWeight.w500, color: newColorDarkBlack),
//                   children: [
//                     if (required)
//                       TextSpan(
//                         text: addedTitleText ?? ' *',
//                         style: addedTitleTextStyle ?? const TextStyle(color: Colors.red),
//                       )
//                   ],
//                 ),
//               ),
//             ),
//           const SizedBox(
//             height: 5,
//           ),
//           Container(
//             alignment: Alignment.center,
//             height: 50,
//             padding: const EdgeInsets.only(left: 16),
//             decoration: ShapeDecoration(
//               color: const Color(0xFFF9FAFB),
//               shape: RoundedRectangleBorder(
//                 side: const BorderSide(width: 1, color: Color(0xFFEEEEEE)),
//                 borderRadius: BorderRadius.circular(8),
//               ),
//             ),
//             child: Row(
//               children: [
//                 textFieldIcon != null ? textFieldIcon! : const SizedBox(),
//                 const SizedBox(
//                   width: 5,
//                 ),
//                 Expanded(
//                   child: TextFormField(
//                     keyboardType: keyboardType,
//                     inputFormatters: inputFormatters,
//                     validator: validator,
//                     autovalidateMode: autoValidateMode,
//                     showCursor: showCursor,
//                     enabled: enabled,
//                     readOnly: readOnly,
//                     controller: controller,
//                     obscureText: obscureText,
//                     onChanged: onChanged,
//                     // style: newFontStyle0.copyWith(
//                     //   color: newColorDarkBlack2,
//                     // ),
//                     obscuringCharacter: '●',
//                     decoration: InputDecoration(
//                       border: InputBorder.none,
//                       hintText: hintText,
//                       hintStyle: newFontStyleSize14.copyWith(
//                         color: newColorLightGrey2,
//                       ),
//                       contentPadding: const EdgeInsets.only(top: 2, bottom: 2),
//                       suffixIcon: suffixIcon,
//                       prefix: prefixIcon,
//                       suffixIconConstraints:
//                           BoxConstraints.tight(const Size(40, 25)),
//                       errorStyle: GoogleFonts.inter(
//                         fontSize: 13,
//                         color: Colors.red.shade700,
//                       ),
//                     //   disabledBorder: OutlineInputBorder(
//                     //     borderSide:
//                     //     const BorderSide(color: kTextfieldBorderColor, width: 0.8),
//                     //     borderRadius: BorderRadius.circular(9),
//                     //   ),
//                     //   enabledBorder: OutlineInputBorder(
//                     //     borderSide:
//                     //     const BorderSide(color: kTextfieldBorderColor, width: 1.2),
//                     //     borderRadius: BorderRadius.circular(9),
//                     //   ),
//                     //   focusedBorder: OutlineInputBorder(
//                     //     borderSide:
//                     //     const BorderSide(color: kTextfieldBorderColor, width: 1.2),
//                     //     borderRadius: BorderRadius.circular(8),
//                     //   ),
//                     //   errorBorder: OutlineInputBorder(
//                     //     borderSide: BorderSide(color: Colors.red.shade700, width: 1.2),
//                     //     borderRadius: BorderRadius.circular(8),
//                     //   ),
//                     //   focusedErrorBorder: OutlineInputBorder(
//                     //     borderSide: BorderSide(color: Colors.red.shade700),
//                     //     borderRadius: BorderRadius.circular(8),
//                     //   ),
//                     // ),
//                   ),
//                 ),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
//
// class CountryCodePickerTextField extends StatelessWidget {
//   final String? title;
//   final TextEditingController? controller;
//   final TextInputType? keyboardType;
//   final String? initialValue;
//   final FormFieldValidator<String>? validator;
//   final AutovalidateMode? autoValidateMode;
//   final ValueChanged<CountryCode>? onChanged;
//   final ValueChanged<String>? onPhoneFieldChange;
//   final bool? showCursor;
//   final bool readOnly;
//   final bool enabled;
//   final String? labelText, errorText;
//   final TextStyle? textStyle;
//   final List<TextInputFormatter>? inputFormatters;
//   final bool required;
//   final String? hintText;
//
//   const CountryCodePickerTextField({
//     super.key,
//     this.validator,
//     this.autoValidateMode,
//     this.controller,
//     this.initialValue,
//     this.keyboardType,
//     this.onChanged,
//     this.showCursor,
//     this.readOnly = false,
//     this.enabled = true,
//     this.inputFormatters,
//     this.errorText,
//     this.onPhoneFieldChange,
//     this.labelText,
//     this.textStyle,
//     this.title,
//     this.required = false,
//     this.hintText,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         if (title != null)
//           Padding(
//             padding: const EdgeInsets.only(bottom: 3),
//             child: RichText(
//               text: TextSpan(
//                 text: title!,
//                 style: const TextStyle(
//                   color: Colors.black,
//                   fontWeight: FontWeight.w500,
//                 ),
//                 children: [
//                   if (required)
//                     const TextSpan(
//                       text: ' *',
//                       style: TextStyle(color: Colors.red),
//                     )
//                 ],
//               ),
//             ),
//           ),
//         TextFormField(
//           controller: controller,
//           keyboardType: keyboardType,
//           inputFormatters: inputFormatters,
//           showCursor: showCursor,
//           readOnly: readOnly,
//           autovalidateMode: autoValidateMode,
//           validator: validator,
//           onChanged: onPhoneFieldChange,
//           decoration: InputDecoration(
//             errorText: errorText,
//             fillColor: Colors.white,
//             labelText: labelText,
//             labelStyle: textStyle,
//             hintText: hintText,
//             prefixIcon: Container(
//               margin: const EdgeInsets.fromLTRB(1, 1, 10, 1),
//               decoration: const BoxDecoration(
//                 border: Border(right: BorderSide(width: 1)),
//               ),
//               child: Container(
//                 decoration: BoxDecoration(
//                   color: Colors.grey[200],
//                   borderRadius: const BorderRadius.only(
//                     topLeft: Radius.circular(6),
//                     bottomLeft: Radius.circular(6),
//                   ),
//                 ),
//                 child: CountryCodePicker(
//                   flagDecoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(2),
//                   ),
//                   searchDecoration: InputDecoration(
//                     isDense: true,
//                     prefixIconColor: Colors.black,
//                     contentPadding: EdgeInsets.zero,
//                     labelText: labelText,
//                     labelStyle: textStyle,
//                     enabledBorder: OutlineInputBorder(
//                       borderSide: const BorderSide(
//                         color: Colors.black,
//                         width: 1,
//                         style: BorderStyle.solid,
//                       ), //B
//                       borderRadius: BorderRadius.circular(8),
//                     ),
//                     focusedBorder: OutlineInputBorder(
//                       borderSide: const BorderSide(
//                         color: Colors.black,
//                         width: 1,
//                         style: BorderStyle.solid,
//                       ), //B
//                       borderRadius: BorderRadius.circular(8),
//                     ),
//                   ),
//                   textStyle: const TextStyle(color: Colors.black),
//                   enabled: enabled,
//                   onChanged: onChanged,
//                   // Initial selection and favorite can be one of code ('IT') OR dial_code('+39')
//                   initialSelection: initialValue,
//                   favorite: const ['+92'],
//                 ),
//               ),
//             ),
//             contentPadding: const EdgeInsets.fromLTRB(0, 12, 6.5, 12),
//             enabledBorder: OutlineInputBorder(
//               borderSide: const BorderSide(
//                 color: Colors.black,
//                 width: 1,
//                 style: BorderStyle.solid,
//               ), //B
//               borderRadius: BorderRadius.circular(8),
//             ),
//             focusedBorder: OutlineInputBorder(
//               borderSide: const BorderSide(
//                 color: Colors.black,
//                 width: 1,
//                 style: BorderStyle.solid,
//               ), //B
//               borderRadius: BorderRadius.circular(8),
//             ),
//             errorBorder: OutlineInputBorder(
//               borderSide: BorderSide(color: Colors.red.shade700, width: 1),
//               borderRadius: BorderRadius.circular(8),
//             ),
//             focusedErrorBorder: OutlineInputBorder(
//               borderSide: BorderSide(color: Colors.red.shade700, width: 1.5),
//               borderRadius: BorderRadius.circular(8),
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }

class CountryCodePickerTextField2 extends StatelessWidget {
  final String? title;
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final String? initialValue;
  final FormFieldValidator<String>? validator;
  final AutovalidateMode? autoValidateMode;
  final ValueChanged<CountryCode>? onChanged;
  final ValueChanged<String>? onPhoneFieldChange;
  final bool? showCursor;
  final bool readOnly;
  final bool enabled;
  final bool required;
  final String? errorText;
  final TextStyle? textStyle;
  final List<TextInputFormatter>? inputFormatters;
  final String? hintText;

  const CountryCodePickerTextField2({
    super.key,
    this.validator,
    this.autoValidateMode,
    this.controller,
    this.initialValue,
    this.keyboardType,
    this.onChanged,
    this.showCursor,
    this.readOnly = false,
    this.enabled = true,
    this.inputFormatters,
    this.errorText,
    this.onPhoneFieldChange,
    this.textStyle,
    this.title,
    this.hintText,
    this.required = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (title != null)
          Padding(
            padding: const EdgeInsets.only(bottom: 3),
            child: RichText(
              text: TextSpan(
                text: title!,
                style: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w500,
                ),
                children: [
                  if (required)
                    const TextSpan(
                      text: ' *',
                      style: TextStyle(color: Colors.red),
                    )
                ],
              ),
            ),
          ),
        TextFormField(
          inputFormatters: inputFormatters,
          showCursor: showCursor,
          readOnly: readOnly,
          autovalidateMode: autoValidateMode,
          validator: validator,
          onChanged: onPhoneFieldChange,
          decoration: InputDecoration(
            hintText: hintText,
            // hintStyle: newFontStyleSize14.copyWith(
            //   color: AppColors.fadedBlue,
            // ),
            errorText: errorText,
            prefixIconConstraints: BoxConstraints.tight(const Size(120, 50)),
            prefixIcon: Row(
              children: [
                CountryCodePicker(
                  padding: EdgeInsets.zero,
                  flagDecoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(1),
                  ),
                  searchDecoration: InputDecoration(
                    contentPadding: EdgeInsets.zero,
                    enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                        color: Colors.black,
                        width: 1,
                        style: BorderStyle.solid,
                      ), //B
                      borderRadius: BorderRadius.circular(8),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                        color: Colors.black,
                        width: 1,
                        style: BorderStyle.solid,
                      ), //B
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  // textStyle: newFontStyleSize14.copyWith(
                  //   color: Colors.black,
                  // ),
                  enabled: enabled,
                  onChanged: onChanged,
                  // Initial selection and favorite can be one of code ('IT') OR dial_code('+39')
                  initialSelection: initialValue,
                ),
                const Icon(
                  Icons.arrow_drop_down_sharp,
                  size: 16,
                  color: AppColors.lightGrey,
                ),
              ],
            ),
            contentPadding: const EdgeInsets.only(top: 12),
            enabledBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: Color(0xffEEEEEE)),
            ),
            focusedBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: Color(0xff929AAB)),
            ),
            errorBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.red.shade700, width: 0.3),
            ),
            focusedErrorBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.red.shade700, width: 0.6),
            ),
            errorStyle: GoogleFonts.dmSans(
              fontSize: 13,
              color: Colors.red.shade700,
            ),
          ),
          controller: controller,
          keyboardType: keyboardType,
        ),
      ],
    );
  }
}

// //
// // class FormInputFieldWithIcon extends StatelessWidget {
// //   const FormInputFieldWithIcon({
// //     Key? key,
// //     required this.controller,
// //     this.iconPrefix,
// //     this.labelText,
// //     this.hintText,
// //     this.suffix,
// //     this.iconColor,
// //     this.textStyle,
// //     this.validator,
// //     this.keyboardType = TextInputType.text,
// //     this.minLines = 1,
// //     this.maxLines = 1,
// //     this.isExpanded = false,
// //     this.maxLength,
// //     this.autofocus,
// //     this.enableBorder,
// //     this.textCapitalization = TextCapitalization.none,
// //     this.maxLengthEnforcement,
// //     required this.onChanged,
// //     required this.onSaved,
// //     this.autoValidateMode,
// //     this.inputFormatters,
// //   }) : super(key: key);
// //   final AutovalidateMode? autoValidateMode;
// //   final TextEditingController controller;
// //   final IconData? iconPrefix;
// //   final String? labelText, hintText;
// //   final bool? autofocus;
// //   final Widget? suffix;
// //   final String? Function(String?)? validator;
// //   final TextInputType keyboardType;
// //   final int minLines;
// //   final int? maxLines;
// //   final bool? isExpanded;
// //   final Color? iconColor;
// //   final TextStyle? textStyle;
// //   final int? maxLength;
// //   final MaxLengthEnforcement? maxLengthEnforcement;
// //   final InputBorder? enableBorder;
// //   final TextCapitalization? textCapitalization;
// //   final void Function(String) onChanged;
// //   final void Function(String?)? onSaved;
// //   final List<TextInputFormatter>? inputFormatters;
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return TextFormField(
// //       autofocus: autofocus!,
// //       textCapitalization: textCapitalization!,
// //       textAlignVertical: TextAlignVertical.top,
// //       autovalidateMode: autoValidateMode,
// //       inputFormatters: inputFormatters,
// //       scrollPhysics: const AlwaysScrollableScrollPhysics(),
// //       //textAlign: TextAlign.center,
// //       decoration: InputDecoration(
// //         filled: false,
// //         suffix: suffix,
// //         prefixIcon: iconPrefix == null
// //             ? null
// //             : Icon(
// //                 iconPrefix,
// //                 color: kPrimaryColor,
// //               ),
// //         labelText: labelText,
// //         labelStyle: textStyle,
// //         hintText: hintText,
// //         errorMaxLines: 2,
// //         focusedBorder: enableBorder ??
// //             OutlineInputBorder(
// //               borderSide: BorderSide(
// //                   color: Colors.black, width: 1, style: BorderStyle.solid), //B
// //               borderRadius: BorderRadius.circular(8),
// //             ),
// //         border: enableBorder ??
// //             OutlineInputBorder(
// //               borderSide: BorderSide(
// //                   color: Colors.black, width: 1, style: BorderStyle.solid), //B
// //               borderRadius: BorderRadius.circular(8),
// //             ),
// //       ),
// //       controller: controller,
// //       cursorColor: iconColor,
// //       style: textStyle,
// //       onSaved: onSaved,
// //       onChanged: onChanged,
// //       keyboardType: keyboardType,
// //       expands: isExpanded!,
// //       maxLines: isExpanded! ? null : maxLines,
// //       minLines: isExpanded! ? null : minLines,
// //       maxLengthEnforcement: maxLengthEnforcement,
// //       maxLength: maxLength,
// //       validator: validator,
// //     );
// //   }
// // }
// //
// // class FormPasswordInputFieldWithIcon extends StatefulWidget {
// //   const FormPasswordInputFieldWithIcon(
// //       {Key? key,
// //       required this.controller,
// //       this.iconPrefix,
// //       required this.labelText,
// //       required this.validator,
// //       this.iconColor,
// //       this.textStyle,
// //       this.keyboardType = TextInputType.text,
// //       this.obscureText = false,
// //       this.minLines = 1,
// //       this.maxLines,
// //       this.maxLength,
// //       this.maxLengthEnforcement,
// //       this.onPasswordVisible,
// //       required this.onChanged,
// //       this.onSaved,
// //       this.autoValidateMode})
// //       : super(key: key);
// //   final AutovalidateMode? autoValidateMode;
// //   final TextEditingController controller;
// //   final IconData? iconPrefix;
// //   final String labelText;
// //   final String? Function(String?)? validator;
// //   final TextInputType keyboardType;
// //   final bool? obscureText;
// //   final int minLines;
// //   final int? maxLines;
// //   final Color? iconColor;
// //   final TextStyle? textStyle;
// //   final int? maxLength;
// //   final MaxLengthEnforcement? maxLengthEnforcement;
// //   final void Function(String) onChanged;
// //   final void Function(String?)? onSaved;
// //   final void Function(bool?)? onPasswordVisible;
// //
// //   @override
// //   State<FormPasswordInputFieldWithIcon> createState() =>
// //       _FormPasswordInputFieldWithIconState();
// // }
// //
// // class _FormPasswordInputFieldWithIconState
// //     extends State<FormPasswordInputFieldWithIcon> {
// //   RxBool passVisibility = true.obs;
// //
// //   _toggle() {
// //     passVisibility.value = !passVisibility.value;
// //   }
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return Obx(
// //       () => TextFormField(
// //         autovalidateMode: widget.autoValidateMode,
// //         decoration: InputDecoration(
// //             filled: false,
// //             prefixIcon: widget.iconPrefix == null
// //                 ? null
// //                 : Icon(
// //                     widget.iconPrefix,
// //                     color: kPrimaryColor,
// //                   ),
// //             // enabledBorder: OutlineInputBorder(
// //             //   //borderRadius: BorderRadius.circular(10),
// //             //   borderSide: BorderSide(
// //             //       color: Colors.black, width: 1, style: BorderStyle.solid), //B
// //             //   borderRadius: BorderRadius.circular(8),
// //             // ),
// //             fillColor: widget.iconColor ?? kPrimaryColor,
// //             labelText: widget.labelText,
// //             labelStyle: widget.textStyle,
// //             focusColor: widget.iconColor,
// //             focusedBorder: OutlineInputBorder(
// //               borderSide: BorderSide(
// //                   color: Colors.black, width: 1, style: BorderStyle.solid),
// //               //B
// //               borderRadius: BorderRadius.circular(8),
// //             ),
// //             border: OutlineInputBorder(
// //               borderSide: BorderSide(
// //                   color: Colors.black, width: 1, style: BorderStyle.solid),
// //               //B
// //               borderRadius: BorderRadius.circular(8),
// //             ),
// //             suffixIcon: widget.obscureText!
// //                 ? GestureDetector(
// //                     onTap: _toggle,
// //                     child: Icon(
// //                       passVisibility.isTrue
// //                           ? Icons.visibility_off
// //                           : Icons.visibility,
// //                       color: Colors.black87,
// //                     ),
// //                   )
// //                 : null),
// //         controller: widget.controller,
// //         cursorColor: widget.iconColor,
// //         onSaved: widget.onSaved,
// //         onChanged: widget.onChanged,
// //         keyboardType: widget.keyboardType,
// //         obscureText: passVisibility.value,
// //         style: widget.textStyle,
// //         maxLines: widget.maxLines,
// //         minLines: widget.minLines,
// //         maxLengthEnforcement: widget.maxLengthEnforcement,
// //         maxLength: widget.maxLength,
// //         validator: widget.validator,
// //       ),
// //     );
// //   }
// // }
// class CustomTextField4 extends StatelessWidget {
//   final String? title;
//   final String? hintText;
//   final IconData? prefixIcon;
//   final Widget? suffixIcon;
//   final String? label;
//   final EdgeInsetsGeometry? contentPadding;
//   final bool obscureText;
//   final TextEditingController? controller;
//   final Color? fillColor;
//   final Color? titleColor;
//   final FocusNode? focusNode;
//   final bool readOnly;
//   final bool enabled;
//   final bool? showCursor;
//   final AutovalidateMode? autoValidateMode;
//   final FormFieldValidator<String>? validator;
//   final List<TextInputFormatter>? inputFormatters;
//   final TextInputType? keyboardType;
//   final void Function(String)? onChanged;
//   final void Function()? onTap;
//   final void Function()? iconOnTap;
//
//   const CustomTextField4({
//     super.key,
//     this.showCursor,
//     this.readOnly = false,
//     this.fillColor,
//     this.onChanged,
//     this.iconOnTap,
//     this.focusNode,
//     this.titleColor,
//     this.onTap,
//     this.enabled = true,
//     this.contentPadding = const EdgeInsets.fromLTRB(10, 13.5, 10, 13.5),
//     this.controller,
//     this.suffixIcon,
//     this.obscureText = false,
//     this.hintText,
//     this.prefixIcon,
//     this.label,
//     this.title,
//     this.autoValidateMode,
//     this.validator,
//     this.inputFormatters,
//     this.keyboardType,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         if (title != null)
//           Padding(
//             padding: const EdgeInsets.only(bottom: 5),
//             child: Text(title!, style: newFontStyle1),
//           ),
//         Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: [
//             SizedBox(
//               width: Get.width * 0.75,
//               child: TextFormField(
//                 onTap: onTap,
//                 focusNode: focusNode,
//                 enabled: enabled,
//                 keyboardType: keyboardType,
//                 inputFormatters: inputFormatters,
//                 validator: validator,
//                 autovalidateMode: autoValidateMode,
//                 showCursor: showCursor,
//                 readOnly: readOnly,
//                 controller: controller,
//                 obscureText: obscureText,
//                 onChanged: onChanged,
//                 style: GoogleFonts.inter(
//                   color: Colors.black,
//                   fontSize: 15,
//                 ),
//                 decoration: InputDecoration(
//                   labelText: label,
//                   labelStyle: GoogleFonts.lato(
//                     fontSize: 14,
//                     color: Colors.black54,
//                   ),
//                   floatingLabelStyle: GoogleFonts.lato(
//                     color: Colors.black,
//                     fontSize: 17,
//                     fontWeight: FontWeight.w600,
//                   ),
//                   // hintStyle: TextStyle(fontWeight: FontWeight.w400, fontSize: 14, color: Colors.green),
//                   // prefixIcon: prefixIcon,
//                   prefixIcon: prefixIcon != null
//                       ? Icon(
//                           prefixIcon,
//                           color: kPrimaryColor,
//                           size: 22,
//                         )
//                       : null,
//                   contentPadding: contentPadding,
//                   suffixIcon: suffixIcon,
//
//                   // suffixIconConstraints: BoxConstraints.expand(width: 40),
//                   filled: true,
//                   fillColor: kContainerFillColor,
//                   hintText: hintText,
//                   hintStyle: GoogleFonts.inter(color: newColorLightGrey2),
//
//                   errorStyle: GoogleFonts.inter(
//                     color: Colors.red,
//                   ),
//                   disabledBorder: OutlineInputBorder(
//                     borderSide: const BorderSide(
//                         color: kTextfieldBorderColor, width: 0.8),
//                     borderRadius: BorderRadius.circular(9),
//                   ),
//                   enabledBorder: OutlineInputBorder(
//                     borderSide: const BorderSide(
//                         color: kTextfieldBorderColor, width: 1.2),
//                     borderRadius: BorderRadius.circular(9),
//                   ),
//                   focusedBorder: OutlineInputBorder(
//                     borderSide: const BorderSide(
//                         color: kTextfieldBorderColor, width: 1.2),
//                     borderRadius: BorderRadius.circular(8),
//                   ),
//                   errorBorder: OutlineInputBorder(
//                     borderSide:
//                         BorderSide(color: Colors.red.shade700, width: 1.2),
//                     borderRadius: BorderRadius.circular(8),
//                   ),
//                   focusedErrorBorder: OutlineInputBorder(
//                     borderSide: BorderSide(color: Colors.red.shade700),
//                     borderRadius: BorderRadius.circular(8),
//                   ),
//                 ),
//               ),
//             ),
//             InkWell(
//               onTap: iconOnTap,
//               child: Container(
//                 decoration: BoxDecoration(
//                     color: Colors.white,
//                     border: Border.all(color: newColorLightGrey, width: 0.8),
//                     borderRadius: BorderRadius.circular(10)),
//                 width: 35,
//                 height: 35,
//                 child: const Icon(
//                   Icons.delete_outline_rounded,
//                   size: 22,
//                   color: Colors.grey,
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ],
//     );
//   }
// }
