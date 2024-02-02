import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:ismmart_ecommerce/helpers/app_colors.dart';
import 'package:ismmart_ecommerce/helpers/theme_helper.dart';
import 'package:ismmart_ecommerce/screens/product_details/product_details_viewmodel.dart';
import 'package:ismmart_ecommerce/widgets/custom_appbar.dart';
import 'package:ismmart_ecommerce/widgets/custom_network_image.dart';
import 'package:path/path.dart';

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
      body: ListView(
        padding: EdgeInsets.zero,
        children: [
          _carousel(),
          _titlePrice(),
        ],
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
    return Column(
      children: [
        Text(
          'TMA-2HD Wireless',
          style: ThemeHelper.textTheme.headlineLarge,
        ),
      ],
    );
  }
}
