import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ismmart_ecommerce/helpers/app_colors.dart';
import 'package:ismmart_ecommerce/helpers/global_variables.dart';
import 'package:ismmart_ecommerce/helpers/theme_helper.dart';
import 'package:ismmart_ecommerce/widgets/circular_progress_bar.dart';
import 'package:ismmart_ecommerce/widgets/custom_appbar.dart';
import 'package:ismmart_ecommerce/widgets/loader_view.dart';
import '../categorized_products_model.dart';
import '../../../widgets/product_item.dart';
import 'category_products_viewmodel.dart';

class CategoryProductsView extends StatelessWidget {
  CategoryProductsView({super.key});

  final CategoryProductsViewModel viewModel = Get.put(CategoryProductsViewModel());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar2(
        centerTitle: true,
        title: viewModel.categoryName.value,
        titleTextStyle: GoogleFonts.inter(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: AppColors.black3
        ),
        containsLeading: true,
      ),
      body: Stack(
        children: [
          Obx(() => viewModel.retryCheck.value ? Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(onPressed: () {
                viewModel.retryCheck.value = false;
                GlobalVariable.showLoader.value = true;
                viewModel.getCategoryProducts();
              }, icon: const Icon(
                Icons.refresh_rounded,
                size: 22,
                color: AppColors.black,
              )
              ),
              Text(
                'Error fetching products. Retry',
                style: ThemeHelper.textTheme.bodyLarge?.copyWith(
                  color: AppColors.black3
                ),
              )
            ],
          ) : SingleChildScrollView(
              physics: const ScrollPhysics(),
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              child: Obx(() => Column(
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
                          Products productModel = viewModel.categoryProducts[idx];
                          return ProductItem(
                            displayFavIcon: false,
                            image: productModel.image.toString(),
                            name: productModel.name.toString(),
                            price: productModel.price.toString(),
                            rating: productModel.reviews.toString(),
                            reviews: productModel.rating.toString(),
                            previousPrice: productModel.discount.toString(),
                          );
                        },
                      ),
                    viewModel.loadMore.value ? const CustomCircularLoader() : const SizedBox()
                  ],
                ),
              ),
            ),
          ),
          const LoaderView()
        ],
      ),
    );
  }
}