import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ismmart_ecommerce/screens/wishlist/wishlist_viewModel.dart';
import '../../widgets/custom_text.dart';
import '../../widgets/custom_appbar.dart';
import '../../widgets/product_item.dart';

class WishlistView extends StatelessWidget {
  final WishlistViewModel viewModel = Get.put(WishlistViewModel());

  static int count = 0;
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
              Icons.shopping_cart_outlined,
              color: Colors.black,
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Obx(
                  () => CustomText(
                    title: '${viewModel.totalItems} items',
                    size: 16,
                    weight: FontWeight.bold,
                  ),
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
                count = viewModel.wishlist.length;
                return ProductItem2(
                  product: viewModel.wishlist[index],
                  //onTap: () {},
                  image: viewModel.wishlist[index].image ?? '',
                  name: viewModel.wishlist[index].name ?? '',
                  category: viewModel.wishlist[index].store?.name ?? '',
                  price: viewModel.wishlist[index].price ?? 0,
                  rating: viewModel.wishlist[index].rating ?? 0,
                  reviews: viewModel.wishlist[index].totalReviews ?? 0,
                  discount: viewModel.wishlist[index].discount?.percentage ?? 0,
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
