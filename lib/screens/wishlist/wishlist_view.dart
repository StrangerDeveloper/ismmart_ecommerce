import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ismmart_ecommerce/screens/wishlist/wishlist_viewModel.dart';
import 'package:ismmart_ecommerce/widgets/custom_text.dart';

import '../../widgets/custom_appbar.dart';
import '../../widgets/product_item.dart';

class WishlistView extends StatelessWidget {
  final WishlistViewModel viewModel = Get.put(WishlistViewModel());
  WishlistView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: "Wishlist",
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
          ),
        ),
        action: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.favorite_border_sharp,
              color: Colors.black,
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.shopping_cart_outlined,
              color: Colors.black,
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 20),
              child: Align(
                alignment: Alignment.centerLeft,
                child: CustomText(
                  title: '6 items',
                  size: 16,
                  weight: FontWeight.bold,
                ),
              ),
            ),
            Container(
              child: flashSaleProductList(),
            ),
          ],
        ),
      ),
    );
  }

  Widget flashSaleProductList() {
    return GridView.builder(
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.symmetric(horizontal: 16),
      shrinkWrap: true,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 8,
        crossAxisSpacing: 25,
        childAspectRatio: 0.6,
      ),
      itemCount: viewModel.categoriesList.length,
      itemBuilder: (context, index) {
        return ProductItem(
          onTap: () {},
          image: '',
          name: 'Product Name',
          category: 'Category',
          price: 'Rs 1000',
          rating: '4.6',
          reviews: '46',
          previousPrice: 'Rs 1500',
        );
      },
    );
  }
}
