import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swipe_action_cell/flutter_swipe_action_cell.dart';
import 'package:get/get.dart';
import 'package:ismmart_ecommerce/screens/cart/cart_viewmodel.dart';
import 'package:ismmart_ecommerce/widgets/custom_appbar.dart';
import 'package:ismmart_ecommerce/widgets/custom_network_image.dart';

import '../../helpers/app_colors.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_text_field.dart';
import '../wishlist/wishlist_view.dart';

class CartView extends StatelessWidget {
  CartView({super.key});

  final CartViewModel viewModel = Get.put(CartViewModel());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: appBar(),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.only(left: 16, top: 16, bottom: 10),
              child: Text(
                '3 Items',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            listView(),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 30),
              child: CustomTextField1(
                // controller: viewModel.ibanController,
                title: 'Promo Code',
                hintText: 'mypromocode22',
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 16, right: 16, bottom: 12),
              child: CustomTextBtn(
                height: 45,
                title: 'Check OUt',
                onPressed: () {
                  // viewModel.saveAndCreateBtn();
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: CustomTextBtn(
                height: 45,
                foregroundColor: Colors.black,
                borderSide: const BorderSide(),
                title: 'Continue Shopping',
                backgroundColor: Colors.transparent,
                onPressed: () {
                  Get.back();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  appBar() {
    return CustomAppBar2(
      title: 'Cart',
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

  Widget listView() {
    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: 3,
      itemBuilder: (context, int index) {
        return listViewItem(index);
      },
      separatorBuilder: (BuildContext context, int index) {
        return const SizedBox(height: 16);
      },
    );
  }

  Widget listViewItem(int index) {
    return SwipeActionCell(
      backgroundColor: Colors.grey.shade50,
      key: UniqueKey(),
      // confirmDismiss: (confirmDismiss) {
      //   return deleteConfirmationDialog(index);
      // },
      leadingActions: [
        SwipeAction(
          content: Container(
            height: double.infinity,
            width: 55,
            decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              children: [
                IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.add,
                    color: Colors.white,
                  ),
                ),
                const Expanded(
                  child: Text(
                    '1',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.remove,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
          color: Colors.transparent,
          onTap: (CompletionHandler handler) async {},
        ),
      ],
      trailingActions: [
        SwipeAction(
          content: Container(
            height: double.infinity,
            width: 55,
            decoration: BoxDecoration(
              color: AppColors.red,
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Center(
              child: Icon(
                CupertinoIcons.delete,
                color: Colors.white,
              ),
            ),
          ),
          color: Colors.transparent,
          onTap: (CompletionHandler handler) async {
            // deleteConfirmationDialog(index);
          },
        ),
      ],
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 15),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: Colors.white,
        ),
        child: Row(
          children: [
            const CustomNetworkImage(
              radius: 12,
              width: 85,
              height: 85,
              imageUrl:
                  'https://images.unsplash.com/photo-1575936123452-b67c3203c357?q=80&w=1470&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
            ),
            const SizedBox(width: 15),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Nike Air Max Z',
                    style: TextStyle(
                      color: Color(0xFF24272C),
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(top: 3, bottom: 8),
                    child: Text(
                      'Shoes World',
                      style: TextStyle(
                        color: Color(0xFF929AAB),
                        fontSize: 10,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  RichText(
                    text: const TextSpan(
                      text: 'Color ',
                      style: TextStyle(
                        color: Color(0xFF929AAB),
                        fontSize: 10,
                        fontWeight: FontWeight.w500,
                      ),
                      children: [
                        TextSpan(
                          text: 'Orange',
                          style: TextStyle(
                            color: Colors.black,
                          ),
                        )
                      ],
                    ),
                  ),
                  Row(
                    children: [
                      RichText(
                        text: const TextSpan(
                          text: 'Size ',
                          style: TextStyle(
                            color: Color(0xFF929AAB),
                            fontSize: 10,
                            fontWeight: FontWeight.w500,
                          ),
                          children: [
                            TextSpan(
                              text: '12',
                              style: TextStyle(
                                color: Colors.black,
                              ),
                            )
                          ],
                        ),
                      ),
                      const Expanded(
                        child: Text(
                          '\$84',
                          textAlign: TextAlign.right,
                          style: TextStyle(
                            color: Color(0xFF24272C),
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
