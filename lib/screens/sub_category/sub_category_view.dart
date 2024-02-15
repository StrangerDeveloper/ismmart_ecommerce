import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ismmart_ecommerce/screens/sub_category/sub_category_viewmodel.dart';
import 'package:ismmart_ecommerce/widgets/loader_view.dart';

import '../../widgets/circular_progress_bar.dart';
import '../../widgets/custom_network_image.dart';
import '../../widgets/custom_radiobtn.dart';
import '../../widgets/product_item.dart';
import '../wishlist/wishlist_view.dart';

class SubCategoryView extends StatelessWidget {
  SubCategoryView({super.key});

  final SubCategoryViewModel viewModel = Get.put(SubCategoryViewModel());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(),
      body: Stack(
        children: [
          Column(
            children: [
              subcategoryList(),
              topFiltration(),
              productList(),
            ],
          ),
          const LoaderView(),
        ],
      ),
    );
  }

  AppBar appBar() {
    return AppBar(
      elevation: 0,
      iconTheme: const IconThemeData(
        color: Colors.black,
      ),
      // pinned: true,
      leading: IconButton(
        onPressed: () {},
        icon: const Icon(
          CupertinoIcons.search,
        ),
      ),
      title: const Text(
        'ISMMART',
        style: TextStyle(
          fontSize: 20,
          fontFamily: 'Raleway',
          fontWeight: FontWeight.w700,
          color: Colors.black,
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
    );
  }

  Widget subcategoryList() {
    return Obx(
      () => viewModel.subCategoriesList.isNotEmpty
          ? SizedBox(
              height: 75,
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                physics: const BouncingScrollPhysics(),
                scrollDirection: Axis.horizontal,
                itemCount: viewModel.subCategoriesList.length,
                itemBuilder: (context, index) {
                  return subCategoryListViewItem(index);
                },
              ),
            )
          : const SizedBox(),
    );
  }

  Widget subCategoryListViewItem(int index) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            viewModel.changeSubCategory(index);
          },
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 2),
            alignment: Alignment.center,
            child: Stack(
              alignment: Alignment.bottomCenter,
              children: [
                CustomNetworkImage(
                  height: 75,
                  width: 60,
                  imageUrl:
                      viewModel.subCategoriesList[index].media?.first ?? '',
                  radius: 10,
                  // boxFit = BoxFit.cover,
                ),
                Container(
                  width: 60,
                  padding:
                      const EdgeInsets.symmetric(vertical: 3, horizontal: 2),
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.vertical(
                      bottom: Radius.circular(10),
                    ),
                    color: const Color(0xff24282D).withOpacity(0.8),
                  ),
                  child: Text(
                    viewModel.subCategoriesList[index].name?.capitalizeFirst ??
                        '',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 8.5,
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
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

  Widget topFiltration() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
      child: Row(
        children: [
          filterOptionItem2(
              title: 'Sort by',
              isSelected: false,
              icon: Icons.keyboard_arrow_down_rounded,
              onTap: () {
                filterBottomSheet();
              }),
          Obx(
            () => filterOptionItem2(
              title: 'New Arrivals',
              isSelected: viewModel.newArrivalValue.value,
              onTap: () {
                viewModel.newArrivalValue.value =
                    !viewModel.newArrivalValue.value;
              },
            ),
          ),
          // filterOptionItem2(
          //   title: 'Popular',
          //   isSelected: false,
          // ),
          Obx(
            () => filterOptionItem2(
              title: 'Top-rated',
              isSelected: viewModel.topRatedValue.value,
              onTap: () {
                viewModel.topRatedValue.value = !viewModel.topRatedValue.value;
              },
            ),
          ),
          filterOptionItem2(
            title: 'Filter',
            isSelected: false,
            icon: Icons.filter_alt_rounded,
            onTap: () {},
          )
        ],
      ),
    );
  }

  Widget filterOptionItem2({
    required String title,
    required bool isSelected,
    IconData? icon,
    required void Function()? onTap,
  }) {
    return Expanded(
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 2),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                title,
                textAlign: TextAlign.center,
                maxLines: 1,
                style: TextStyle(
                  color: isSelected ? Colors.black : const Color(0xFF6F6F6F),
                  fontSize: 11.5,
                  fontWeight: FontWeight.w500,
                ),
              ),
              if (icon != null)
                Padding(
                  padding: const EdgeInsets.only(left: 3),
                  child: Icon(
                    icon,
                    size: 15,
                    color: isSelected ? Colors.black : const Color(0xFF6F6F6F),
                  ),
                )
            ],
          ),
        ),
      ),
    );
  }

  Widget productList() {
    return Expanded(
      child: Obx(
        () => viewModel.productList.isNotEmpty
            ? Column(
                children: [
                  Expanded(
                    child: GridView.builder(
                      controller: viewModel.scrollController,
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: 12,
                        crossAxisSpacing: 25,
                        childAspectRatio: 0.62,
                      ),
                      itemCount: viewModel.productList.length,
                      itemBuilder: (context, index) {
                        return ProductItem2(
                          product: viewModel.productList[index],
                          //onTap: () {},
                          image: viewModel.productList[index].image ?? '',
                          name: viewModel.productList[index].name ?? '',
                          category:
                              viewModel.productList[index].store?.name ?? '',
                          rating: viewModel.productList[index].rating ?? 0,
                          reviews:
                              viewModel.productList[index].totalReviews ?? 0,
                          discount: viewModel
                                  .productList[index].discount?.percentage ??
                              0,
                          price: viewModel.productList[index].price ?? 0,
                        );
                      },
                    ),
                  ),
                  if (viewModel.paginationLoader.value)
                    const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: CustomCircularLoader())
                ],
              )
            : viewModel.showListLoader.value
                ? const CustomCircularLoader()
                : const Center(
                    child: Text('No Data Found'),
                  ),
      ),
    );
  }

  filterBottomSheet() {
    showModalBottomSheet(
      context: Get.context!,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(16),
          topRight: Radius.circular(16),
        ),
      ),
      builder: (BuildContext context) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.all(10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Sort',
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      // color: ThemeHelper.blue1,
                      fontSize: 15,
                    ),
                  ),
                  IconButton(
                    visualDensity: VisualDensity.compact,
                    onPressed: () {
                      Get.back();
                    },
                    icon: const Icon(
                      Icons.close,
                      color: Colors.red,
                    ),
                  ),
                ],
              ),
            ),
            Obx(
              () => CustomCheckRadioButton(
                title: 'Top to Bottom',
                groupValue: viewModel.sortValue.value,
                value: 'top-to-bottom',
                onChanged: (value) {
                  viewModel.sortSelection(value);
                },
              ),
            ),
            Obx(
              () => CustomCheckRadioButton(
                title: 'Bottom to Top',
                groupValue: viewModel.sortValue.value,
                value: 'bottom-to-top',
                onChanged: (value) {
                  viewModel.sortSelection(value);
                },
              ),
            ),
          ],
        );
      },
    );
  }
}
