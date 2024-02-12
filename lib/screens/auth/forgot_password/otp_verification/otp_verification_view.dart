import 'dart:async';
import 'dart:ffi';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:ismmart_ecommerce/screens/auth/forgot_password/otp_verification/opt_verification_viewmodel.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import '../../../../helpers/app_colors.dart';
import '../../../../helpers/theme_helper.dart';
import '../../../../widgets/custom_appbar.dart';
import '../../../../widgets/custom_button.dart';
import '../../../../widgets/custom_text.dart';
import '../../../../widgets/loader_view.dart';

class OtpVerificationView extends StatefulWidget {
  OtpVerificationView({Key? key}) : super(key: key);

  @override
  State<OtpVerificationView> createState() => _OtpVerificationViewState();
}

class _OtpVerificationViewState extends State<OtpVerificationView> {
  OtpVerificationViwModel viewModel = Get.put(OtpVerificationViwModel());
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: appbar(),
        backgroundColor: Colors.white,
        body: Stack(
          children: [
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 25.0, vertical: 26),
              child: Column(
                children: [
                  Gap(50),
                  headings(),
                  pindValidationField(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomText(
                        title: "Valid till",
                        color: Colors.red,
                        size: 12,
                      ),
                      Obx(
                        () => Column(
                          children: [
                            CustomText(
                              title: "${viewModel.counter.value}",
                              color: Colors.red,
                              size: 12,
                              weight: FontWeight.w700,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),

                  // pinCodeTextField(context),
                  verifyButton(),
                  const Spacer(),
                  // bottomText(),
                ],
              ),
            ),
            const LoaderView()
          ],
        ),
      ),
    );
  }

  Widget verifyButton() {
    return Padding(
        padding: const EdgeInsets.only(top: 32),
        child: CustomTextBtn(
          radius: 30,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const CustomText(
                title: "Confirm code",
                size: 14,
                color: AppColors.white,
                weight: FontWeight.w500,
              ),
              SizedBox(width: 2),
              const Icon(
                Icons.arrow_forward,
                size: 20,
              ),
            ],
          ),
          onPressed: () {
            // viewModel.signIn();
            //
          },
        ));
  }

  PreferredSizeWidget appbar() {
    return CustomAppBar2(
      title: 'Verification',
      titleTextStyle: ThemeHelper.textTheme.titleMedium,
      centerTitle: true,
    );
  }

  Widget headings() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Verification',
          style: ThemeHelper.textTheme.titleSmall,
        ),
        Padding(
          padding: const EdgeInsets.only(
            top: 8,
            right: 20,
            bottom: 32,
          ),
          child: RichText(
              maxLines: 3,
              textAlign: TextAlign.start,
              text: TextSpan(children: [
                TextSpan(
                  text:
                      'We have sent a verification code to asha****iq11@gmail.com ',
                  style: ThemeHelper.textTheme.bodyMedium
                      ?.copyWith(color: AppColors.grey2),
                ),
                TextSpan(
                    text: 'Change?', style: TextStyle(color: Colors.black)),
              ])),
        ),
      ],
    );
  }

  Widget pindValidationField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomText(
          title: "Verification Code",
          size: 14,
          weight: FontWeight.w500,
        ),
        Gap(10),
        PinCodeTextField(
          // controller: _otpController,
          keyboardType: TextInputType.number,
          inputFormatters: <TextInputFormatter>[
            FilteringTextInputFormatter.digitsOnly
          ],
          appContext: context,
          // obscureText: false,
          // obscuringWidget: Container(
          //   height: 10,
          //   width: 10,
          //   decoration: BoxDecoration(
          //       borderRadius: BorderRadius.circular(50),
          //       color: Colors.black),
          // ),
          length: 6,
          onChanged: (value) {},
          cursorColor: Colors.black,
          // textStyle: ThemeHelper.textTheme,
          pinTheme: PinTheme(
            shape: PinCodeFieldShape.box,
            borderRadius: BorderRadius.circular(8),
            activeColor: Colors.grey.shade400,
            selectedColor: Colors.grey.shade400,
            inactiveColor: Colors.grey.shade200,
            activeFillColor: Colors.black,
            selectedFillColor: AppColors.red,
            inactiveFillColor: AppColors.red,
            errorBorderColor: Colors.red,
            fieldWidth: Get.width * .1,
            fieldHeight: 50,
          ),
          animationDuration: const Duration(milliseconds: 300),
          // enableActiveFill: true,
          // errorAnimationController: errorController,
        ),
      ],
    );
  }
}
