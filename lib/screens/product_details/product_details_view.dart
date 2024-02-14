import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ismmart_ecommerce/helpers/app_colors.dart';
import 'package:ismmart_ecommerce/helpers/app_strings.dart';
import 'package:ismmart_ecommerce/helpers/constants.dart';
import 'package:ismmart_ecommerce/helpers/theme_helper.dart';
import 'package:ismmart_ecommerce/screens/product_details/product_details_viewmodel.dart';
import 'package:ismmart_ecommerce/screens/product_details/product_model.dart';
import 'package:ismmart_ecommerce/screens/product_details/review_model.dart';
import 'package:ismmart_ecommerce/widgets/custom_appbar.dart';
import 'package:ismmart_ecommerce/widgets/custom_button.dart';
import 'package:ismmart_ecommerce/widgets/custom_network_image.dart';
import 'package:ismmart_ecommerce/widgets/custom_product_qty_counter.dart';
import 'package:ismmart_ecommerce/widgets/custom_profile_name_rating.dart';

class ProductDetailsView extends StatelessWidget {
  ProductDetailsView({super.key});

  final ProductDetailsViewModel viewModel = Get.put(ProductDetailsViewModel());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const CustomAppBar2(
          title: 'ISMMART',
          actions: [
            Padding(
              padding: EdgeInsets.only(right: 8.0),
              child: Icon(
                Icons.favorite_border_rounded,
                size: 20,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(right: 10.0),
              child: Icon(
                Icons.shopping_cart_outlined,
                size: 20,
              ),
            ),
          ],
        ),
        body: SingleChildScrollView(
          controller: viewModel.scrollController,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                carousel(),
                titlePrice(),
                variants(),
                kSmallDivider,
                description(),
                tabs(),
                reviewsAndRatings(),
                kSmallDivider,
                vendorStore(),
                kSmallDivider,
                peopleAlsoViewed(),
              ],
            ),
          ),
        ),
        bottomNavigationBar: bottomBar());
  }

  Widget carousel() {
    return SizedBox(
      height: Get.height * 0.35,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Obx(
          () => Stack(
            alignment: Alignment.center,
            children: [
              PageView(
                controller: viewModel.pageViewController,
                physics: const BouncingScrollPhysics(),
                onPageChanged: (value) {
                  viewModel.carouselIndex(value);
                },
                children: List.generate(
                  viewModel.productModel.value.media!.length,
                  (index) => CustomNetworkImage(
                    imageUrl: viewModel.productModel.value.media![index].url,
                    //boxFit: BoxFit.contain,
                  ),
                ),
              ),
              //Previous Button
              Positioned(
                left: 10,
                child: viewModel.carouselIndex.value <= 0
                    ? Container()
                    : previousImage(),
              ),
              //Next Button
              Positioned(
                  right: 10,
                  child: viewModel.carouselIndex.value >=
                          (viewModel.productModel.value.media!.length - 1)
                      ? Container()
                      : nextImage()),
              //Photo number indicator
              Positioned(
                bottom: 5,
                left: 10,
                child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                      color: AppColors.grey4),
                  child: Text(
                    '${(viewModel.carouselIndex.value) + 1}/${viewModel.productModel.value.media!.length} Photos',
                    style: ThemeHelper.textTheme.labelSmall!
                        .copyWith(color: AppColors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget nextImage() {
    return InkWell(
      onTap: () {
        if (viewModel.carouselIndex.value ==
            viewModel.productModel.value.media!.length - 1) {
          return;
        }

        viewModel.carouselIndex.value++;
        viewModel.pageViewController.jumpToPage(viewModel.carouselIndex.value);
      },
      child: Container(
        height: Get.height * 0.35,
        padding: const EdgeInsets.symmetric(horizontal: 5),
        decoration: const BoxDecoration(color: AppColors.transparent),
        child: const Icon(
          Icons.arrow_forward_ios,
          color: AppColors.grey5,
        ),
      ),
    );
  }

  Widget previousImage() {
    return InkWell(
      onTap: () {
        if (viewModel.carouselIndex.value <= 0) return;
        viewModel.carouselIndex.value--;
        viewModel.pageViewController.jumpToPage(viewModel.carouselIndex.value);
      },
      child: Container(
        height: Get.height * 0.35,
        padding: const EdgeInsets.symmetric(horizontal: 5),
        decoration: const BoxDecoration(color: AppColors.transparent),
        child: const Icon(
          Icons.arrow_back_ios,
          color: AppColors.grey5,
        ),
      ),
    );
  }

  Widget titlePrice() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Text(
                    viewModel.productModel.value.name ?? '',
                    style: ThemeHelper.textTheme.titleLarge,
                  ),
                ),

                //discount

                //Review section
                Row(
                  children: [
                    starWithRatings(),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15.0),
                      child: Text(
                        '${viewModel.productModel.value.totalReviews ?? 0} Reviews',
                        style: ThemeHelper.textTheme.bodySmall,
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
          Positioned(
            //width: 100,
            bottom: 0,
            right: 5,
            child: CustomProductQuantityCounter(
              textEditingController: viewModel.productQtyController,
              quantity: viewModel.qtyCount.toString(),
              onDecrementPress: () => viewModel.onQtyDecrement(),
              onIncrementPress: () => viewModel.onQtyIncrement(),
            ),
          ),
        ],
      ),
    );
  }

  Widget textTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Text(
        title,
        style: ThemeHelper.textTheme.bodyLarge,
      ),
    );
  }

  Widget starWithRatings() {
    return Row(
      children: [
        const Icon(
          Icons.star_rounded,
          color: AppColors.yellow,
          size: 16,
        ),
        Text(
          '${viewModel.productModel.value.rating ?? 0.0}',
          style: ThemeHelper.textTheme.bodySmall,
        ),
      ],
    );
  }

  Widget variants() {
    return viewModel.productModel.value.options == null
        ? Container()
        : Column(
            children: viewModel.productModel.value.options!
                .map((Option element) => variantsListItems(
                    title: element.name, variantsList: element.values))
                .toList(),
          );
  }

  Widget variantsListItems({String? title, List<String>? variantsList}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        textTitle(
          title!,
        ),
        Row(
          //mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: variantsList!.map((e) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                  //shape: BoxShape.rectangle,
                  borderRadius: const BorderRadius.all(Radius.circular(5)),
                  border: Border.all(color: AppColors.black),
                ),
                child: Text(
                  e,
                  style: ThemeHelper.textTheme.bodySmall,
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget description() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          textTitle('Description'),
          Text(
            AppStrings.productDetails,
            style: ThemeHelper.textTheme.bodyMedium,
            //textAlign: TextAlign.,
            maxLines: AppStrings.productDetails.length,
          ),
        ],
      ),
    );
  }

  Widget tabs() {
    return DefaultTabController(
        length: 3,
        child: TabBar(
          tabs: [
            InkWell(
              onTap: () {
                viewModel.scrollTo(viewModel.reviewsKey);
              },
              child: const Tab(
                text: 'Reviews',
              ),
            ),
            InkWell(
              onTap: () {
                viewModel.scrollTo(viewModel.vendorKey);
              },
              child: const Tab(
                text: 'Vendor',
              ),
            ),
            InkWell(
              onTap: () {
                viewModel.scrollTo(viewModel.similarProductKey);
              },
              child: const Tab(
                text: 'Similar Products',
              ),
            )
          ],
        ));
  }

  Widget reviewsAndRatings() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Reviews (${viewModel.reviewsList.length})',
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                starWithRatings(),
              ],
            ),
          ),
          ListView.builder(
              key: viewModel.reviewsKey,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: viewModel.reviewsList.length,
              itemBuilder: (_, index) {
                Review review = viewModel.reviewsList[index];
                return CustomProfileNameAndRating(
                  imageUrl: review.user?.image ?? '',
                  rating: review.rating?.toDouble() ?? 0,
                  name: review.user?.name,
                  description: review.description,
                );
              }),
        ],
      ),
    );
  }

  Widget vendorStore() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
        //height: Get.height * 0.15,
        key: viewModel.vendorKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            textTitle('Vendor'),
            CustomProfileNameAndRating(
              imageUrl: viewModel.productModel.value.store?.logo ?? '',
              name: viewModel.productModel.value.store?.name ?? '',
              rating: viewModel.productModel.value.store?.rating ?? 0,
            ),
            Text(
              'More Products from Techstore',
              style: ThemeHelper.textTheme.bodySmall,
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 8.0, vertical: 12),
              child: SizedBox(
                height: 40,
                child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount:
                        viewModel.productModel.value.store?.products?.length ??
                            0,
                    itemBuilder: (_, index) {
                      Product? storeProducts =
                          viewModel.productModel.value.store?.products![index];
                      return Container(
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                        child: CustomNetworkImage(
                          height: 35,
                          width: 35,
                          imageUrl: storeProducts!.image ?? '',
                        ),
                      );
                    }),
              ),
            ),
            CustomIconTextBtn(
              onPressed: () {},
              backgroundColor: AppColors.white,
              titleColor: AppColors.black,
              radius: 20,
              borderSide: const BorderSide(color: AppColors.black),
              title: 'Visit Store',
              icon: Icons.storefront,
              //backgroundColor: AppColors.white,
            ),
          ],
        ),
      ),
    );
  }

  Widget peopleAlsoViewed() {
    return SizedBox(
      height: Get.height * 0.15,
      key: viewModel.similarProductKey,
      child: const Column(
        children: [
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Text('People also Viewed'),
          ),
        ],
      ),
    );
  }

  Widget bottomBar() {
    return BottomAppBar(
      color: AppColors.white,
      elevation: 10,
      child: Padding(
        padding:
            EdgeInsets.symmetric(horizontal: Get.width * 0.22, vertical: 3),
        child: Container(
          // width: 100,
          // height: 50,
          //alignment: Alignment.center,
          padding: const EdgeInsets.symmetric(horizontal: 5),
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(50),
            boxShadow: const [
              BoxShadow(
                color: AppColors.black12,
                blurRadius: 3,
                offset: Offset(0, 0),
                spreadRadius: 0,
              )
            ],
          ),
          //color: AppColors.white,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomIconTextBtn(
                  width: 100,
                  radius: 30,
                  title: 'Add to Cart',
                  onPressed: () {},
                  icon: Icons.shopping_cart_outlined),
              Container(
                alignment: Alignment.center,
                height: 35,
                decoration: BoxDecoration(
                    color: AppColors.red700.withOpacity(0.22),
                    shape: BoxShape.circle),
                child: IconButton(
                  alignment: Alignment.center,
                  onPressed: () {},
                  icon: Icon(
                    size: 20,
                    Icons.favorite_border,
                    color: AppColors.red700,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
