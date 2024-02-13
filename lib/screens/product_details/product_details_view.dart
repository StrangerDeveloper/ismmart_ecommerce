import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:ismmart_ecommerce/helpers/app_colors.dart';
import 'package:ismmart_ecommerce/helpers/app_strings.dart';
import 'package:ismmart_ecommerce/helpers/constants.dart';
import 'package:ismmart_ecommerce/helpers/theme_helper.dart';
import 'package:ismmart_ecommerce/screens/product_details/product_details_viewmodel.dart';
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
          Icon(
            Icons.favorite_border_rounded,
            size: 20,
          ),
          Gap(10),
          Icon(
            Icons.shopping_cart_outlined,
            size: 20,
          ),
          Gap(12),
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
      bottomNavigationBar: BottomAppBar(
        child: Container(
          ///height: 60,
          color: AppColors.white38,
          child: Container(
            // alignment: Alignment.bottomCenter,
            width: 200,
            decoration: BoxDecoration(
              //color: AppColors.yellow,
              borderRadius: BorderRadius.circular(20),
              boxShadow: const [
                BoxShadow(
                  color: AppColors.blackShadow,
                  blurRadius: 3,
                  offset: Offset(0, 1),
                  spreadRadius: 0,
                )
              ],
            ),
            //color: AppColors.white,
            child: Row(
              children: [
                CustomIconTextBtn(
                    radius: 20,
                    title: 'Add to Cart',
                    onPressed: () {},
                    icon: Icons.shopping_cart_outlined),
                Container(
                  height: 40,
                  decoration: BoxDecoration(
                      color: AppColors.red700.withOpacity(0.22),
                      shape: BoxShape.circle),
                  child: IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.favorite_border,
                      color: AppColors.red700,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
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
              SvgPicture.asset('assets/images/sale_percent.svg'),
              PageView(
                controller: viewModel.pageViewController,
                physics: const BouncingScrollPhysics(),
                onPageChanged: (value) {
                  viewModel.carouselIndex(value);
                },
                children: List.generate(
                  viewModel.carouselList.length,
                  (index) => CustomNetworkImage(
                    imageUrl: viewModel.carouselList[index],
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
                          (viewModel.carouselList.length - 1)
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
                    '${(viewModel.carouselIndex.value) + 1}/${viewModel.carouselList.length} Photos',
                    style: const TextStyle(color: AppColors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  nextImage() {
    return InkWell(
      onTap: () {
        if (viewModel.carouselIndex.value ==
            viewModel.carouselList.length - 1) {
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

  previousImage() {
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
                Text(
                  'TMA-2HD Wireless',
                  style: ThemeHelper.textTheme.titleMedium,
                ),
                const Gap(10),
                Text(
                  'RS 1500.0',
                  style: ThemeHelper.textTheme.bodySmall!
                      .copyWith(color: AppColors.red),
                ),
                const Gap(5),
                //Review section
                Row(
                  children: [
                    starWithRatings(),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15.0),
                      child: Text(
                        '86 Reviews',
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
              onDecrementPress: () {},
              onIncrementPress: () {},
            ),
          ),
        ],
      ),
    );
  }

  Widget starWithRatings() {
    return Row(
      children: [
        const Icon(
          Icons.star,
          color: AppColors.yellow,
          size: 16,
        ),
        Text(
          '4.6',
          style: ThemeHelper.textTheme.bodySmall,
        ),
      ],
    );
  }

  Widget variants() {
    return Column(
      children: viewModel.variantsMap.entries
          .map((element) => variantsListItems(
              title: element.key, variantsList: element.value))
          .toList(),
    );
  }

  Widget variantsListItems({String? title, List<String>? variantsList}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title!,
          style: ThemeHelper.textTheme.bodyMedium,
        ),
        Row(
          //mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: variantsList!.map((e) {
            return Padding(
              padding: const EdgeInsets.all(5.0),
              child: Container(
                padding: const EdgeInsets.all(5),
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
          const Text(
            'Description',
            style: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.w800,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Text(
              AppStrings.productDetails,
              textAlign: TextAlign.justify,
              maxLines: AppStrings.productDetails.length,
            ),
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
            padding: const EdgeInsets.symmetric(
              vertical: 20.0,
            ),
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
                var data = viewModel.reviewsList[index];
                return CustomProfileNameAndRating(
                  imageUrl: data['profileImage'],
                  rating: data['rating'],
                  name: data['name'],
                  description: data['reviews'],
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
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 16),
              child: Text(
                'Vendor',
                style: TextStyle(
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
            CustomProfileNameAndRating(
              imageUrl: AppStrings.profileImage,
              name: 'Tech Store',
              rating: 3.3,
            ),
            const Text('More Products from Techstore'),
            const Gap(15),
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
}
