import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ismmart_ecommerce/helpers/app_colors.dart';
import 'package:ismmart_ecommerce/helpers/theme_helper.dart';
import 'package:ismmart_ecommerce/screens/vendor_store/categorized_products_model.dart';
import 'package:ismmart_ecommerce/screens/vendor_store/vendor_store_view.dart';
import 'package:ismmart_ecommerce/screens/vendor_store/vendor_store_viewmodel.dart';
import 'package:ismmart_ecommerce/widgets/circular_progress_bar.dart';
import 'package:ismmart_ecommerce/widgets/custom_button.dart';
import 'package:ismmart_ecommerce/widgets/custom_network_image.dart';

class VendorStoreHomePage extends StatelessWidget {
  VendorStoreHomePage({super.key});

  final VendorStoreViewModel viewModel = Get.find();
  final VendorStoreView view = VendorStoreView();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10, bottom: 20),
      child:
      Obx(() => viewModel.fetchingProducts.isFalse && viewModel.homePageProductsList.isEmpty ? LayoutBuilder(
        builder: (context, constraints) {
          return SizedBox(
            height: constraints.maxHeight,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  sliderContainer(),
                  categoriesList(),
                  Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          view.categoryAndProductsList(limit: viewModel.homePageProductsList.length < 3 ? viewModel.homePageProductsList.length : 3, productList: viewModel.homePageProductsList),
                    ],
                  ),
                  ),
                ],
              ),
          );
        }
      ) :
      SingleChildScrollView(
          physics: const ScrollPhysics(),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            mainAxisSize: MainAxisSize.max,
            children: [
              sliderContainer(),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: viewModel.fetchingProducts.isFalse && viewModel.fetchingCategories.isFalse ? [
                  categoriesList(),
                  Obx(() => view.categoryAndProductsList(limit: viewModel.homePageProductsList.length < 3 ? viewModel.homePageProductsList.length : 3, productList: viewModel.homePageProductsList)),
                ] : [
                  const CustomCircularLoader()
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget sliderContainer() {
    return Container(
      width: Get.width,
      height: 110,
      margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: AppColors.grey2.withOpacity(0.2),
            blurRadius: 15,
            spreadRadius: 8,
            offset: const Offset(0, 9),
          ),
        ],
        borderRadius: BorderRadius.circular(12),
      ),
      padding: const EdgeInsets.only(top: 5, left: 8, right: 8),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Obx(() => viewModel.isSliderLoading.isTrue
            ? const Center(
              child: SizedBox(
                height: 40,
                width: 40,
                child: CircularProgressIndicator(
                  strokeWidth: 1.5,
                  color: Colors.black,
                ),
              ),
            ) : viewModel.sliderImages.isEmpty ? Center(
            child: Text(
              'No Popular Products',
              style: ThemeHelper.textTheme.bodyMedium?.copyWith(
                color: AppColors.black3
              )
            ),
          ) : SizedBox(
            height: 75,
              child: PageView.builder(
                    controller: viewModel.sliderImagesController,
                    onPageChanged: (value) {
                      viewModel.sliderIndex(value);
                    },
                    itemCount: viewModel.sliderImages.length,
                    itemBuilder: (context, index) {
                      Products model = viewModel.sliderImages[index];
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: 75,
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CachedNetworkImage(
                                  height: 75,
                                  width: 140,
                                  imageUrl: model.image.toString(),
                                  imageBuilder: (context, imageProvider) {
                                    return Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(8),
                                        image: DecorationImage(
                                          image: imageProvider,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    );
                                  },
                                  errorWidget: (context, url, error) {
                                    return Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(8),
                                        image: const DecorationImage(
                                          image: AssetImage('assets/images/no_image_found.jpg'),
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    );
                                  },
                                  placeholder: (context, url) {
                                    return const Center(
                                      child: CircularProgressIndicator(strokeWidth: 0.5),
                                    );
                                  },
                                ),
                                const SizedBox(width: 25,),
                                Column(
                                  // mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Column(
                                      mainAxisSize: MainAxisSize.min,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Popular',
                                          style: ThemeHelper.textTheme.bodySmall!.copyWith(
                                            color: AppColors.black,
                                            fontSize: 10
                                          )
                                          ),
                                        const SizedBox(height: 2,),
                                        SizedBox(
                                          width: 140,
                                          child: Text(
                                                    model.name.toString(),
                                                    style: ThemeHelper.textTheme.bodySmall!.copyWith(
                                                      fontSize: 12,
                                                      fontWeight: FontWeight.w600,
                                                      color: AppColors.black,
                                                      overflow: TextOverflow.ellipsis
                                                    ),
                                          ),
                                        )
                                      ],
                                    ),
                                    CustomTextBtn2(
                                        onPressed: () {},
                                      width: 70,
                                      height: 30,
                                      title: 'Buy Now',
                                      textStyle: GoogleFonts.inter(
                                        fontSize: 11,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.white
                                      ),
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      );
                }
              ),
            ),
              ),
          Obx(() => viewModel.isSliderLoading.isTrue ? const SizedBox() : Padding(
              padding: const EdgeInsets.only(top: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  viewModel.sliderImages.length,
                      (index) => AnimatedContainer(
                    duration: const Duration(milliseconds: 400),
                    height: 6.0,
                    width: 6,
                    margin: const EdgeInsets.only(right: 3),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: viewModel.sliderIndex.value == index
                          ? Colors.black
                          : Colors.grey,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      )
    );
  }
  
  Widget categoriesList() {
    return Padding(
      padding: const EdgeInsets.symmetric(
          horizontal: 15,
          // vertical: 10
      ),
      child: Obx(() => viewModel.categoriesList.isEmpty ? Center(
        child: Text(
          'No Categories Found',
          style: ThemeHelper.textTheme.bodyMedium?.copyWith(
              color: AppColors.black3
          )
        ),
      ) : Column(
        mainAxisAlignment: MainAxisAlignment.center,
          children: [
            view.categoryNameAndBtn('Categories', displaySeeAllBtn: false),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              physics: const ScrollPhysics(),
              child: Row(
                children: List.generate(
                    viewModel.categoriesList.length,
                        (index) {
                        return Padding(
                          padding: const EdgeInsets.only(right: 15.0),
                          child: Column(
                            children: [
                              CustomNetworkImage(
                                  imageUrl: viewModel.categoriesList[index].media?[0].toString(),
                                shape: BoxShape.circle,
                                height: 70,
                                width: 70,
                              ),
                              const SizedBox(height: 15,),
                              Text(
                                viewModel.categoriesList[index].name.toString(),
                                style: ThemeHelper.textTheme.bodySmall?.copyWith(
                                  color: AppColors.black3
                                )
                              )
                            ],
                          ),
                        );
                    }),
              ),
            ),
          ],
        ),
      )
    );
  }
}