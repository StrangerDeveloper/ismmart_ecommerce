import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ismmart_ecommerce/helpers/global_variables.dart';
import 'package:ismmart_ecommerce/screens/category/category_viewmodel.dart';
import 'package:ismmart_ecommerce/screens/sub_category/sub_category_view.dart';
import 'package:ismmart_ecommerce/widgets/loader_view.dart';

import '../../widgets/custom_network_image.dart';
import '../wishlist/wishlist_view.dart';

class CategoryView extends StatelessWidget {
  CategoryView({super.key});

  final CategoryViewModel viewModel = Get.put(CategoryViewModel());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(),
      body: Stack(
        children: [
          Column(
            children: [
              collectionsList(),
              Obx(
                () => (viewModel.categoriesList.isNotEmpty)
                    ? Expanded(
                        child: GridView.builder(
                          padding: const EdgeInsets.all(20),
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 4,
                            mainAxisSpacing: 20,
                            crossAxisSpacing: 13,
                            childAspectRatio: 0.72,
                          ),
                          itemCount: viewModel.categoriesList.length,
                          itemBuilder: (context, index) {
                            return InkWell(
                              borderRadius: BorderRadius.circular(4),
                              onTap: () {
                                Get.to(() => SubCategoryView(), arguments: {
                                  'id':
                                      viewModel.categoriesList[index].sId ?? ''
                                });
                              },
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 10, horizontal: 4),
                                child: Column(
                                  children: [
                                    Expanded(
                                      child: CustomNetworkImage(
                                        imageUrl: viewModel
                                                .categoriesList[index]
                                                .media?.first ??
                                            '',
                                        shape: BoxShape.circle,
                                      ),
                                    ),
                                    const SizedBox(height: 8),
                                    Text(
                                      viewModel.categoriesList[index].name ??
                                          '',
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      textAlign: TextAlign.center,
                                      style: const TextStyle(
                                        fontSize: 11.5,
                                        color: Colors.black,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      )
                    : const SizedBox(),
              ),
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

  Widget collectionsList() {
    return Obx(
      () => GlobalVariable.collectionList.isNotEmpty
          ? SizedBox(
              height: 32,
              child: ListView.builder(
                padding: const EdgeInsets.only(bottom: 5),
                physics: const BouncingScrollPhysics(),
                scrollDirection: Axis.horizontal,
                itemCount: GlobalVariable.collectionList.length,
                itemBuilder: (context, index) {
                  return collectionListViewItem(index);
                },
              ),
            )
          : const SizedBox(),
    );
  }

  Widget collectionListViewItem(int index){
    return Obx(() => Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            viewModel.changeCollection(index);
          },
          child: Container(
            decoration: BoxDecoration(
              border:
              viewModel.collectionCurrentIndex.value == index
                  ? const Border(
                bottom: BorderSide(
                  width: 2,
                  color: Colors.black,
                ),
              )
                  : null,
            ),
            padding: const EdgeInsets.symmetric(horizontal: 2),
            alignment: Alignment.center,
            child: Text(
              GlobalVariable.collectionList[index].name
                  ?.capitalizeFirst ??
                  '',
              style: const TextStyle(
                fontSize: 12,
                color: Colors.black,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
      ),
    ));
  }
}
