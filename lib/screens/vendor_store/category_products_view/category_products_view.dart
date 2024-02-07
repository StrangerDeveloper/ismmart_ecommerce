import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ismmart_ecommerce/helpers/app_colors.dart';
import 'package:ismmart_ecommerce/screens/vendor_store/vendor_store_viewmodel.dart';
import 'package:ismmart_ecommerce/widgets/custom_appbar.dart';

import '../models/categorized_products_model.dart';
import '../../../widgets/product_item.dart';

class CategoryProductsView extends StatelessWidget {
  CategoryProductsView({super.key});

  final VendorStoreViewModel viewModel = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar2(
        centerTitle: true,
        title: 'Shoes',
        titleTextStyle: GoogleFonts.inter(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: AppColors.black3
        ),
        containsLeading: true,
      ),
      body: SingleChildScrollView(
        physics: ScrollPhysics(),
        padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        child: Column(
          children: [
            GridView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 12,
                crossAxisSpacing: 15,
                childAspectRatio: 0.64,
              ),
              itemCount: viewModel.categoryProducts.length,
              itemBuilder: (context, idx) {
                Product productModel = viewModel.categoryProducts[idx];
                return ProductItem(
                  displayFavIcon: false,
                  image: productModel.imageURL.toString(),
                  name: productModel.name.toString(),
                  category: 'A2Z Store',
                  price: productModel.actualPrice.toString(),
                  rating: productModel.reviewStar.toString(),
                  reviews: productModel.reviewsNumber.toString(),
                  previousPrice: productModel.discountedPrice.toString(),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
