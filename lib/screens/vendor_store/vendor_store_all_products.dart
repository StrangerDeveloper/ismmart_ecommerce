import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ismmart_ecommerce/screens/vendor_store/vendor_store_view.dart';
import 'package:ismmart_ecommerce/screens/vendor_store/vendor_store_viewmodel.dart';

class VendorStoreAllProducts extends StatelessWidget {
  VendorStoreAllProducts({super.key});

  final VendorStoreViewModel viewModel = Get.find();
  final VendorStoreView view = VendorStoreView();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const ScrollPhysics(),
      child: Column(
        children: [
          view.categoryAndProductsList(),
        ],
      ),
    );
  }
}
