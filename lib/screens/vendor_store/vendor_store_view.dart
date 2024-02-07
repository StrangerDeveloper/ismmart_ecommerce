import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ismmart_ecommerce/helpers/app_colors.dart';
import 'package:ismmart_ecommerce/screens/vendor_store/category_products_view/category_products_view.dart';
import 'package:ismmart_ecommerce/screens/vendor_store/vendor_store_all_products.dart';
import 'package:ismmart_ecommerce/screens/vendor_store/vendor_store_homepage.dart';
import 'package:ismmart_ecommerce/screens/vendor_store/vendor_store_viewmodel.dart';
import 'package:ismmart_ecommerce/widgets/custom_appbar.dart';

import 'models/categorized_products_model.dart';
import '../../widgets/product_item.dart';

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
        titleTextStyle: GoogleFonts.inter(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: Colors.black
        ),
      ),
      body: Padding(
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
              child: const CircleAvatar(
                radius: 40,
                backgroundImage: AssetImage('assets/images/no_image_found.jpg'),
              ),
            ),
            const SizedBox(height: 20,),
            Text(
              'A2Z Store',
              style: GoogleFonts.inter(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Colors.black
              ),
            ),
            const SizedBox(height: 15,),
            TabBar(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              controller: viewModel.tabController,
              labelStyle: GoogleFonts.inter(fontWeight: FontWeight.w500, fontSize: 14, color: Colors.black),
              enableFeedback: false,
              unselectedLabelColor: AppColors.grey5,
              unselectedLabelStyle: GoogleFonts.inter(fontWeight: FontWeight.w500, fontSize: 14),
              indicatorColor: Colors.black,
                indicatorWeight: 1.5,
                tabs: [
                  Tab(child: Text('Homepage', style: GoogleFonts.inter(fontWeight: FontWeight.w500, fontSize: 14),),),
                  Tab(child: Text('All Products', style: GoogleFonts.inter(fontWeight: FontWeight.w500, fontSize: 14),),)
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
    );
  }

  Widget categoryAndProductsList() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Column(
        children: List.generate(viewModel.lists.length, (index) {
          CategorizedProductsModel model = viewModel.lists[index];
          return Column(
            children: [
              categoryNameAndBtn(model.categoryName.toString()),
              GridView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 12,
                  crossAxisSpacing: 15,
                  childAspectRatio: 0.64,
                ),
                itemCount: 2,
                itemBuilder: (context, idx) {
                  Product productModel = model.productList![idx];
                  return ProductItem(
                    displayFavIcon: false,
                    image: productModel.imageURL.toString(),
                    name: productModel.name.toString(),
                    category: model.categoryName.toString(),
                    price: productModel.actualPrice.toString(),
                    rating: productModel.reviewStar.toString(),
                    reviews: productModel.reviewsNumber.toString(),
                    previousPrice: productModel.discountedPrice.toString(),
                  );
                },
              ),
            ],
          );
        }),
      ),
    );
  }

  Widget categoryNameAndBtn(String categoryName) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0, bottom: 15),
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
          TextButton(
              onPressed: () {
                Get.to(() => CategoryProductsView());
              },
              child: Text(
                'See all',
                style: GoogleFonts.inter(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: AppColors.black3
                ),
              )
          )
        ],
      ),
    );
  }
}
