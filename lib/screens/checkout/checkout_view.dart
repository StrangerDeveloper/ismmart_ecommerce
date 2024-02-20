import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ismmart_ecommerce/helpers/app_colors.dart';
import 'package:ismmart_ecommerce/helpers/app_routes.dart';
import 'package:ismmart_ecommerce/helpers/global_variables.dart';
import 'package:ismmart_ecommerce/screens/checkout/checkout_viewmodel.dart';
import 'package:ismmart_ecommerce/widgets/custom_button.dart';

import '../../helpers/theme_helper.dart';
import '../../widgets/custom_appbar.dart';
import '../../widgets/custom_network_image.dart';
import '../../widgets/custom_radiobtn.dart';
import '../shipping_address_list/shipping_address_list_view.dart';
import '../shipping_address_list/shipping_address_list_viewmodel.dart';

class CheckoutView extends StatelessWidget {
  CheckoutView({super.key});

  final CheckoutViewModel viewModel = Get.put(CheckoutViewModel());
  final ShippingAddressListViewModel viewModel1 =
      Get.put(ShippingAddressListViewModel());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const CustomAppBar2(
        containsLeading: true,
        title: 'Checkout',
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            changeShippingAddress(),
            GlobalVariable.token == '' ? if_Not_Login() : shippingAddress(),
            headingItem('Payment'),
            Obx(
              () => Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: CustomRadioButton1(
                  title: 'Cash On Delivery (COD)',
                  groupValue: viewModel.paymentRadioBtn.value,
                  value: 'cod',
                  onChanged: (value) {
                    viewModel.paymentRadioBtn(value);
                  },
                ),
              ),
            ),
            Obx(
              () => Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: CustomRadioButton1(
                  title: 'Credit / Debit Card',
                  groupValue: viewModel.paymentRadioBtn.value,
                  value: 'credit',
                  onChanged: (value) {
                    viewModel.paymentRadioBtn(value);
                  },
                ),
              ),
            ),
            headingItem('Courier Service'),
            courierService(),
            calculationItem(
              title: 'Subtotal',
              value: '\$753.95',
            ),
            calculationItem(
              title: 'Delivery',
              value: '\$60.25',
            ),
            const Divider(height: 50),
            calculationItem(
              title: 'Delivery',
              value: '\$60.25',
              titleStyle: const TextStyle(
                color: Colors.black,
                fontSize: 16,
              ),
              valueStyle: const TextStyle(
                fontWeight: FontWeight.w900,
                fontSize: 16,
              ),
            ),
            placeOrderBtn(),
          ],
        ),
      ),
    );
  }

  Widget headingItem(String value) {
    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 16, bottom: 13, top: 30),
      child: Text(
        value,
        style: const TextStyle(
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Widget changeShippingAddress() {
    return Padding(
      padding: const EdgeInsets.only(right: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          headingItem(
            'Shipping Address',
          ),
          InkWell(
            onTap: () {
              Get.to(
                () => ShippingAddressListView(),
              );
            },
            child: const Text(
              'Change',
              style: TextStyle(
                color: Color(0xFFFE3A30),
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget shippingAddress() {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Colors.white,
        boxShadow: const [
          BoxShadow(
            color: Color(0x14000000),
            blurRadius: 25,
            offset: Offset(0, 1),
            spreadRadius: 0,
          ),
        ],
      ),
      child: Obx(
        () => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              viewModel1.selectedAdress['name'] ?? '',
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w700,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 2, bottom: 8),
              child: Text(
                "${viewModel1.selectedAdress['adress']} ${viewModel1.selectedAdress['country']}" ??
                    '',
                style: TextStyle(
                  fontSize: 12,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget courierService() {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Colors.white,
        boxShadow: const [
          BoxShadow(
            color: Color(0x14000000),
            blurRadius: 25,
            offset: Offset(0, 1),
            spreadRadius: 0,
          ),
        ],
      ),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Leopards',
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w700,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 2, bottom: 8),
            child: Text(
              'Order will be delivered in next 2-3 days',
              style: TextStyle(
                fontSize: 12,
                color: AppColors.grey2,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget calculationItem({
    required String title,
    required String value,
    TextStyle? titleStyle,
    TextStyle? valueStyle,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          Text(
            title,
            style: titleStyle ??
                const TextStyle(
                  color: AppColors.grey4,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              value,
              textAlign: TextAlign.right,
              style: valueStyle ??
                  const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
            ),
          )
        ],
      ),
    );
  }

  Widget placeOrderBtn() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: CustomTextBtn(
        title: 'Place Order',
        onPressed: () {},
      ),
    );
  }

  Widget if_Not_Login() {
    return accountWidget(
        Icons.person, '', "Login / Sing Up", 'Login or Sign Up to continue...');
  }

  Widget accountWidget(icon, imageUrl, title, subTitle) {
    return ListTile(
      onTap: () {
        GlobalVariable.auth_From_CheckOut.value == true;
        Get.toNamed(AppRoutes.loginViewRoute);
      },
      leading: Container(
        width: 70,
        height: 70,
        padding: const EdgeInsets.all(5),
        decoration:
            const BoxDecoration(color: AppColors.grey6, shape: BoxShape.circle
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
}
