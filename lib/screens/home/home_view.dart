import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:ismmart_ecommerce/screens/home/home_viewmodel.dart';
import 'package:ismmart_ecommerce/widgets/loader_view.dart';
import 'package:ismmart_ecommerce/widgets/product_item.dart';

import '../../widgets/circular_progress_bar.dart';
import '../../widgets/custom_network_image.dart';
import '../wishlist/wishlist_view.dart';

class HomeView extends StatelessWidget {
  HomeView({super.key});

  final HomeViewModel viewModel = Get.put(HomeViewModel());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          CustomScrollView(
            controller: viewModel.mainScrollController,
            slivers: [
              appBar(),
              SliverList(
                delegate: SliverChildListDelegate(
                  [
                    carousel(),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 25),
                      child: Row(
                        children: [
                          Obx(
                            () => viewModel.newsList.isNotEmpty
                                ? discountContainers(
                                    title: viewModel.newsList[0].name ?? '',
                                    description:
                                        viewModel.newsList[0].description ?? '',
                                    icon: Icons.discount,
                                  )
                                : const SizedBox(),
                          ),
                          const SizedBox(width: 16),
                          discountContainers(
                            title: 'FLASH SALE',
                            description: 'Dont miss out!',
                            icon: 'assets/images/sale_percent.svg',
                          ),
                        ],
                      ),
                    ),
                    Row(
                      children: [
                        Obx(
                          () => viewModel.newsList.length > 1
                              ? offOnOrders(
                                  title: viewModel.newsList[1].name ?? '',
                                  description:
                                      viewModel.newsList[1].description ?? '',
                                )
                              : const SizedBox(),
                        ),
                        Obx(
                          () => viewModel.newsList.length > 2
                              ? offOnOrders(
                                  title: viewModel.newsList[2].name ?? '',
                                  description:
                                      viewModel.newsList[2].description ?? '',
                                )
                              : const SizedBox(),
                        ),
                        Obx(
                          () => viewModel.newsList.length > 3
                              ? offOnOrders(
                                  title: viewModel.newsList[3].name ?? '',
                                  description:
                                      viewModel.newsList[3].description ?? '',
                                )
                              : const SizedBox(),
                        ),
                      ],
                    ),
                    // promoCode(),
                    bannerImage(),
                    categoriesTitle(),
                    categoriesList(),
                    flashSaleCountDown(),
                    flashSaleProductList(),
                    const Divider(),
                    allProductsTitle(),
                    const SizedBox(height: 80),
                  ],
                ),
              ),
              allProductList(),
              Obx(
                () => SliverToBoxAdapter(
                  child: viewModel.paginationLoader.value
                      ? const Padding(
                          padding: EdgeInsets.only(bottom: 80),
                          child: CustomCircularLoader(),
                        )
                      : const SizedBox(),
                ),
              ),
            ],
          ),
          const LoaderView(),
        ],
      ),
    );
  }

  appBar() {
    return Obx(
      () => SliverAppBar(
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: viewModel.isScrolled.value
              ? Colors.white
              : Colors.transparent, //for Android
          statusBarIconBrightness: viewModel.isScrolled.value
              ? Brightness.dark
              : Brightness.light, //for Android
          statusBarBrightness: viewModel.isScrolled.value
              ? Brightness.dark
              : Brightness.light, //for IOS
        ),
        iconTheme: IconThemeData(
          color: viewModel.isScrolled.value ? Colors.black : Colors.white,
        ),
        pinned: true,
        leading: IconButton(
          onPressed: () {},
          icon: const Icon(
            CupertinoIcons.search,
          ),
        ),
        title: Text(
          'ISMMART',
          style: TextStyle(
            fontSize: 20,
            fontFamily: 'Raleway',
            fontWeight: FontWeight.w700,
            color: viewModel.isScrolled.value ? Colors.black : Colors.white,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              Get.to(() => WishlistView());
            },
            icon: const Icon(
              Icons.favorite_border_sharp,
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.shopping_cart_outlined,
            ),
          ),
        ],
        flexibleSpace:
            (viewModel.isScrolled.value && viewModel.carouselList.isNotEmpty)
                ? null
                : appBarBackgroundImage(),
        bottom: collectionsList(),
      ),
    );
  }

  PreferredSizeWidget? collectionsList() {
    return viewModel.collectionList.isNotEmpty
        ? PreferredSize(
            preferredSize: const Size(double.infinity, 32),
            child: SizedBox(
              height: 32,
              child: ListView.builder(
                padding: const EdgeInsets.only(bottom: 5),
                physics: const BouncingScrollPhysics(),
                scrollDirection: Axis.horizontal,
                itemCount: viewModel.collectionList.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    child: InkWell(
                      onTap: () {
                        viewModel.changeCollection(index);
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          border:
                              viewModel.collectionCurrentIndex.value == index
                                  ? Border(
                                      bottom: BorderSide(
                                        width: 2,
                                        color: viewModel.isScrolled.value
                                            ? Colors.black
                                            : Colors.white,
                                      ),
                                    )
                                  : null,
                        ),
                        padding: const EdgeInsets.symmetric(horizontal: 2),
                        alignment: Alignment.center,
                        child: Text(
                          viewModel.collectionList[index].name
                                  ?.capitalizeFirst ??
                              '',
                          style: TextStyle(
                            fontSize: 12,
                            color: viewModel.isScrolled.value
                                ? Colors.black
                                : Colors.white,
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          )
        : null;
  }

  Widget carousel() {
    return Obx(
      () => viewModel.carouselList.isNotEmpty
          ? SizedBox(
              height: 200,
              child: Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  PageView.builder(
                    controller: viewModel.carouselPageController,
                    onPageChanged: (value) {
                      viewModel.carouselCurrentIndex.value = value;
                      viewModel.appBarImage.value =
                          viewModel.carouselList[value];
                    },
                    itemCount: viewModel.carouselList.length,
                    itemBuilder: (context, index) {
                      return CustomNetworkImage(
                        imageUrl: viewModel.carouselList[index],
                      );
                    },
                  ),
                  if (viewModel.carouselList.length > 1)
                    Padding(
                      padding: const EdgeInsets.only(bottom: 6),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(
                          viewModel.carouselList.length,
                          (index) => AnimatedContainer(
                            duration: const Duration(milliseconds: 400),
                            height: 6.0,
                            width: viewModel.carouselCurrentIndex.value == index
                                ? 14
                                : 6,
                            margin: const EdgeInsets.only(right: 3),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color:
                                  viewModel.carouselCurrentIndex.value == index
                                      ? Colors.black
                                      : Colors.grey,
                            ),
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            )
          : const SizedBox(),
    );
  }

  Widget appBarBackgroundImage() {
    return Obx(
      () => Stack(
        children: [
          CustomNetworkImage(
            imageUrl: viewModel.appBarImage.value,
          ),
          ClipRRect(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
              child: Container(
                color: Colors.grey.withOpacity(0.01),
                alignment: Alignment.center,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget discountContainers({
    required String title,
    required String description,
    required dynamic icon, // image or icon
  }) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.only(left: 10, top: 6, bottom: 6, right: 8),
        decoration: const BoxDecoration(
          color: Color(0xff262626),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 12,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 2),
            Row(
              children: [
                Expanded(
                  child: Text(
                    description,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: Color(0xFFD9D9D9),
                      fontSize: 10,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                icon.runtimeType == IconData
                    ? Icon(
                        icon,
                        color: Colors.white,
                        size: 12,
                      )
                    : SvgPicture.asset(
                        'assets/images/sale_percent.svg',
                        height: 12,
                        width: 12,
                      )
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget offOnOrders({
    required String title,
    required String description,
  }) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 3),
        child: Column(
          children: [
            Text(
              title,
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 12,
                fontWeight: FontWeight.w900,
              ),
            ),
            Text(
              Bidi.stripHtmlIfNeeded(description),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 10,
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget promoCode() {
    return Align(
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 25),
        padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 7),
        decoration: const BoxDecoration(
          color: Color(0xff262626),
        ),
        child: RichText(
          text: const TextSpan(
            text: 'CODE : ',
            style: TextStyle(
              color: Colors.white,
              fontSize: 10,
              fontWeight: FontWeight.w400,
            ),
            children: [
              TextSpan(
                text: 'ISM024',
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget bannerImage() {
    return Obx(
      () => viewModel.bannerImage.value != ''
          ? CustomNetworkImage(
              height: 100,
              imageUrl: viewModel.bannerImage.value,
            )
          : const SizedBox(),
    );
  }

  Widget flashSaleCountDown() {
    return Obx(
      () => viewModel.discountModel?.value.name != null
          ? Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          viewModel.discountModel?.value.name ?? '',
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: Colors.black,
                          ),
                        ),
                        const Text(
                          'See All',
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Obx(
                    () => countDownItem(
                      digit: viewModel.hours.value,
                      unit: 'Hour',
                    ),
                  ),
                  Obx(
                    () => Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 6),
                      child: countDownItem(
                        digit: viewModel.minutes.value,
                        unit: 'Min ',
                      ),
                    ),
                  ),
                  Obx(
                    () => countDownItem(
                      digit: viewModel.seconds.value,
                      unit: 'Sec ',
                    ),
                  ),
                ],
              ),
            )
          : const SizedBox(),
    );
  }

  Widget countDownItem({required String digit, required String unit}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      color: Colors.black,
      child: Column(
        children: [
          Text(
            digit,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.w700,
            ),
          ),
          Text(
            unit,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 11,
              fontWeight: FontWeight.w300,
            ),
          ),
        ],
      ),
    );
  }

  Widget categoriesTitle() {
    return Obx(
      () => (viewModel.categoriesList.isNotEmpty)
          ? const Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: EdgeInsets.all(16),
                child: Text(
                  'Categories',
                  style: TextStyle(
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
            )
          : const SizedBox(),
    );
  }

  Widget categoriesList() {
    return Obx(
      () => (viewModel.categoriesList.isNotEmpty)
          ? SizedBox(
              height: 280,
              child: GridView.builder(
                scrollDirection: Axis.horizontal,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  mainAxisSpacing: 8,
                  crossAxisSpacing: 25,
                  childAspectRatio: 0.92,
                ),
                itemCount: viewModel.categoriesList.length,
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      const Expanded(
                        child: CustomNetworkImage(
                          imageUrl: '',
                          shape: BoxShape.circle,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        viewModel.categoriesList[index].name ?? '',
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 10,
                          color: Colors.black,
                        ),
                      )
                    ],
                  );
                },
              ),
            )
          : const SizedBox(),
    );
  }

  Widget flashSaleProductList() {
    return Obx(
      () => viewModel.flashProductList.isNotEmpty
          ? GridView.builder(
              physics: const NeverScrollableScrollPhysics(),
              padding: const EdgeInsets.symmetric(horizontal: 16),
              shrinkWrap: true,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 12,
                crossAxisSpacing: 25,
                childAspectRatio: 0.62,
              ),
              itemCount: viewModel.flashProductList.length,
              itemBuilder: (context, index) {
                return ProductItem2(
                  onTap: () {},
                  image: viewModel.flashProductList[index].image ?? '',
                  name: viewModel.flashProductList[index].name ?? '',
                  category: viewModel.flashProductList[index].store?.name ?? '',
                  rating: '${viewModel.flashProductList[index].rating ?? 0}',
                  reviews:
                      '${viewModel.flashProductList[index].totalReviews ?? 0}',
                  discount:
                      viewModel.flashProductList[index].discount?.percentage ??
                          0,
                  price: viewModel.flashProductList[index].price ?? 0,
                );
              },
            )
          : const SizedBox(),
    );
  }

  Widget seeAllItem({required String title, void Function()? onTap}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 16),
          child: Text(
            title,
            style: const TextStyle(
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        GestureDetector(
          onTap: onTap,
          child: const Padding(
            padding: EdgeInsets.fromLTRB(10, 10, 16, 10),
            child: Text(
              'See All',
              style: TextStyle(
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
        )
      ],
    );
  }

  Widget allProductsTitle() {
    return Obx(
      () => (viewModel.allProductList.isNotEmpty)
          ? const Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: EdgeInsets.all(16),
                child: Text(
                  'All Products',
                  style: TextStyle(
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
            )
          : const SizedBox(),
    );
  }

  Widget allProductList() {
    return Obx(
      () => viewModel.allProductList.isNotEmpty
          ? SliverGrid(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 12,
                crossAxisSpacing: 25,
                childAspectRatio: 0.62,
              ),
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  return ProductItem2(
                    onTap: () {},
                    image: viewModel.allProductList[index].image ?? '',
                    name: viewModel.allProductList[index].name ?? '',
                    category: viewModel.allProductList[index].store?.name ?? '',
                    rating: '${viewModel.allProductList[index].rating ?? 0}',
                    reviews:
                        '${viewModel.allProductList[index].totalReviews ?? 0}',
                    discount:
                        viewModel.allProductList[index].discount?.percentage ??
                            0,
                    price: viewModel.allProductList[index].price ?? 0,
                  );
                },
                childCount: viewModel.allProductList.length,
              ),
            )
          : const SliverToBoxAdapter(
              child: SizedBox(),
            ),
    );
  }
}
