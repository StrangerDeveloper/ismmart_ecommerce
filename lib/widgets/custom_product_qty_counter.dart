import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:ismmart_ecommerce/helpers/app_colors.dart';
import 'package:ismmart_ecommerce/helpers/theme_helper.dart';

class CustomProductQuantityCounter extends StatelessWidget {
  const CustomProductQuantityCounter(
      {super.key,
      this.onDecrementPress,
      this.onIncrementPress,
      this.textEditingController,
      this.bgColor,
      this.textColor,
      this.height = 40,
      this.width,
      this.quantity = "1",
      this.margin,
      this.padding});

  final VoidCallback? onDecrementPress;
  final VoidCallback? onIncrementPress;
  final TextEditingController? textEditingController;
  final Color? bgColor, textColor;
  final double? height, width;
  final EdgeInsetsGeometry? margin, padding;
  final String? quantity;

  @override
  Widget build(BuildContext context) {
    return Container(
      // margin: margin ?? const EdgeInsets.symmetric(vertical: 8),
      // padding:
      //     padding ?? const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
          color: bgColor ?? AppColors.transparent,
          borderRadius: BorderRadius.circular(30),
          border: Border.all(color: AppColors.grey8)),
      width: width,
      height: height,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          IconButton(
            iconSize: 20,
            alignment: Alignment.center,
            onPressed: onDecrementPress,
            icon: Icon(
              Icons.remove,
              color: textColor ?? AppColors.black,
            ),
          ),
         // const Gap(4),
          SizedBox(
            width: 20,
            height: 20,
            child: TextField(
              controller: textEditingController,
              enabled: false,
              style: ThemeHelper.textTheme.bodySmall!
                  .copyWith(color: textColor ?? AppColors.black),
              textAlignVertical: TextAlignVertical.center,
              decoration: InputDecoration(
                  contentPadding: const EdgeInsets.symmetric(vertical: 10),
                  border: InputBorder.none,
                  hintText: "$quantity",
                  hintStyle: ThemeHelper.textTheme.bodySmall!
                      .copyWith(color: textColor ?? AppColors.black)),
              textAlign: TextAlign.center,
              keyboardType: TextInputType.number,
            ),
          ),
          //const Gap(4),
          IconButton(
            iconSize: 20,
            alignment: Alignment.center,
            onPressed: onIncrementPress,
            icon: Icon(Icons.add, color: textColor ?? AppColors.black),
          ),
        ],
      ),
    );
  }
}

