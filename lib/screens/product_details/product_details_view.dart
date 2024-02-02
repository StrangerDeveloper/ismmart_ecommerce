import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ismmart_ecommerce/helpers/app_colors.dart';
import 'package:ismmart_ecommerce/screens/product_details/product_details_viewmodel.dart';
import 'package:ismmart_ecommerce/widgets/custom_appbar.dart';
import 'package:ismmart_ecommerce/widgets/custom_button.dart';
import 'package:ismmart_ecommerce/widgets/custom_network_image.dart';

class ProductDetailsView extends StatelessWidget {
  ProductDetailsView({super.key});

  final ProductDetailsViewModel viewModel = Get.put(ProductDetailsViewModel());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar2(
        title: 'ISMMART',
        actions: [Icon(Icons.favorite_outlined), Icon(Icons.shopping_basket)],
      ),
      body: ListView(
        children: [
          _carousel(),
        ],
      ),
    );
  }

  Widget _carousel() {
    return Stack(
      children: [
        PageView(
          onPageChanged: (value) => viewModel.carouselIndicatorIndex(value),
          children: List.generate(
              viewModel.carouselList.length,
              (index) => CustomNetworkImage(
                    imageUrl: viewModel.carouselList[index],
                  )),
        ),

        // rightForwardImageBtn
         CustomIconBtn2(
          onTap: () {

          },
          color: AppColors.grey5,
          icon: Icons.arrow_forward_ios,
        ),


      ],
    );
  }
}
