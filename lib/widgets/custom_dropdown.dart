import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ismmart_ecommerce/helpers/app_colors.dart';
import 'package:ismmart_ecommerce/widgets/widget_models/dropdown_model.dart';

class CustomDropDownList1 extends StatelessWidget {
  final String? title;
  final bool asterisk;
  final RxString value;
  final String? hintText;
  final ValueChanged? onChanged;
  final List<DropDownModel> dropdownList;
  final FormFieldValidator<String>? validator;
  final AutovalidateMode? autoValidateMode;
  final String? labelText;
  final EdgeInsetsGeometry? contentPadding;

  const CustomDropDownList1({
    super.key,
    this.title,
    required this.value,
    this.hintText,
    required this.onChanged,
    required this.dropdownList,
    this.asterisk = false,
    this.validator,
    this.autoValidateMode,
    this.labelText,
    this.contentPadding = const EdgeInsets.fromLTRB(10, 13.5, 10, 13.5),
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        (title == null)
            ? Container()
            : Padding(
                padding: const EdgeInsets.only(bottom: 6, left: 1),
                child: RichText(
                  text: TextSpan(
                    text: title,
                    style: GoogleFonts.dmSans(
                        color: Colors.black,
                        fontSize: 14,
                        fontWeight: FontWeight.w500),
                    children: [
                      (asterisk)
                          ? const TextSpan(
                              text: ' *',
                              style: TextStyle(color: Colors.red, fontSize: 13),
                            )
                          : const TextSpan(text: '')
                    ],
                  ),
                ),
              ),
        Obx(
          () => DropdownButtonFormField(
            dropdownColor: Colors.white,
            decoration: InputDecoration(
              filled: true,
              fillColor: AppColors.kContainerFillColor,
              hintText: hintText,
              hintStyle: GoogleFonts.dmSans(
                  color: AppColors.hintTextGrey, fontWeight: FontWeight.w400),
              contentPadding: contentPadding,
              enabledBorder: OutlineInputBorder(
                borderSide:
                    const BorderSide(color: AppColors.kTextFieldBorderColor, width: 0.8),
                borderRadius: BorderRadius.circular(9),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide:
                    const BorderSide(color: AppColors.kTextFieldBorderColor, width: 0.8),
                borderRadius: BorderRadius.circular(8),
              ),
              errorBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.red.shade700, width: 0.8),
                borderRadius: BorderRadius.circular(8),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.red.shade700),
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            autovalidateMode: autoValidateMode,
            validator: validator,
            icon: const Icon(Icons.keyboard_arrow_down),
            iconSize: 25,
            value: value.value,
            isExpanded: true,
            onChanged: onChanged,
            items: dropdownList.map(
              (DropDownModel dropDownItem) {
                return DropdownMenuItem<String>(
                  value: dropDownItem.id,
                  child: Text(
                    dropDownItem.name ?? 'N/A',
                    style: GoogleFonts.dmSans(
                      color: dropDownItem.id != value.value
                          ? AppColors.grey700
                          : Colors.black,
                      fontWeight: dropDownItem.id != value.value
                          ? FontWeight.w400
                          : FontWeight.w600,
                    ),
                  ),
                );
              },
            ).toList(),
          ),
        ),
      ],
    );
  }
}