import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ismmart_ecommerce/helpers/app_colors.dart';
import 'package:ismmart_ecommerce/screens/shipping_address_list/shipping_address_list_viewmodel.dart';

import '../../widgets/custom_appbar.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_checkbox.dart';

class ShippingAddressListView extends StatelessWidget {
  ShippingAddressListView({super.key});
  final ShippingAddressListViewModel viewModel =
      Get.put(ShippingAddressListViewModel());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: const CustomAppBar2(
        title: 'Shipping Addresses',
      ),
      body: Column(
        children: [
          listView(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            child: CustomIconTextBtn(
              title: 'Add More Addresses',
              onPressed: () {},
              icon: Icons.add,
              width: double.infinity,
            ),
          ),
        ],
      ),
    );
  }

  Widget listView() {
    return Expanded(
      child: ListView.builder(
        padding: const EdgeInsets.symmetric(vertical: 10),
        itemCount: 3,
        itemBuilder: (context, int index) {
          return listViewItem(index);
        },
      ),
    );
  }

  Widget listViewItem(int index) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: AppColors.white,
          boxShadow: const [
            BoxShadow(
              color: Color(0x14000000),
              blurRadius: 25,
              offset: Offset(0, 1),
              spreadRadius: 0,
            ),
          ]),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Align(
            alignment: Alignment.centerRight,
            child: Text(
              'Edit',
              style: TextStyle(
                color: AppColors.red,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          const Text(
            'Home',
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w700,
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(top: 2, bottom: 8),
            child: Text(
              'Chino Hills, CA 91709, United States',
              style: TextStyle(
                fontSize: 12,
              ),
            ),
          ),
          CustomCheckBox(
            title: 'Use as the shipping address',
            value: false.obs,
            onChanged: (value) {},
          ),
        ],
      ),
    );
  }
}
