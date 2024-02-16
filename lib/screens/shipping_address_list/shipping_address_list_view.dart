import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ismmart_ecommerce/helpers/app_colors.dart';
import 'package:ismmart_ecommerce/helpers/app_routes.dart';
import 'package:ismmart_ecommerce/helpers/global_variables.dart';
import 'package:ismmart_ecommerce/screens/shipping_address_list/shipping_address_list_viewmodel.dart';
import 'package:ismmart_ecommerce/widgets/loader_view.dart';

import '../../widgets/custom_appbar.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_checkbox.dart';
import '../add_shipping_address/add_shipping_address_view.dart';
import '../add_shipping_address/add_shipping_address_view.dart';

class ShippingAddressListView extends StatelessWidget {
  ShippingAddressListView({super.key});
  final ShippingAddressListViewModel viewModel =
      Get.put(ShippingAddressListViewModel());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: const CustomAppBar2(
        containsLeading: true,
        title: 'Shipping Addresses',
      ),
      body: Stack(
        children: [
          Column(
            children: [
              listView(),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                child: CustomIconTextBtn(
                  title: 'Add More Addresses',
                  onPressed: () {
                    // Get.toNamed(AppRoutes.addShippingAddressViewRoute);
                    Get.to(AddShippingAddressView());
                  },
                  icon: Icons.add,
                  width: double.infinity,
                ),
              ),
            ],
          ),
          LoaderView()
        ],
      ),
    );
  }

  Widget listView() {
    return Expanded(
      child: Obx(
        () => ListView.builder(
          padding: const EdgeInsets.symmetric(vertical: 10),
          itemCount: viewModel.shippingAddrList.length,
          itemBuilder: (context, int index) {
            return listViewItem(index);
          },
        ),
      ),
    );
  }

  Widget listViewItem(int index) {
    var adress = viewModel.shippingAddrList[index];

    return InkWell(
      onTap: () {
        viewModel.checkIndex.value = index;
        viewModel.selectedAdress['name'] = "${adress.name}";
        viewModel.selectedAdress['country'] = "${adress.country?.name}";
        viewModel.selectedAdress['adress'] = "${adress.address}";
      },
      child: Container(
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
            Align(
              alignment: Alignment.centerRight,
              child: InkWell(
                onTap: () {
                  Get.to(AddShippingAddressView(),
                      arguments: {'editData': false});
                },
                child: Text(
                  'Edit',
                  style: TextStyle(
                    color: AppColors.red,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
            Text(
              "    ${adress.name} ",
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w700,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 2, bottom: 8),
              child: Text(
                "${adress.address} ${adress.country?.name}",
                style: TextStyle(
                  fontSize: 12,
                ),
              ),
            ),
            Obx(
              () => CustomCheckBox(
                title: 'Use as the shipping address',
                value:
                    viewModel.checkIndex.value == index ? true.obs : false.obs,
                onChanged: (value) {},
              ),
            ),
          ],
        ),
      ),
    );
  }
}
