import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ismmart_ecommerce/screens/signup/singup_viewmodel.dart';
import 'package:path/path.dart' as p;
import '../../widgets/custom_image_widget/image_layout_container.dart';
import '../../widgets/custom_image_widget/pick_image.dart';

class SignupView extends StatelessWidget {
  SignupView({super.key});
  final SingupViewModel viewModel = Get.put(SingupViewModel());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [SizedBox(width: Get.width * .8, child: cnicFrontImage())],
      ),
    );
  }

  Widget cnicFrontImage() {
    return Obx(
      () => ImageLayoutContainer(
        title: 'CNIC Front Image',
        filePath: viewModel.cnicFrontImage.value == ''
            ? ''
            : p.basename(viewModel.cnicFrontImage.value.path),
        onTap: () async {
          viewModel.cnicFrontImage.value =
              await PickImage().pickSingleImage() ?? File('');
          if (viewModel.cnicFrontImage.value.path.isNotEmpty) {
            viewModel.cnicFrontImageErrorVisibility.value = false;
          }
        },
        errorVisibility: viewModel.cnicFrontImageErrorVisibility.value,
        errorPrompt: 'CNIC Front Image is required',
      ),
    );
  }
}
