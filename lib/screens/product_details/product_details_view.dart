import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:ismmart_ecommerce/helpers/app_colors.dart';
import 'package:ismmart_ecommerce/helpers/app_routes.dart';
import 'package:ismmart_ecommerce/helpers/app_strings.dart';
import 'package:ismmart_ecommerce/helpers/common_function.dart';
import 'package:ismmart_ecommerce/helpers/constants.dart';
import 'package:ismmart_ecommerce/helpers/global_variables.dart';
import 'package:ismmart_ecommerce/helpers/theme_helper.dart';
import 'package:ismmart_ecommerce/screens/product_details/product_details_viewmodel.dart';
import 'package:ismmart_ecommerce/screens/product_details/model/product_model.dart';
import 'package:ismmart_ecommerce/screens/product_details/model/review_model.dart';
import 'package:ismmart_ecommerce/widgets/custom_appbar.dart';
import 'package:ismmart_ecommerce/widgets/custom_button.dart';
import 'package:ismmart_ecommerce/widgets/custom_network_image.dart';
import 'package:ismmart_ecommerce/widgets/custom_product_qty_counter.dart';
import 'package:ismmart_ecommerce/widgets/custom_profile_name_rating.dart';
import 'package:ismmart_ecommerce/widgets/loader_view.dart';
import 'package:ismmart_ecommerce/widgets/product_item.dart';

class ProductDetailsView extends StatelessWidget {
  ProductDetailsView({super.key});

  final ProductDetailsViewModel viewModel = Get.put(ProductDetailsViewModel());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const CustomAppBar2(
          title: 'ISMMART',
          containsLeading: true,
          actions: [
            Padding(
              padding: EdgeInsets.only(right: 12.0),
              child: Icon(
                Icons.favorite_border_rounded,
                size: 20,
                color: AppColors.black,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(right: 15.0),
              child: Icon(
                Icons.shopping_cart_outlined,
                size: 20,
                color: AppColors.black,
              ),
            ),
          ],
        ),
        body: Stack(
          alignment: Alignment.center,
          children: [
            SingleChildScrollView(
              controller: viewModel.scrollController,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Obx(
                  () => GlobalVariable.showLoader.isTrue ||
                          viewModel.productModel.value.id == null
                      ? noDataFound()
                      : Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
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
            ),
            const LoaderView(),
          ],
        ),
        bottomNavigationBar: bottomBar());
  }

  Widget noDataFound() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.red700,
            ),
            child: const Icon(
              Icons.close,
              size: 15,
              color: AppColors.white,
            )),
        Text(
          'No product found',
          style: ThemeHelper.textTheme.titleSmall,
        ),
      ],
    );
  }

  Widget carousel() {
    return SizedBox(
      height: Get.height * 0.35,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Obx(
          () => viewModel.productModel.value.media == null
              ? const CustomNetworkImage(imageUrl: '')
              : Stack(
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
                          imageUrl:
                              viewModel.productModel.value.media![index].url,
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
                          '${viewModel.getCurrentMediaIndex()}/${viewModel.productModel.value.media!.length} Photos',
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
    print("Discount: ${viewModel.productModel.value.discount?.toJson()}");
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 2.0, horizontal: 5.0),
                child: Text(
                  viewModel.productModel.value.name ?? 'N/A',
                  style: ThemeHelper.textTheme.titleLarge,
                ),
              ),

              //discount
              viewModel.productModel.value.discount == null
                  ? Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 2.0, horizontal: 5.0),
                      child: Text(
                        'Rs ${viewModel.productModel.value.price ?? 0.0}',
                        style: ThemeHelper.textTheme.labelLarge!.copyWith(
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    )
                  : discountWidget(),

              //Review section
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 2.0, horizontal: 5.0),
                child: Row(
                  children: [
                    starWithRatings(),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15.0),
                      child: Text(
                        '${viewModel.productModel.value.totalReviews ?? 0} Reviews',
                        style: ThemeHelper.textTheme.labelMedium,
                      ),
                    ),
                  ],
                ),
              )
            ],
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

  Widget discountWidget() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4.0),
      child: Row(
        children: [
          Column(
            children: [
              Text(
                'Rs ${CommonFunction.calculatePercentage2(viewModel.productModel.value.price!, viewModel.productModel.value.discount!.percentage!)}',
                style: ThemeHelper.textTheme.labelLarge!.copyWith(
                  fontWeight: FontWeight.w700,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: Text(
                  'Rs ${viewModel.productModel.value.price ?? 0.0}',
                  style: ThemeHelper.textTheme.bodyLarge!.copyWith(
                      decoration: TextDecoration.lineThrough,
                      fontWeight: FontWeight.w600,
                      color: AppColors.red),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: Container(
              padding: const EdgeInsets.all(7),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: AppColors.red,
              ),
              child: Text(
                '10% OFF',
                style: ThemeHelper.textTheme.bodySmall!.copyWith(
                  color: AppColors.white,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget variants() {
    // return Padding(
    //   padding: const EdgeInsets.symmetric(horizontal: 15.0),
    //   child: Column(
    //     children: viewModel.optionsList.entries.map((element) {
    //       //viewModel.selectedOption.value = element.value!.first;
    //       viewModel.selectedOptionList.putIfAbsent(element.key, ()=> element.value.first);

    //       return variantsListItems(
    //           title: element.key, variantList: element.value);
    //     }).toList(),
    //   ),
    // );

    return Obx(
      () => viewModel.productModel.value.options == null
          ? Container()
          : Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: Column(
                children:
                    viewModel.productModel.value.options!.map((Option element) {
                  viewModel.selectedOptionList
                      .putIfAbsent(element.name!, () => element.values!.first);

                  return variantsListItems(
                      title: element.name, variantList: element.values);
                }).toList(),
              ),
            ),
    );
  }

  Widget variantsListItems({String? title, List<String>? variantList}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        textTitle(title!),
        Obx(
          () => Row(
            children: variantList!.map((e) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: InkWell(
                  onTap: () {
                    //viewModel.selectedOption.value = e.toString();
                    viewModel.selectedOptionList.remove(title);
                    viewModel.selectedOptionList.putIfAbsent(title, () => e);
                  },
                  child: Container(
                    padding: const EdgeInsets.all(6),
                    decoration: BoxDecoration(
                      //shape: BoxShape.rectangle,
                      color: viewModel.selectedOptionList.values.contains(e)
                          ? AppColors.black
                          : AppColors.white,
                      borderRadius: const BorderRadius.all(Radius.circular(5)),
                      border: Border.all(color: AppColors.black),
                    ),
                    child: Text(
                      e,
                      style: ThemeHelper.textTheme.bodySmall!.copyWith(
                          color: viewModel.selectedOptionList.values.contains(e)
                              ? AppColors.white
                              : AppColors.black),
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }

  Widget description() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          textTitle('Description'),
          Text(
            viewModel.productModel.value.description ?? 'N/A',
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
          onTap: (index) {
            if (index == 0) {
              viewModel.scrollTo(viewModel.reviewsKey);
            } else if (index == 1) {
              viewModel.scrollTo(viewModel.vendorKey);
            } else {
              viewModel.scrollTo(viewModel.similarProductKey);
            }
          },
          tabs: const [
            Tab(text: 'Reviews'),
            Tab(text: 'Vendor'),
            Tab(text: 'Similar Products')
          ],
        ));
  }

  Widget reviewsAndRatings() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        key: viewModel.reviewsKey,
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
              style: ThemeHelper.textTheme.bodySmall!
                  .copyWith(fontWeight: FontWeight.w600),
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
                      return Padding(
                        padding: const EdgeInsets.all(2.0),
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(8)),
                              border: Border.all(color: AppColors.grey2)),
                          child: Padding(
                            padding: const EdgeInsets.all(3.0),
                            child: CustomNetworkImage(
                              height: 35,
                              width: 35,
                              imageUrl: storeProducts!.image ?? '',
                            ),
                          ),
                        ),
                      );
                    }),
              ),
            ),
            CustomIconTextBtn(
             
              onPressed: () => Get.toNamed(AppRoutes.vendorStoreRoute),
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
      height: Get.height * 0.35,
      key: viewModel.similarProductKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          textTitle(' People also Viewed'),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 6.0),
              child: ListView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                physics: const BouncingScrollPhysics(),
                itemCount:
                    viewModel.productModel.value.store!.products?.length ?? 0,
                itemBuilder: (_, index) {
                  Product? product =
                      viewModel.productModel.value.store!.products![index];
                  num? discount = 0.0;
                  if (product.discount != null) {
                    discount = product.discount?.percentage;
                  }
                  print("ProductImage: ${product.image}");
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5.0),
                    child: ProductItem2(
                        onTap: () {
                          Get.offNamed(AppRoutes.productDetailsRoute,
                              preventDuplicates: false,
                              arguments: {"productId": "${product.id}"});
                        },
                        image: product.image!,
                        discount: discount!,
                        name: product.name!,
                        reviews: product.totalReviews!,
                        rating: product.rating!,
                        price: 0),
                  );
                },
              ),
            ),
          ),
          const SizedBox(height: 10),
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
