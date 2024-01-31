import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ismmart_ecommerce/helpers/app_colors.dart';
import 'package:ismmart_ecommerce/helpers/global_variables.dart';

class LoaderView extends StatelessWidget {
  const LoaderView({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => (GlobalVariable.showLoader.value)
          ? Container(
              height: double.infinity,
              width: double.infinity,
              color: AppColors.black12,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                        color: AppColors.white,
                        borderRadius: BorderRadiusDirectional.circular(10)),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CircularProgressIndicator.adaptive(
                        strokeWidth: 1.4,
                        valueColor: AlwaysStoppedAnimation<Color>(
                          Get.theme.primaryColor,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            )
          : Container(),
    );
  }
}
