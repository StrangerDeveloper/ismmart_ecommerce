import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ismmart_ecommerce/helpers/app_colors.dart';
import 'package:ismmart_ecommerce/helpers/global_variables.dart';
import 'package:ismmart_ecommerce/helpers/theme_helper.dart';
import 'package:ismmart_ecommerce/screens/vendor_store/vendor_store_all_products.dart';
import 'package:ismmart_ecommerce/screens/vendor_store/vendor_store_homepage.dart';
import 'package:ismmart_ecommerce/screens/vendor_store/vendor_store_viewmodel.dart';
import 'package:ismmart_ecommerce/widgets/custom_appbar.dart';
import 'package:ismmart_ecommerce/widgets/custom_network_image.dart';
import 'package:ismmart_ecommerce/widgets/loader_view.dart';

import 'categorized_products_model.dart';
import '../../widgets/product_item.dart';
import 'category_products/category_products_view.dart';

class VendorStoreView extends StatelessWidget {
  VendorStoreView({super.key});

  final VendorStoreViewModel viewModel = Get.put(VendorStoreViewModel());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar2(
        title: 'Vendor Store',
        centerTitle: true,
        containsLeading: true,
        titleTextStyle: ThemeHelper.textTheme.bodyLarge!.copyWith(
          color: AppColors.black3
        )
      ),
      body: Obx(() => GlobalVariable.showLoader.value ? const LoaderView() : Padding(
          padding: const EdgeInsets.only(top: 25.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.grey2.withOpacity(0.1),
                      blurRadius: 15,
                      spreadRadius: 8,
                      offset: const Offset(0, 8)
                    )
                  ]
                ),
                child: Obx(() => CircleAvatar(
                    radius: 40,
                    backgroundColor: Colors.transparent,
                    backgroundImage: viewModel.storeLogoUrl.value != '' ? null : const AssetImage('assets/images/no_image_found.jpg'),
                    child: viewModel.storeLogoUrl.value != '' ? CustomNetworkImage(imageUrl: viewModel.storeLogoUrl.value) : const SizedBox()),
                  ),
                ),
              const SizedBox(height: 20,),
              Obx(() => Text(
                  viewModel.storeName.value,
                  style: ThemeHelper.textTheme.bodyLarge?.copyWith(
                    color: AppColors.black,
                    fontWeight: FontWeight.w700
                  )
                ),
              ),
              const SizedBox(height: 15,),
              TabBar(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                controller: viewModel.tabController,
                labelColor: AppColors.black,
                labelStyle: ThemeHelper.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w600),
                enableFeedback: false,
                unselectedLabelColor: AppColors.grey5,
                unselectedLabelStyle: GoogleFonts.inter(fontWeight: FontWeight.w400, fontSize: 14),
                indicatorColor: Colors.black,
                  indicatorWeight: 1.5,
                  tabs: const [
                    Tab(text: 'Homepage',),
                    Tab(text: 'All Products')
              ]
              ),
              Expanded(
                child: TabBarView(
                  controller: viewModel.tabController,
                    children: [
                      VendorStoreHomePage(),
                      VendorStoreAllProducts(),
                ]),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget categoryAndProductsList({int? limit, required List<CategorizedProductsModel> productList}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Obx(() => Column(
            children: viewModel.productsRetryCheck.value ? [
              IconButton(
                  onPressed: () {
                    viewModel.productsRetryCheck.value = false;
                    viewModel.getVendorProducts();
                  }, icon: const Icon(
                Icons.refresh_rounded,
                size: 22,
                color: AppColors.black,
              ),
              ),
              Text(
                'Error fetching products. Retry',
                style: ThemeHelper.textTheme.bodyMedium?.copyWith(
                  color: AppColors.black,
                  fontSize: 15
                )
              )
            ] : productList.isEmpty ? [
            Center(
                  child: Text(
                    'No Products Found',
                    style: ThemeHelper.textTheme.bodyMedium?.copyWith(
                        color: AppColors.black,
                        fontSize: 15
                    )
                  ),
            )] : List.generate(limit ?? productList.length, (index) {
              CategorizedProductsModel model = productList[index];
              return model.products != null && model.products!.isNotEmpty ? Column(
                  children: [
                    categoryNameAndBtn(model.name == null && model.name == '' ? 'Others' : model.name.toString(), categoryId: model.sId ?? ''),
                    GridView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisSpacing: 12,
                          crossAxisSpacing: 15,
                          childAspectRatio: 0.64,
                        ),
                        itemCount: model.products!.length,
                        itemBuilder: (context, idx) {
                          Products productModel = model.products![idx];
                          return ProductItem2(
                            displayFavIcon: false,
                            image: productModel.image.toString(),
                            name: productModel.name.toString(),
                            price: productModel.price ?? 0,
                            rating: productModel.rating ?? 0,
                            reviews: productModel.reviews ?? 0,
                            discount: productModel.discount != null ? productModel.discount!.percentage! : 0,
                          );
                        },
                      ),
                  ],
                ) : const SizedBox();
            }),
          ),
      ),
      );
  }

  Widget categoryNameAndBtn(String categoryName, {String? categoryId, bool displaySeeAllBtn = true}) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0, bottom: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            categoryName,
            style: GoogleFonts.inter(
                color: AppColors.black3,
                fontSize: 14,
                fontWeight: FontWeight.w700
            ),
          ),
          displaySeeAllBtn ? TextButton(
              onPressed: () {
                Get.to(() => CategoryProductsView(), arguments: {'id': categoryId, 'name': categoryName});
              },
              child: Text(
                'See all',
                style: ThemeHelper.textTheme.bodyMedium?.copyWith(
                    color: AppColors.black3,
                    fontWeight: FontWeight.w400
                )
              )
          ) : const SizedBox()
        ],
      ),
    );
  }
}