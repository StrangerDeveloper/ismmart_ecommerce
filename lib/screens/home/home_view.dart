import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:ismmart_ecommerce/screens/home/home_viewmodel.dart';

import '../../widgets/custom_network_image.dart';

class HomeView extends StatelessWidget {
  HomeView({super.key});

  final HomeViewModel viewModel = Get.put(HomeViewModel());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            carousel(),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 25),
              child: Row(
                children: [
                  discountContainers(
                    title: 'Free Shipping',
                    description: 'on orders of Rs 5000',
                    icon: Icons.local_shipping_rounded,
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
                offOnOrders(
                  title: 'RS 250 OFF',
                  description: 'on orders of Rs 5000',
                ),
                offOnOrders(
                  title: 'RS 500 OFF',
                  description: 'on orders of Rs 8000',
                ),
                offOnOrders(
                  title: 'RS 1000 OFF',
                  description: 'on orders of Rs 10,000',
                ),
              ],
            ),
            promoCode(),
            bottomBanner(),
            const Align(
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
            ),
            categoriesCarousel(),
            countDown(),
            productList(),
          ],
        ),
      ),
    );
  }

  AppBar appBar() {
    return AppBar(
      systemOverlayStyle: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        // statusBarBrightness: Brightness.dark,
        statusBarIconBrightness: Brightness.light,
      ),
      leading: IconButton(
        onPressed: () {},
        icon: const Icon(
          CupertinoIcons.search,
          color: Colors.white,
        ),
      ),
      title: const Text(
        'ISMMART',
        style: TextStyle(
          // color: Colors.white,
          fontSize: 20,
          fontFamily: 'Raleway',
          fontWeight: FontWeight.w700,
          color: Colors.white,
        ),
      ),
      actions: [
        IconButton(
          onPressed: () {},
          icon: const Icon(
            Icons.favorite_border_sharp,
            color: Colors.white,
          ),
        ),
        IconButton(
          onPressed: () {},
          icon: const Icon(
            Icons.shopping_cart_outlined,
            color: Colors.white,
          ),
        ),
      ],
      flexibleSpace: appBarBackgroundImage(),
    );
  }

  Widget carousel() {
    return Obx(
      () => SizedBox(
        height: 200,
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            PageView.builder(
              controller: viewModel.pageController,
              onPageChanged: (value) {
                viewModel.currentPage.value = value;
                viewModel.appBarImage.value = viewModel.bannersList[value];
              },
              itemCount: viewModel.bannersList.length,
              itemBuilder: (context, index) {
                return CustomNetworkImage(
                  imageUrl: viewModel.bannersList[index],
                );
              },
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 6),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  viewModel.bannersList.length,
                  (index) => AnimatedContainer(
                    duration: const Duration(milliseconds: 400),
                    height: 6.0,
                    width: viewModel.currentPage.value == index ? 14 : 6,
                    margin: const EdgeInsets.only(right: 3),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: viewModel.currentPage.value == index
                          ? Colors.black
                          : Colors.grey,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
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
            const Text(
              'Free Shipping',
              style: TextStyle(
                color: Colors.white,
                fontSize: 12,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 2),
            Row(
              children: [
                const Expanded(
                  child: Text(
                    'on orders of Rs 5000 ',
                    style: TextStyle(
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
      child: Column(
        children: [
          Text(
            title,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Colors.black,
              fontSize: 12,
              fontWeight: FontWeight.w700,
            ),
          ),
          Text(
            description,
            style: const TextStyle(
              color: Colors.black,
              fontSize: 10,
            ),
          )
        ],
      ),
    );
  }

  Widget promoCode() {
    return Container(
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
    );
  }

  Widget bottomBanner() {
    return const CustomNetworkImage(
      height: 100,
      imageUrl:
          'https://images.unsplash.com/photo-1575936123452-b67c3203c357?q=80&w=1470&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
    );
  }

  Widget countDown() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Electronics Deals',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
                ),
                Text(
                  'See All',
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),
          countDownItem(digit: '13', unit: 'Hour'),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 6),
            child: countDownItem(digit: '34', unit: 'Min '),
          ),
          countDownItem(digit: '56', unit: 'Sec '),
        ],
      ),
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

  Widget categoriesCarousel() {
    return SizedBox(
      height: 280,
      child: GridView.builder(
        // padding: EdgeInsets.symmetric(horizontal: 5),
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
              Expanded(
                child: CustomNetworkImage(
                  // height: 58,
                  // width: 58,
                  imageUrl: viewModel.categoriesList[index],
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'Men',
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 10,
                  color: Colors.black,
                ),
              )
            ],
          );
        },
      ),
    );
  }

  Widget productList() {
    return SizedBox(
      height: 1000,
      child: GridView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        // scrollDirection: Axis.horizontal,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 8,
          crossAxisSpacing: 25,
          childAspectRatio: 0.75,
        ),
        itemCount: viewModel.categoriesList.length,
        itemBuilder: (context, index) {
          return productListItem(index);
        },
      ),
    );
  }

  Widget productListItem(int index) {
    return Container(
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
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomNetworkImage(
            height: 130,
            imageUrl:
                'https://images.unsplash.com/photo-1575936123452-b67c3203c357?q=80&w=1470&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
            // height: 100,
          ),
          Text(
            'TMA-2 HD Wireless',
            style: TextStyle(
              fontWeight: FontWeight.w500,
            ),
          ),
          Text(
            'Techstore',
            style: TextStyle(
              color: Color(0xFF929AAB),
              fontSize: 10,
              fontWeight: FontWeight.w500,
            ),
          ),
          Text(
            'Rs 1,000',
            style: TextStyle(
              color: Color(0xFF24272C),
              fontSize: 12,
              fontWeight: FontWeight.w900,
            ),
          ),
          Text(
            'Rs 1,500',
            style: TextStyle(
              color: Color(0xFFFE3A30),
              fontSize: 10,
              fontWeight: FontWeight.w900,
              decoration: TextDecoration.lineThrough,
            ),
          ),
          Row(
            children: [
              Icon(Icons.star, color: Color(0xffFFC120),),
              Text(
                '4.6',
                style: TextStyle(
                  fontSize: 10,
                ),
              ),
              SizedBox(width: 10),
              Text(
                '86 Reviews',
                style: TextStyle(
                  fontSize: 10,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
