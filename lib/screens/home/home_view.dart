import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:ismmart_ecommerce/screens/home/home_viewmodel.dart';

class HomeView extends StatelessWidget {
  HomeView({super.key});

  final HomeViewModel viewModel = Get.put(HomeViewModel());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(),
      body: Column(
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
        ],
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
        height: 220,
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
                return carouselImage(index);
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

  Widget carouselImage(int index) {
    return CachedNetworkImage(
      imageUrl: viewModel.bannersList[index],
      imageBuilder: (context, imageProvider) {
        return Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: imageProvider,
              fit: BoxFit.fill,
            ),
          ),
        );
      },
      errorWidget: (context, url, error) {
        return Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/banner_default_image.png'),
              fit: BoxFit.fill,
            ),
          ),
        );
      },
      placeholder: (context, url) {
        return Center(
          child: CircularProgressIndicator(
            strokeWidth: 2.0,
            color: Get.theme.primaryColor,
          ),
        );
      },
    );
  }

  Widget appBarBackgroundImage() {
    return Obx(
      () => Stack(
        children: [
          CachedNetworkImage(
            imageUrl: viewModel.appBarImage.value,
            imageBuilder: (context, imageProvider) {
              return Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: imageProvider,
                    fit: BoxFit.cover,
                  ),
                ),
              );
            },
            errorWidget: (context, url, error) {
              return Container(
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/images/banner_default_image.png'),
                    fit: BoxFit.fill,
                  ),
                ),
              );
            },
            placeholder: (context, url) {
              return Center(
                child: CircularProgressIndicator(
                  strokeWidth: 2.0,
                  color: Get.theme.primaryColor,
                ),
              );
            },
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
}
