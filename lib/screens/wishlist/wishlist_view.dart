import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'wishlist_viewmodel.dart';
import '../../widgets/custom_text.dart';
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
              child: wishListProducts(),
            ),
          ],
        ),
      ),
    );
  }

  Widget wishListProducts() {
    return Obx(
      () => viewModel.wishlist.isNotEmpty
          ? GridView.builder(
              physics: const NeverScrollableScrollPhysics(),
              padding: const EdgeInsets.symmetric(horizontal: 16),
              shrinkWrap: true,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 8,
                crossAxisSpacing: 25,
                childAspectRatio: 0.6,
              ),
              itemCount: viewModel.wishlist.length,
              itemBuilder: (context, index) {
                return ProductItem2(
                  product: viewModel.wishlist[index],
                  onTap: () {},
                  image: viewModel.wishlist[index].image ?? '',
                  name: viewModel.wishlist[index].name ?? '',
                  category: "Electronics",
                  price: viewModel.wishlist[index].price ?? 0,
                  rating: 4.5,
                  reviews: 10,
                  discount: 10,
                );
              },
            )
          : const Center(
              child: CustomText(
                title: 'No items in wishlist',
                size: 16,
                weight: FontWeight.bold,
              ),
            ),
    );
  }
}
