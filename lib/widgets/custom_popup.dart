import 'package:flutter/material.dart';
import 'package:ismmart_ecommerce/widgets/custom_text.dart';

class CustomPopup extends StatelessWidget {
  final String? title;
  final String? text;
  final IconData? icon;
  final TextStyle? style;
  final TextAlign? textAlign;
  final List<Widget>? buttons;

  const CustomPopup({
    super.key,
    this.title,
    this.text,
    this.icon,
    this.buttons,
    this.style,
    this.textAlign,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.transparent,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      contentPadding: EdgeInsets.zero,
      content: Stack(
        alignment: Alignment.topCenter,
        children: [
          Container(
            margin: const EdgeInsets.only(top: 30),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: Colors.white,
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 40.0, bottom: 8.0),
                    child: CustomText(
                      title: title.toString(),
                      style: style ??
                          Theme.of(context).textTheme.titleMedium!.copyWith(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                      textAlign: textAlign ?? TextAlign.center,
                    ),
                  ),
                  CustomText(
                    title: text.toString(),
                    style: style ??
                        Theme.of(context).textTheme.bodyMedium!.copyWith(
                              color: Colors.black,
                              fontWeight: FontWeight.w500,
                            ),
                    textAlign: textAlign ?? TextAlign.center,
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: buttons ?? [],
                  ),
                ],
              ),
            ),
          ),
          Container(
            width: 65,
            height: 65,
            decoration: const BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 10,
                  spreadRadius: 5,
                ),
              ],
            ),
            padding: const EdgeInsets.all(0.0),
            alignment: Alignment.center,
            child: Icon(
              icon,
              size: 32,
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}
