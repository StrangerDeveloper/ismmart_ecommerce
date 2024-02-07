import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ismmart_ecommerce/helpers/app_colors.dart';
import 'package:ismmart_ecommerce/screens/vendor_store/models/popular_product_model.dart';
import 'package:ismmart_ecommerce/screens/vendor_store/vendor_store_view.dart';
import 'package:ismmart_ecommerce/screens/vendor_store/vendor_store_viewmodel.dart';
import 'package:ismmart_ecommerce/widgets/custom_button.dart';
import 'package:ismmart_ecommerce/widgets/custom_network_image.dart';

class VendorStoreHomePage extends StatelessWidget {
  VendorStoreHomePage({super.key});

  final VendorStoreViewModel viewModel = Get.find();
  final VendorStoreView view = VendorStoreView();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 10, bottom: 20),
      width: Get.width,
      height: Get.height,
      color: Colors.white,
      child: SingleChildScrollView(
        physics: const ScrollPhysics(),
        child: Column(
          children: [
            sliderContainer(),
            categoriesList(),
            view.categoryAndProductsList(),
          ],
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
          Obx(() => viewModel.noSliderImages.value ? Center(
            child: Text(
              'No Popular Products',
              style: GoogleFonts.inter(
                color: AppColors.black3,
                fontWeight: FontWeight.w500,
                fontSize: 14
              ),
            ),
          ) : viewModel.isSliderLoading.isTrue
            ? const Center(
              child: SizedBox(
                height: 40,
                width: 40,
                child: CircularProgressIndicator(
                  strokeWidth: 1.5,
                  color: Colors.black,
                ),
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
                  PopularProductModel model = viewModel.sliderImages[index];
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 75,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CachedNetworkImage(
                              height: 75,
                              width: 140,
                              imageUrl: model.media.toString(),
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
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Popular',
                                      style: GoogleFonts.inter(
                                        fontSize: 10,
                                        fontWeight: FontWeight.w400
                                      ),
                                    ),
                                    const SizedBox(height: 2,),
                                    Text(
                                      model.name.toString(),
                                      style: GoogleFonts.inter(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w600
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
                },
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
          vertical: 10
      ),
      child: Obx(() => viewModel.noCategoriesFound.value ? Center(
        child: Text(
          'No Categories Found',
          style: GoogleFonts.inter(
            color: AppColors.black3,
            fontSize: 14,
            fontWeight: FontWeight.w500
          ),
        ),
      ): viewModel.fetchingCategories.value ? const Center(
        child: CircularProgressIndicator(
          color: AppColors.black,
          strokeWidth: 2.5,
        ),
      ) : Column(
          children: [
            view.categoryNameAndBtn('Categories'),
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
                                style: GoogleFonts.inter(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w400
                                ),
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