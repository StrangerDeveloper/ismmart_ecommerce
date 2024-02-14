import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:ismmart_ecommerce/screens/home/home_view.dart';
import 'package:ismmart_ecommerce/screens/user_profile/user_profile_model.dart';

import '../../helpers/global_variables.dart';
import '../../helpers/notifications_function.dart';
import '../user_profile/user_profile_view.dart';
import '../category/category_view.dart';
import '../profile_details/profile_details_view.dart';

class BottomNavigationViewModel extends GetxController {

  @override
  void onReady() async {
    await GetStorage.init();
    NotificationsServices notificationServices = NotificationsServices();
    notificationServices.requestNotificationPermission();
    notificationServices.forgroundMessage();
    notificationServices.firebaseInit(Get.context!);
    notificationServices.setupInteractMessage(Get.context!);
    GlobalVariable.notificationsToken = await notificationServices.getDeviceToken();
    getUserData();
    super.onReady();
  }

  getUserData() async {
    if(await GetStorage().read('userData') != null){
      GlobalVariable.userModel.value = UserProfileModel.fromJson(await GetStorage().read('userData'));
    }

    if(await GetStorage().read('deviceInfo') != null) {
      final deviceInfo = await GetStorage().read('deviceInfo');
      if(GlobalVariable.notificationsToken != deviceInfo['fcm']){
        NotificationsServices().updateDeviceToken(GlobalVariable.notificationsToken, data: deviceInfo);
      }
    }
  }

  Widget selectView(int index) {
    switch (index) {
      case 0:
        return HomeView();
      case 1:
        return SizedBox();
      case 2:
        return CategoryView();
      case 3:
        return UserProfileView();
      default:
        return Container(
          height: 300.0,
          width: Get.width,
          color: Colors.red,
        );
    }
  }

  onBackPressed(BuildContext context) async {
    if (GlobalVariable.selectedIndex.value == 0) {
      await showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Exit App'),
            content: const Text('Are you sure you want to exit?'),
            actions: [
              Row(
                children: [
                  Expanded(
                    child: TextButton(
                      child: const Text('No'),
                      onPressed: () {
                        Navigator.of(context).pop(false);
                      },
                    ),
                  ),
                  Expanded(
                    child: TextButton(
                      child: const Text('Yes'),
                      onPressed: () {
                        Navigator.of(context).pop(true);
                        exit(0);
                      },
                    ),
                  ),
                ],
              ),
            ],
          );
        },
      );
    } else {
      GlobalVariable.selectedIndex.value = 0;
    }
  }
}
