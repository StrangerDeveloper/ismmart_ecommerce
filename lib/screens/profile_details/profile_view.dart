import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:ismmart_ecommerce/helpers/app_colors.dart';
import 'package:ismmart_ecommerce/helpers/theme_helper.dart';
import 'package:ismmart_ecommerce/screens/profile_details/profile_viewmodel.dart';

import '../../widgets/custom_appbar.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/loader_view.dart';
import '../../widgets/widget_models/custom_cached_network_image.dart';
import '../edit_user_profile/edit_user_profile_view.dart';

class ProfileView extends StatelessWidget {
  ProfileView({super.key});

  final ProfileViewModel viewModel = Get.put(ProfileViewModel());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appbar(),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Gap(24),
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
                  // headingItem('Contact Info'),
                  // containerDecoration(
                  //   children: [
                  //     Obx(
                  //       () => item1(
                  //         title: "CNIC Number",
                  //         value: viewModel.userProfileModel.value.cnic ?? 'N/A',
                  //       ),
                  //     ),
                  //   ],
                  // ),
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
      child: Obx(() => CustomCachedNetworkImage(
            imageUrl: viewModel.userProfileModel.value.image != null
                ? viewModel.userProfileModel.value.image!
                : "",
          )),
    );
  }

  Widget headingItem(String value) {
    return Padding(
      padding: const EdgeInsets.only(top: 35, bottom: 16, left: 24, right: 24),
      child: Text(
        value,
        style: ThemeHelper.textTheme.bodyLarge
            ?.copyWith(color: AppColors.grey5, fontWeight: FontWeight.w700),
      ),
    );
  }

  Widget item1({required String title, required String value}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
      child: Row(
        children: [
          Text(title,
              style: ThemeHelper.textTheme.bodyMedium?.copyWith(
                  color: AppColors.grey5, fontWeight: FontWeight.w600)),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              value,
              textAlign: TextAlign.right,
              style: ThemeHelper.textTheme.bodyMedium
                  ?.copyWith(fontWeight: FontWeight.w600),
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

  // Widget editBtn() {
  //   return CustomTextBtn(
  //     title: 'Edit',
  //     backgroundColor: Colors.transparent,
  //     foregroundColor: AppColors.black,
  //     onPressed: () {
  //       Get.to(() => EditUserProfileView(),
  //           arguments: {'model': viewModel.userProfileModel});
  //     },
  //     child: Text('Edit', style: ThemeHelper.textTheme.labelMedium),
  //   );
  // }

  PreferredSizeWidget appbar() {
    return CustomAppBar2(
      title: 'Profile Details',
      titleTextStyle: ThemeHelper.textTheme.bodyLarge,
      centerTitle: true,
    );
  }

  Widget editBtn() {
    return Padding(
      padding: const EdgeInsets.only(top: 32, bottom: 15),
      child: CustomTextBtn(
        radius: 30,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Edit",
              style: ThemeHelper.textTheme.bodyLarge
                  ?.copyWith(color: AppColors.white),
            ),
          ],
        ),
        onPressed: () {
          Get.to(() => EditUserProfileView(),
              arguments: {'model': viewModel.userProfileModel});
        },
      ),
    );
  }
}
