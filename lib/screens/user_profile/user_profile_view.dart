import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ismmart_ecommerce/helpers/app_colors.dart';
import 'package:ismmart_ecommerce/helpers/theme_helper.dart';
import 'package:ismmart_ecommerce/screens/user_profile/user_profile_viewmodel.dart';

import '../../widgets/custom_appbar.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_network_image.dart';
import '../../widgets/loader_view.dart';
import '../edit_user_profile/edit_user_profile_view.dart';

class UserProfileView extends StatelessWidget {
  UserProfileView({super.key});

  final UserProfileViewModel viewModel = Get.put(UserProfileViewModel());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar2(
        title: 'User Profile',
        titleTextStyle: ThemeHelper.textTheme.labelLarge,
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  profileImage(),
                  headingItem('Personal Info'),
                  containerDecoration(
                    children: [
                      Obx(
                        () => item1(
                          title: "Name",
                          value: viewModel.userProfileModel.value.name ?? 'N/A',
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 25),
                        child: Obx(
                          () => item1(
                            title: "Email",
                            value:
                                viewModel.userProfileModel.value.email ?? 'N/A',
                          ),
                        ),
                      ),
                      Obx(
                        () => item1(
                          title: "Phone",
                          value:
                              viewModel.userProfileModel.value.phone ?? 'N/A',
                        ),
                      ),
                      const SizedBox(height: 25),
                      Obx(
                        () => item1(
                          title: "Gender",
                          value:
                              viewModel.userProfileModel.value.gender ?? 'N/A',
                        ),
                      ),
                    ],
                  ),
                  headingItem('Contact Info'),
                  containerDecoration(
                    children: [
                      Obx(
                        () => item1(
                          title: "CNIC Number",
                          value: viewModel.userProfileModel.value.cnic ?? 'N/A',
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 25),
                  editBtn(),
                  const SizedBox(height: 80),
                ],
              ),
            ),
          ),
          const LoaderView(),
        ],
      ),
    );
  }

  Widget profileImage() {
    return Align(
      alignment: Alignment.center,
      child: Obx(() => CustomNetworkImage(
            imageUrl: viewModel.userProfileModel.value.image != null
                ? viewModel.userProfileModel.value.image!
                : '',
          )),
    );
  }

  Widget headingItem(String value) {
    return Padding(
      padding: const EdgeInsets.only(top: 35, bottom: 15, left: 24, right: 24),
      child: Text(
        value,
        style: ThemeHelper.textTheme.labelLarge
            ?.copyWith(color: AppColors.grey5, fontWeight: FontWeight.w700),
      ),
    );
  }

  Widget item1({required String title, required String value}) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 24,
      ),
      child: Row(
        children: [
          Text(title,
              style: ThemeHelper.textTheme.labelMedium
                  ?.copyWith(color: AppColors.grey5, fontSize: 14)),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              value,
              textAlign: TextAlign.right,
              style: ThemeHelper.textTheme.labelMedium
                  ?.copyWith(color: Colors.black),
            ),
          ),
        ],
      ),
    );
  }

  Widget containerDecoration({List<Widget> children = const <Widget>[]}) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border.all(color: const Color(0xFFF3F4F6)),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: children,
      ),
    );
  }

  Widget editBtn() {
    return CustomTextBtn(
      title: 'Edit',
      backgroundColor: Colors.transparent,
      foregroundColor: AppColors.black,
      onPressed: () {
        Get.to(() => EditUserProfileView(),
            arguments: {'model': viewModel.userProfileModel});
      },
      child: Text('Edit', style: ThemeHelper.textTheme.labelMedium),
    );
  }
}
