import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ismmart_ecommerce/screens/product_details/product_model.dart';
import 'package:ismmart_ecommerce/screens/wishlist/wishlist_viewmodel.dart';
import 'package:ismmart_ecommerce/widgets/custom_network_image.dart';

class ProductItem extends StatelessWidget {
  final WishlistViewModel viewModel = Get.put(WishlistViewModel());

  final Product? product;
  final VoidCallback? onLike;
  final GestureTapCallback? onTap;
  final String image;
  final String? discount;
  final String name;
  final String category;
  final String price;
  final String? previousPrice;
  final String rating;
  final String reviews;
  final bool displayFavIcon;

  ProductItem({
    super.key,
    required this.image,
    this.discount,
    required this.name,
    required this.category,
    required this.price,
    this.previousPrice,
    required this.rating,
    required this.reviews,
    this.onTap,
    this.displayFavIcon = true,
    this.product,
    this.onLike,
  });

  @override
  Widget build(BuildContext context) {
    print('ProductItem id ${product?.name}');
    return InkWell(
      onTap: onTap,
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
                discount != null
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
                  Text(
                    name,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 5, bottom: 5),
                    child: Text(
                      category,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: Color(0xFF929AAB),
                        fontSize: 10,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  Text(
                    price,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: Color(0xFF24272C),
                      fontSize: 12,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  previousPrice != null
                      ? Padding(
                          padding: const EdgeInsets.only(top: 5, bottom: 10),
                          child: Text(
                            previousPrice!,
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
                        rating,
                        style: const TextStyle(
                          fontSize: 10,
                        ),
                      ),
                      const SizedBox(width: 10),
                      Text(
                        '$reviews Reviews',
                        style: const TextStyle(
                          fontSize: 10,
                        ),
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
