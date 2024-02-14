import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ismmart_ecommerce/helpers/app_colors.dart';
import 'package:ismmart_ecommerce/helpers/app_routes.dart';
import 'package:ismmart_ecommerce/helpers/theme_helper.dart';
import 'package:ismmart_ecommerce/widgets/custom_appbar.dart';
import 'package:ismmart_ecommerce/widgets/custom_network_image.dart';

class SettingsView extends StatelessWidget {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar2(
        title: 'Settings',
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            accountSetup(),
            generalSettings(),
          ],
        ),
      ),
    );
  }

  Widget accountSetup() {
    return accountWidget(
        Icons.person, '', "Login / Singup", 'Login or Sign Up to continue...');
  }

  Widget accountWidget(icon, imageUrl, title, subTitle) {
    return Container(
      margin: const EdgeInsets.only(top: 5),
      decoration: BoxDecoration(
        color: Colors.grey[300]!,
        borderRadius: BorderRadius.circular(8),
      ),
      child: ListTile(
        onTap: () {
          Get.toNamed(AppRoutes.loginViewRoute);
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
          style: ThemeHelper.textTheme.bodyMedium,
        ),

        // Column(
        //   children: [
        //     Text(
        //       title,
        //       style: ThemeHelper.textTheme.bodyMedium,
        //     ),

        //     Padding(
        //       padding: const EdgeInsets.symmetric(vertical:8.0),
        //       child: Text(
        //         subTitle,
        //         style: ThemeHelper.textTheme.bodySmall,
        //       ),
        //     ),
        //   ],
        // ),
        subtitle: Text(
          subTitle,
          style: ThemeHelper.textTheme.bodySmall,
        ),
      ),
    );
  }

  Widget generalSettings() {
    return Container();
  }
}
