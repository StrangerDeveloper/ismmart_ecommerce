import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ismmart_ecommerce/screens/home/home_view.dart';

import '../../helpers/global_variables.dart';

class BottomNavigationViewModel extends GetxController {

  Widget selectView(int index) {
    switch (index) {
      case 0:
        return HomeView();
      case 1:
        return SizedBox();
      case 2:
        return SizedBox();
      case 3:
        return SizedBox();
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
