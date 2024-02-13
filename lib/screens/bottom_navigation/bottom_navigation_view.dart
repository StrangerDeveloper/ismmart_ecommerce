import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ismmart_ecommerce/helpers/app_colors.dart';
import 'package:ismmart_ecommerce/screens/bottom_navigation/bottom_navigation_viewmodel.dart';

import '../../helpers/global_variables.dart';

class BottomNavigationView extends StatelessWidget {
  BottomNavigationView({super.key});

  final BottomNavigationViewModel viewModel =
      Get.put(BottomNavigationViewModel());

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) {
        viewModel.onBackPressed(context);
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        extendBody: true,
        body: Obx(
          () => viewModel.selectView(GlobalVariable.selectedIndex.value),
        ),
        bottomNavigationBar: bottomNavigationBar(context),
      ),
    );
  }

  Widget bellIcon() {
    return Obx(
      () => GlobalVariable.selectedIndex.value == 0
          ? IconButton(
              onPressed: () {
                // Get.to(() => NotificationView());
              },
              icon: const Icon(Icons.notifications),
            )
          : const SizedBox(),
    );
  }

  Widget bottomNavigationBar(BuildContext context) {
    return Obx(
      () => BottomAppBar(
        elevation: 0,
        color: Colors.transparent,
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(35),
              border: Border.all(color: const Color(0xffE5E7EB)),
            ),
            child: Row(
              children: [
                bottomNavigationItem(
                  context,
                  icon: Icons.home_rounded,
                  selected:
                      GlobalVariable.selectedIndex.value == 0 ? true : false,
                  onTap: () {
                    GlobalVariable.selectedIndex.value = 0;
                  },
                  toolTip: 'Home',
                ),
                bottomNavigationItem(
                  context,
                  icon: Icons.shopping_bag_rounded,
                  selected:
                      GlobalVariable.selectedIndex.value == 1 ? true : false,
                  onTap: () {
                    GlobalVariable.selectedIndex.value = 1;
                  },
                  toolTip: 'Cart',
                ),
                bottomNavigationItem(
                  context,
                  fontSize: 40,
                  padding: 1,
                  icon: Icons.add_circle_rounded,
                  selected:
                      GlobalVariable.selectedIndex.value == 2 ? true : false,
                  onTap: () {
                    GlobalVariable.selectedIndex.value = 2;
                  },
                  toolTip: 'Add',
                ),
                bottomNavigationItem(
                  context,
                  icon: Icons.local_offer_rounded,
                  selected:
                      GlobalVariable.selectedIndex.value == 3 ? true : false,
                  onTap: () {
                    GlobalVariable.selectedIndex.value = 3;
                  },
                  toolTip: 'Tag',
                ),
                bottomNavigationItem(
                  context,
                  icon: CupertinoIcons.profile_circled,
                  selected:
                      GlobalVariable.selectedIndex.value == 4 ? true : false,
                  onTap: () {
                    GlobalVariable.selectedIndex.value = 4;
                  },
                  toolTip: 'Profile',
                  padding: 14,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget bottomNavigationItem(
    BuildContext context, {
    required bool selected,
    required GestureTapCallback onTap,
    required IconData icon,
    required String toolTip,
    double fontSize = 24,
    double padding = 15,
    Widget? child,
  }) {
    return Expanded(
      child: Material(
        color: Colors.transparent,
        child: Tooltip(
          message: toolTip,
          child: InkWell(
            customBorder: const StadiumBorder(),
            onTap: onTap,
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: padding),
              child: child ??
                  Icon(
                    icon,
                    size: fontSize,
                    color: selected ? Colors.black : AppColors.grey2,
                  ),
            ),
          ),
        ),
      ),
    );
  }
}
