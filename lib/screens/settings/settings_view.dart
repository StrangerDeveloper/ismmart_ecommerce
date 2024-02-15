import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:ismmart_ecommerce/helpers/app_colors.dart';
import 'package:ismmart_ecommerce/helpers/app_routes.dart';
import 'package:ismmart_ecommerce/helpers/global_variables.dart';
import 'package:ismmart_ecommerce/helpers/theme_helper.dart';
import 'package:ismmart_ecommerce/screens/faq/faq_view.dart';
import 'package:ismmart_ecommerce/screens/settings/settings_viewmodel.dart';
import 'package:ismmart_ecommerce/widgets/custom_appbar.dart';
import 'package:ismmart_ecommerce/widgets/custom_network_image.dart';

class SettingsView extends StatelessWidget {
  SettingsView({super.key});
  final SettingsViewModel viewModel = Get.put(SettingsViewModel());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar2(
        title: 'Settings',
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              accountSetup(),
              generalSettings(),
            ],
          ),
        ),
      ),
    );
  }

  Widget accountSetup() {
    return Obx(
      () => viewModel.token.isEmpty &&
              GlobalVariable.userModel.value.email == null
          ? accountWidget(Icons.person, '', "Login / Sing Up",
              'Login or Sign Up to continue...')
          : accountWidget(
              null,
              GlobalVariable.userModel.value.image,
              GlobalVariable.userModel.value.name,
              GlobalVariable.userModel.value.email),
    );
  }

  Widget accountWidget(icon, imageUrl, title, subTitle) {
    return ListTile(
      onTap: () {
        GlobalVariable.userModel.value.email == null
            ? Get.toNamed(AppRoutes.loginViewRoute)
            : Get.toNamed(AppRoutes.profileViewRoute);
      },
      leading: icon == null
          ? CustomNetworkImage(imageUrl: imageUrl)
          : Container(
              width: 70,
              height: 70,
              padding: const EdgeInsets.all(5),
              decoration: const BoxDecoration(
                  color: AppColors.grey6, shape: BoxShape.circle
                  //borderRadius: BorderRadius.circular(30),
                  ),
              child: const Icon(
                Icons.person_rounded,
                size: 30,
              ),
            ),
      title: Text(
        title,
        style: ThemeHelper.textTheme.bodyMedium!
            .copyWith(fontWeight: FontWeight.w600),
      ),
      subtitle: Text(
        subTitle,
        style: ThemeHelper.textTheme.bodySmall,
      ),
    );
  }

  Widget generalSettings() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 15),
      child: Obx(
        () => Column(
          children: [
            if (viewModel.token.isNotEmpty)
              generalSettingsItem(
                'bell_outline.svg',
                'Notifications',
                onTap: () => Get.toNamed(AppRoutes.notificationRoute),
              ),
            if (viewModel.token.isNotEmpty)
              generalSettingsItem(
                'inbox_full_outline.svg',
                'Orders',
                onTap: () => Get.toNamed(AppRoutes.orderViewRoute),
              ),
            if (viewModel.token.isNotEmpty)
              generalSettingsItem(
                'home_outline.svg',
                'Shipping Addresses',
                onTap: () => Get.toNamed(AppRoutes.shippingAdressRoute),
              ),
            if (viewModel.token.isNotEmpty)
              generalSettingsItem(
                'wallet_outline.svg',
                'Wallet',
                onTap: () => Get.toNamed(AppRoutes.bankListRoute),
              ),

            //Help Center and its childern
            Column(
              children: [
                generalSettingsItem('question_mark_outline.svg', 'Help Center',
                    onTap: () {
                  viewModel.onHelpPress.value = !viewModel.onHelpPress.value;
                },
                    trailingIcon: viewModel.onHelpPress.isTrue
                        ? Icons.keyboard_arrow_up_rounded
                        : Icons.keyboard_arrow_right_rounded),
                if (viewModel.onHelpPress.isTrue)
                  Padding(
                    padding: const EdgeInsets.only(left: 20.0),
                    child: generalSettingsItem(
                      '',
                      'FAQs',
                      isSubMenu: true,
                      onTap: () => FaqView(),
                    ),
                  ),
                if (viewModel.onHelpPress.isTrue)
                  Padding(
                    padding: const EdgeInsets.only(left: 20.0),
                    child: generalSettingsItem(
                      '',
                      'Contact us',
                      isSubMenu: true,
                      onTap: () {},
                    ),
                  ),
              ],
            ),

            generalSettingsItem(
              'lock_outline.svg',
              'Privacy Policy',
              onTap: () {},
            ),
            generalSettingsItem(
              'file_shield_outline.svg',
              'Return and Exchange Policy',
              onTap: () {},
            ),
            if (viewModel.token.isNotEmpty)
              Column(
                children: [
                  generalSettingsItem('settings_outline.svg', 'Settings',
                      onTap: () {
                    viewModel.onSettingPress.value =
                        !viewModel.onSettingPress.value;
                  },
                      trailingIcon: viewModel.onSettingPress.isTrue
                          ? Icons.keyboard_arrow_up_rounded
                          : Icons.keyboard_arrow_right_rounded),
                  if (viewModel.onSettingPress.isTrue)
                    Padding(
                      padding: const EdgeInsets.only(left: 20.0),
                      child: generalSettingsItem(
                        '',
                        'Change Password',
                        isSubMenu: true,
                        onTap: () {},
                      ),
                    ),
                ],
              ),
            if (viewModel.token.isNotEmpty)
              ListTile(
                leading: SvgPicture.asset(
                  'assets/icons/logout.svg',
                  color: AppColors.red,
                ),
                title: Text(
                  'Logout',
                  style: ThemeHelper.textTheme.bodyLarge!.copyWith(
                      fontWeight: FontWeight.w600, color: AppColors.red),
                ),
              ),
            const SizedBox(
              height: 60,
            ),
          ],
        ),
      ),
    );
  }

  Widget generalSettingsItem(iconName, title,
      {onTap, bool? isSubMenu = false, trailingIcon, bool? isVisible = true}) {
    return isSubMenu!
        ? ListTile(
            onTap: onTap,
            dense: true,
            leading: const SizedBox(width: 20),
            title: Text(
              title,
              style: ThemeHelper.textTheme.bodyMedium!
                  .copyWith(fontWeight: FontWeight.w600),
            ),
          )
        : ListTile(
            onTap: onTap,
            dense: true,
            leading: SvgPicture.asset('assets/icons/$iconName'),
            title: Text(
              title,
              style: ThemeHelper.textTheme.bodyMedium!
                  .copyWith(fontWeight: FontWeight.w600),
            ),
            trailing: Icon(
              trailingIcon ?? Icons.keyboard_arrow_right_rounded,
              //size: 15,
            ),
          );
  }
}
