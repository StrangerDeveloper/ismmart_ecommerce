import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomCheckBox extends StatelessWidget {
  final String title;
  final Widget? child;
  final RxBool value;
  final ValueChanged onChanged;

  const CustomCheckBox({
    super.key,
    this.title = '',
    required this.value,
    required this.onChanged,
    this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Transform.scale(
          scale: 0.8,
          child: Obx(
            () => Checkbox(
              value: value.value,
              onChanged: onChanged,
              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              visualDensity: VisualDensity.compact,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(4),
              ),
              side: const BorderSide(width: 1, color: Color(0xFFD1D5DB)),
            ),
          ),
        ),
        child ??
            Text(
              title,
              style: const TextStyle(
                color: Color(0xFF222222),
                fontSize: 12,
              ),
            ),
      ],
    );
  }
}

// class CustomCheckBox2 extends StatelessWidget {
//   final Widget text;
//   final bool? value;
//   final ValueChanged? onChanged;
//
//   // final Color? activeColor;
//   // final Color? checkColor;
//
//   const CustomCheckBox2({
//     super.key,
//     required this.text,
//     required this.value,
//     required this.onChanged,
//     // this.activeColor = Colors.yellow,
//     // this.checkColor = Colors.white,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Transform.scale(
//           scale: 0.87,
//           child: Checkbox(
//             value: value,
//             onChanged: onChanged,
//             materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
//             visualDensity: VisualDensity.compact,
//             fillColor: MaterialStateProperty.all(newColorLightGrey2),
//             shape: RoundedRectangleBorder(
//               side: const BorderSide(width: 2, color: newColorLightGrey2),
//               borderRadius: BorderRadius.circular(4.5),
//             ),
//           ),
//         ),
//         Expanded(child: text),
//       ],
//     );
//   }
// }
