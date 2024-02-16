import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ismmart_ecommerce/helpers/app_routes.dart';
import 'package:ismmart_ecommerce/helpers/global_variables.dart';
import 'package:ismmart_ecommerce/screens/change_password/change_password_viewmodel.dart';
import 'package:ismmart_ecommerce/widgets/custom_appbar.dart';
import 'package:ismmart_ecommerce/widgets/custom_button.dart';
import 'package:ismmart_ecommerce/widgets/custom_text_field.dart';
import 'package:ismmart_ecommerce/widgets/loader_view.dart';
import 'package:ismmart_ecommerce/widgets/scrollable_column.dart';

import '../../helpers/app_colors.dart';
import '../../helpers/theme_helper.dart';

class ChangePasswordView extends StatelessWidget {
  ChangePasswordView({super.key});

  final ChangePasswordViewModel viewModel = Get.put(ChangePasswordViewModel());

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: CustomAppBar2(
        title: 'Change Password',
        centerTitle: true,
        leadingOnPressed: GlobalVariable.showLoader.value ? () {} : null,
        containsLeading: true,
        titleTextStyle: ThemeHelper.textTheme.bodyLarge!.copyWith(
            color: AppColors.black3
        ),
      ),
      body: Stack(
        children: [
          Form(
            key: viewModel.formKey,
            child: ScrollableColumn(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 25, left: 20, right: 20),
                  child: Obx(() => CustomTextField1(
                      obscureText: viewModel.obscureCurrentPassword.value,
                      title: 'Current Password',
                      validator: (value) => viewModel.validateCharacterLength(value),
                      autoValidateMode: AutovalidateMode.onUserInteraction,
                      controller: viewModel.currentPasswordController,
                      prefixIcon: Icons.lock_rounded,
                      hintText: '******',
                      suffixIconButton: IconButton(
                        onPressed: () {
                          viewModel.obscureCurrentPassword.value =
                          !viewModel.obscureCurrentPassword.value;
                        },
                          icon: viewModel.obscureCurrentPassword.value ? const Icon(
                              Icons.visibility_off_outlined,
                            size: 20,
                            color: AppColors.grey2,) : const Icon(
                              Icons.visibility_outlined,
                            size: 20,
                            color: AppColors.grey2,
                          ),
                        ),
                      ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Align(
                    alignment: Alignment.topRight,
                    child: TextButton(
                        onPressed: () => Get.toNamed(AppRoutes.forgotPasswordRoute),
                        child: Text(
                          'Forgot Password?',
                          style: ThemeHelper.textTheme.bodyMedium?.copyWith(
                              color: AppColors.black3,
                              decorationColor: AppColors.black3,
                              decoration: TextDecoration.underline,
                              fontWeight: FontWeight.w700
                          ),
                        )
                    ),
                  ),
                ),
                const SizedBox(height: 15,),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Obx(() => CustomTextField1(
                    obscureText: viewModel.obscureNewPassword.value,
                      controller: viewModel.newPasswordController,
                      autoValidateMode: AutovalidateMode.onUserInteraction,
                      validator: (value) => viewModel.validateCharacterLength(value),
                      title: 'New Password',
                      prefixIcon: Icons.lock_rounded,
                      hintText: 'Hello@456',
                      suffixIconButton: IconButton(
                          onPressed: () => viewModel.obscureNewPassword.value = !viewModel.obscureNewPassword.value,
                          icon: viewModel.obscureNewPassword.value ? const Icon(
                              Icons.visibility_off_outlined,
                            size: 20,
                            color: AppColors.grey2,
                          ) : const Icon(
                              Icons.visibility_outlined,
                            size: 20,
                            color: AppColors.grey2,
                          )
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20,),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Obx(() => CustomTextField1(
                    obscureText: viewModel.obscureConfirmPassword.value,
                      controller: viewModel.confirmPasswordController,
                    autoValidateMode: AutovalidateMode.onUserInteraction,
                    validator: (value) {
                      final characterCheck = viewModel.validateCharacterLength(value);
                      if(characterCheck == null) {
                        if(value == viewModel.newPasswordController.text) {
                          return null;
                        } else {
                          return 'Passwords don\'t match';
                        }
                      } else {
                        return characterCheck;
                      }
                    },
                      title: 'Confirm Password',
                      prefixIcon: Icons.lock_rounded,
                      hintText: '******',
                      suffixIconButton: IconButton(
                          onPressed: () => viewModel.obscureConfirmPassword.value = !viewModel.obscureConfirmPassword.value,
                          icon: viewModel.obscureConfirmPassword.value ? const Icon(
                            Icons.visibility_off_outlined,
                            size: 20,
                            color: AppColors.grey2,
                          ) : const Icon(
                            Icons.visibility_outlined,
                            size: 20,
                            color: AppColors.grey2,
                          )
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        CustomTextBtn(
                          onPressed: () {
                            if(viewModel.formKey.currentState!.validate()){
                              viewModel.changePassword();
                            }
                          },
                          title: 'Change Password',
                          textStyle: ThemeHelper.textTheme.bodySmall?.copyWith(
                              color: AppColors.white,
                              fontWeight: FontWeight.w600
                          ),
                          // backgroundColor: AppColors.black,
                        ),
                        CustomTextBtn(
                          onPressed: () {},
                          title: 'Cancel',
                          borderSide: const BorderSide(
                              width: 1.2,
                              color: AppColors.black
                          ),
                          textStyle: ThemeHelper.textTheme.bodySmall?.copyWith(
                              color: AppColors.black,
                              fontWeight: FontWeight.w600
                          ),
                          backgroundColor: AppColors.white,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          const LoaderView()
        ],
      ),
    );
  }
}