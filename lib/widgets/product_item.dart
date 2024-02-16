import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ismmart_ecommerce/helpers/app_routes.dart';
import '../screens/wishlist/wishlist_viewModel.dart';
import '../widgets/custom_network_image.dart';
import '../helpers/app_colors.dart';
import '../helpers/common_function.dart';
import '../helpers/theme_helper.dart';
import '../screens/product_details/model/product_model.dart';

class ProductItem2 extends StatelessWidget {
  final WishlistViewModel viewModel = Get.put(WishlistViewModel());

  final Product? product;
  final GestureTapCallback? onTap;
  final String image;
  final num discount;
  final String name;
  final String? category;
  final num price;
  final num rating;
  final num reviews;
  final bool displayFavIcon;

  ProductItem2({
    super.key,
    required this.image,
    required this.discount,
    required this.name,
    this.category,
    required this.price,
    this.rating = 0.0,
    this.reviews = 0,
    this.onTap,
    this.displayFavIcon = true,
    this.product,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap ??
          () {  
            Get.toNamed(AppRoutes.productDetailsRoute, arguments: {'productId': product?.id ?? ''});
          },
      borderRadius: BorderRadius.circular(10),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: const [
            BoxShadow(
              color: Color(0x0C000000),
              blurRadius: 3,
              offset: Offset(0, 1),
              spreadRadius: 0,
            )
          ],
        ),
        child: Column(
          children: [
            Stack(
              alignment: Alignment.bottomLeft,
              children: [
                CustomNetworkImage(
                  height: 130,
                  boxFit: BoxFit.fill,
                  imageUrl: image,
                ),
                discount != 0
                    ? Container(
                        margin: const EdgeInsets.all(8),
                        padding: const EdgeInsets.symmetric(
                            vertical: 5, horizontal: 8),
                        decoration: BoxDecoration(
                          color: const Color(0xFFFE3A30),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text(
                          '$discount % OFF',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 10,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      )
                    : const SizedBox(),
                displayFavIcon
                    ? Positioned(
                        top: 1,
                        left: 1,
                        child: Obx(
                          () => IconButton(
                            icon: Icon(
                              viewModel.wishlist.contains(product)
                                  ? Icons.favorite
                                  : Icons.favorite_border,
                              color: viewModel.wishlist.contains(product)
                                  ? Colors.red
                                  : Colors.black,
                            ),
                            onPressed: () {
                              if (viewModel.wishlist.contains(product)) {
                                viewModel.removeFromWishlist(product!);
                              } else {
                                viewModel.addToWishlist(product!);
                              }
                            },
                          ),
                        ),
                      )
                    : const SizedBox()
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(name,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: ThemeHelper.textTheme.bodyMedium?.copyWith(
                          color: AppColors.black3, fontWeight: FontWeight.w600
                          // fontWeight:
                          )),
                  Padding(
                    padding: const EdgeInsets.only(top: 5, bottom: 5),
                    child: category == null
                        ? const SizedBox()
                        : Text(
                            category!,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              color: Color(0xFF929AAB),
                              fontSize: 10,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                  ),
                  //current-price
                  Text(
                    (discount != 0)
                        ? 'Rs ${CommonFunction.calculatePercentage2(price, discount)}'
                        : 'Rs $price',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: Color(0xFF24272C),
                      fontSize: 12,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  //previous-price
                  discount != 0
                      ? Padding(
                          padding: const EdgeInsets.only(top: 5, bottom: 10),
                          child: Text(
                            'Rs $price',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              color: Color(0xFFFE3A30),
                              fontSize: 10,
                              fontWeight: FontWeight.w900,
                              decoration: TextDecoration.lineThrough,
                            ),
                          ),
                        )
                      : const SizedBox(),
                  Row(
                    children: [
                      const Icon(
                        Icons.star,
                        color: Color(0xffFFC120),
                        size: 12,
                      ),
                      Text(
                        rating.toString(),
                        style: ThemeHelper.textTheme.bodySmall
                            ?.copyWith(fontSize: 10, color: AppColors.black3),
                      ),
                      const SizedBox(width: 10),
                      Text(
                        '$reviews Reviews',
                        style: ThemeHelper.textTheme.bodySmall
                            ?.copyWith(fontSize: 10, color: AppColors.black3),
                      ),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
