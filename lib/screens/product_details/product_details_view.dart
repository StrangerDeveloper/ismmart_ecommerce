import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:ismmart_ecommerce/helpers/app_colors.dart';
import 'package:ismmart_ecommerce/helpers/app_strings.dart';
import 'package:ismmart_ecommerce/helpers/theme_helper.dart';
import 'package:ismmart_ecommerce/screens/product_details/product_details_viewmodel.dart';
import 'package:ismmart_ecommerce/widgets/custom_appbar.dart';
import 'package:ismmart_ecommerce/widgets/custom_network_image.dart';
import 'package:ismmart_ecommerce/widgets/custom_product_qty_counter.dart';
import 'package:ismmart_ecommerce/widgets/review_item.dart';

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
              _carousel(),
              _titlePrice(),
              _variants(),
              const Divider(
                color: AppColors.black12,
                height: 1,
                indent: 10,
              ),
              _description(),
              _tabs(),
              
              
              Container(
                height: 100,
                key: viewModel.reviewsKey,
                color: Colors.black,
                child: const SizedBox(
                  height: 100,
                ),
              ),

              Container(
                height: 100,
                key: viewModel.vendorKey,
                color: Colors.black,
                child: const SizedBox(
                  height: 100,
                ),
              ),
              Container(
                height: 100,
                key: viewModel.similarProductKey,
                color: Colors.green,
                child: const SizedBox(
                  height: 100,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _carousel() {
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

  Widget _titlePrice() {
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
                    const Icon(
                      Icons.star,
                      color: AppColors.yellow,
                      size: 16,
                    ),
                    Text(
                      '4.6',
                      style: ThemeHelper.textTheme.bodySmall,
                    ),
                    const Gap(8),
                    Text(
                      '86 Reviews',
                      style: ThemeHelper.textTheme.bodySmall,
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

  Widget _variants() {
    return Column(
      children: viewModel.variantsMap.entries
          .map((element) => _variantsListItems(
              title: element.key, variantsList: element.value))
          .toList(),
    );
  }

  Widget _variantsListItems({String? title, List<String>? variantsList}) {
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

  Widget _description() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Text(
          'Description',
          style: ThemeHelper.textTheme.titleSmall,
        ),
        Text(
          AppStrings.productDetails,
          maxLines: AppStrings.productDetails.length,
        ),
      ],
    );
  }

  Widget _tabs() {
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

  Widget _ratings() {
    return ListView.builder(
        key: viewModel.reviewsKey,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: viewModel.reviewsList.length,
        itemBuilder: (_, index) {
          var data = viewModel.reviewsList[index];
          return ReviewItem(
              profileImage: data['profileImage'],
              duration: data['duration'],
              name: data['name'],
              rating: data['rating'] as double,
              reviews: data['reviews'],
              images: data['images']);
        });
  }
}
