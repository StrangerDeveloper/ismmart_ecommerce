import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../helpers/app_colors.dart';

class ImageLayoutContainer extends StatelessWidget {
  final void Function() onTap;
  final String title;
  final String filePath;
  final bool required;
  final String errorPrompt;
  final bool errorVisibility;
  final bool description;

  const ImageLayoutContainer({
    super.key,
    required this.onTap,
    required this.title,
    required this.filePath,
    this.required = false,
    this.errorPrompt = '',
    this.errorVisibility = false,
    this.description = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              RichText(
                text: TextSpan(
                  text: title,
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
              const Text(
                'Image should be less than 2 MB',
                style: TextStyle(
                  color: AppColors.fadedBlue,
                  fontSize: 10,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8.5),
          Row(
            children: [
              Expanded(
                flex: 2,
                child: InkWell(
                  onTap: onTap,
                  child: Container(
                    alignment: Alignment.center,
                    padding: const EdgeInsets.symmetric(vertical: 11),
                    decoration: BoxDecoration(
                      color: AppColors.grey2.withOpacity(0.8),
                      borderRadius: const BorderRadius.horizontal(
                        left: Radius.circular(8),
                      ),
                    ),
                    child: const Text(
                      'Choose file',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 4,
                child: Container(
                  padding: const EdgeInsets.only(left: 15, top: 10, bottom: 10),
                  decoration: BoxDecoration(
                    color: AppColors.grey3,
                    border: Border.all(
                      color: AppColors.grey1,
                    ),
                    borderRadius: const BorderRadius.horizontal(
                      right: Radius.circular(8),
                    ),
                  ),
                  child: Text(filePath == '' ? 'No file chosen' : filePath),
                ),
              ),
            ],
          ),
          if (description)
            Text(
              "This cheque image should have the same bank details visible as you mentioned above",
              style: GoogleFonts.dmSans(
                fontSize: 12,
                color: AppColors.lightGrey,
              ),
            ),
          Visibility(
            visible: errorVisibility,
            child: Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.only(top: 8, left: 8),
                child: Text(
                  errorPrompt,
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.red.shade700,
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
