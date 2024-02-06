import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomCircularLoader extends StatelessWidget {
  const CustomCircularLoader({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircularProgressIndicator.adaptive(
        strokeWidth: 1.4,
        valueColor: AlwaysStoppedAnimation<Color>(
          Get.theme.primaryColor,
        ),
      ),
    );
  }
}
