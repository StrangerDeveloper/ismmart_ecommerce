import 'package:flutter/material.dart';
import 'package:ismmart_ecommerce/helpers/app_colors.dart';



class CustomRadioButton1 extends StatelessWidget {
  final String title;
  final String groupValue;
  final String value;
  final void Function(String) onChanged;
  final Widget? child;

  const CustomRadioButton1({
    super.key,
    required this.groupValue,
    required this.value,
    required this.onChanged,
    this.title = '',
    this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Material(
          child: InkWell(
            customBorder: const CircleBorder(),
            onTap: () {
              onChanged(value);
            },
            child: Container(
              height: 16,
              width: 16,
              margin: const EdgeInsets.all(9),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: value == groupValue
                    ? Border.all(
                        width: 3.5,
                        color: AppColors.red,
                      )
                    : Border.all(
                        color: const Color(0xFFD1D5DB),
                      ),
              ),
            ),
          ),
        ),
        child ??
            Text(
              title,
              style: const TextStyle(
                fontWeight: FontWeight.w500,
              ),
            )
      ],
    );
  }
}


