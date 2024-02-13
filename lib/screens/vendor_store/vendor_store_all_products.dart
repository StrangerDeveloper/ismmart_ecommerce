import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ismmart_ecommerce/screens/vendor_store/vendor_store_view.dart';
import 'package:ismmart_ecommerce/screens/vendor_store/vendor_store_viewmodel.dart';
import 'package:ismmart_ecommerce/widgets/circular_progress_bar.dart';

import '../../helpers/app_colors.dart';

class VendorStoreAllProducts extends StatelessWidget {
  VendorStoreAllProducts({super.key});

  final VendorStoreViewModel viewModel = Get.find();
  final VendorStoreView view = VendorStoreView();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10, bottom: 20),
      child: viewModel.fetchingProducts.isFalse && viewModel.allProductsPageProductList.isEmpty ? LayoutBuilder(
        builder: (context, constraints) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              view.categoryAndProductsList(productList: viewModel.allProductsPageProductList),
            ],
          );
        }
      ) : SingleChildScrollView(
        controller: viewModel.scrollController,
        physics: const ScrollPhysics(),
        child: Column(
          mainAxisSize: MainAxisSize.max,
            children: [
              view.categoryAndProductsList(productList: viewModel.allProductsPageProductList),
              Obx(() => viewModel.loadMore.value ? const CustomCircularLoader() : const SizedBox())
            ],
          ),
      ),
    );
  }
}
