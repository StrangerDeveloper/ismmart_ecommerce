import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:ismmart_ecommerce/helpers/app_colors.dart';
import 'package:ismmart_ecommerce/helpers/app_routes.dart';
import 'package:ismmart_ecommerce/helpers/theme_helper.dart';
import 'package:ismmart_ecommerce/screens/order/order_listing/order_listing_viewmodel.dart';

import '../../../helpers/global_variables.dart';
import '../../../widgets/custom_appbar.dart';
import '../../../widgets/custom_button.dart';
import '../../../widgets/custom_text.dart';
import '../../../widgets/custom_textfield.dart';
import '../../../widgets/loader_view.dart';

class OrderListingView extends StatelessWidget {
  OrderListingView({super.key, this.callingFor = 'All'});

  final String? callingFor;

  final OrderListingViewModel viewModel = Get.put(OrderListingViewModel());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar2(
        title: "My Orders",
        centerTitle: true,
        containsLeading: true,
        titleTextStyle: ThemeHelper.textTheme.titleSmall!.copyWith(
          fontWeight: FontWeight.bold,
          fontSize: 18,
          color: AppColors.black,
        ),
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 20.0, bottom: 2.0),
                  child: _buildSearchRow(),
                ),
                Obx(
                  () => viewModel.orderItemList.isNotEmpty
                      ? Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: ListView.builder(
                            controller: viewModel.scrollController,
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: viewModel.orderItemList.length,
                            // itemCount: viewModel
                            //         .orderItemModel.value.lineitems?.length ??
                            //     2,
                            itemBuilder: (context, index) {
                              return InkWell(
                                onTap: () {
                                  // viewModel.orderIdSelection(viewModel
                                  //     .orderItemList[index].sId
                                  //     .toString());
                                  // Get.toNamed(
                                  // DetailView');
                                  Get.toNamed(
                                    AppRoutes.orderDetailViewRoute,
                                    arguments: {
                                      'itemId':
                                          viewModel.orderItemList[index].sId,
                                    },
                                  );
                                },
                                child: _buildOrderCard(index),
                              );
                            },
                          ),
                        )
                      : const Center(
                          child: Text('No Data Found'),
                        ),
                ),
              ],
            ),
          ),
          const LoaderView(),
        ],
      ),
    );
  }

  Widget _buildSearchRow() {
    Future.delayed(const Duration(seconds: 1), () {
      GlobalVariable.showLoader.value = true;
      if (callingFor!.toLowerCase().contains('returned')) {
        viewModel.fieldSelection("Returned");
      } else if (callingFor!.toLowerCase().contains('cancelled')) {
        viewModel.fieldSelection("Cancelled");
      }
    });
    return SizedBox(
      width: 300,
      child: CustomTextField1(
        controller: viewModel.searchController,
        filled: false,
        hintText: callingFor!,
        isDropDown: true,
        onTap: () {
          statusBottomSheet();
        },
      ),
    );
  }

  Widget _buildOrderCard(int index) {
    return Obx(
      () => Card(
        margin: const EdgeInsets.symmetric(vertical: 8.0),
        elevation: 3,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        color: const Color(0xFFF9FAFB),
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Expanded(
                    child: _customField1(
                        "Order No ${viewModel.orderItemList[index].orderId ?? "id"}"
                        //"Order No ${viewModel.orderItemModel.value.lineitems?[index].sId ?? "123456"}",
                        ),
                  ),
                  _customField2(
                    //viewModel.orderItemModel.value.createdAt ?? "date",
                    DateFormat("d MMM y").format(
                      DateTime.parse(
                          viewModel.orderItemList[index].createdAt ?? "now"),
                      //viewModel.orderItemModel.value.createdAt ?? "now"),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Obx(
                  //   () => _customRichText(
                  //     text1: "Tracking number: ",
                  //     text2: viewModel
                  //             .orderItemModel.value.lineitems?[index].sId ??
                  //         "IW3475453455",
                  //   ),

                  //   // _customField2(
                  //   //     "Tracking number: ${viewModel.orderItemModel.value.lineitems?[index].sId ?? "IW3475453455"}"),
                  // ),
                  Padding(
                    padding: const EdgeInsets.only(top: 6.0, bottom: 6.0),
                    child: Obx(
                      () => _customRichText(
                        text1: "Quantity: ",
                        text2:
                            viewModel.orderItemList[index].quantity.toString(),
                      ),

                      // _customField2(
                      //     "Quantity: ${(viewModel.orderItemModel.value.lineitems?[index].qty) ?? "teeen"}")
                    ),
                  ),
                  Obx(
                    () => _customRichText(
                      text1: "Total Amount: ",
                      text2: viewModel.orderItemModel.value.totals.toString(),
                    ),

                    // _customField2(
                    //     "Total Amount: ${(viewModel.orderItemModel.value.totals) ?? "zero"}")
                  ),
                  const SizedBox(height: 15),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomTextBtn(
                        title: "Details",
                        onPressed: () {},
                        backgroundColor: Colors.white,
                        foregroundColor: Colors.black,
                        borderSide: const BorderSide(
                          color: Colors.black,
                        ),
                        width: 70,
                        height: 30,
                        radius: 20,
                        padding: const EdgeInsets.all(5),
                      ),
                      Obx(
                        () => _status(
                            //viewModel.orderItemModel.value.status ?? "Pending",
                            viewModel.orderItemList[index].deliveryStatus ??
                                "Pending"),
                      ),
                    ],
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _customRichText({required String text1, required String text2}) {
    return RichText(
      text: TextSpan(
        children: [
          TextSpan(
            text: text1,
            style: ThemeHelper.textTheme.bodyMedium!.copyWith(
              fontWeight: FontWeight.w400,
              color: AppColors.grey2,
            ),
          ),
          TextSpan(
            text: text2,
            style: ThemeHelper.textTheme.bodyMedium!.copyWith(
              fontWeight: FontWeight.w600,
              color: AppColors.black,
            ),
          ),
        ],
      ),
    );
  }

  Widget _customField1(text1) {
    return CustomText(
        title: text1.toString(),
        style: Theme.of(Get.context!)
            .textTheme
            .bodyMedium!
            .copyWith(fontWeight: FontWeight.w600, color: AppColors.black));
  }

  Widget _customField2(text) {
    return CustomText(
      title: text.toString(),
      style: Theme.of(Get.context!).textTheme.bodyMedium!.copyWith(
            fontWeight: FontWeight.w400,
            color: AppColors.black,
          ),
    );
  }

  Widget _status(String value) {
    Color color = statusColor(value);
    return Text(
      value.toString(),
      style: ThemeHelper.textTheme.bodySmall?.copyWith(
        color: color,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Color statusColor(String value) {
    switch (value) {
      case "Pending":
      case "Paid":
      case "Refunded":
      case "Unfulfilled":
        return const Color(0xFFFDBA8C);
      case "Partially Paid":
      case "Processing":
      case "Returned":
      case "In Transit":
      case "Out for Delivery":
        return const Color(0xFFFFE5A0);
      case "Cancelled":
      case "Failed":
        return const Color(0xFFFE3A30);
      case "Shipped":
      case "Fulfilled":
      case "Delivered":
      case "COD Verified":
        return const Color(0xFFBDE9DA);
      default:
        return const Color(0xFFFE3A30);
    }
  }

  statusBottomSheet() {
    int tempIndex = 0;
    showModalBottomSheet(
      context: Get.context!,
      builder: (BuildContext context) {
        return Container(
          height: 200,
          padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CupertinoButton(
                child: const Text(
                  'Cancel',
                  style: TextStyle(fontSize: 14),
                ),
                onPressed: () {
                  Get.back();
                },
              ),
              Expanded(
                child: CupertinoPicker(
                  scrollController: FixedExtentScrollController(
                    initialItem: viewModel.statusSelectedIndex.value,
                  ),
                  itemExtent: 35,
                  onSelectedItemChanged: (int index) {
                    tempIndex = index;
                  },
                  children: List.generate(
                    viewModel.statusList.length,
                    (int index) {
                      return Center(
                        child: Text(
                          viewModel.statusList[index],
                          style: const TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 15,
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
              CupertinoButton(
                onPressed: () {
                  viewModel.statusSelectedIndex.value = tempIndex;
                  viewModel.searchController.text =
                      viewModel.statusList[tempIndex];
                  viewModel.fieldSelection(viewModel.statusList[tempIndex]);

                  Get.back();
                },
                child: const Text(
                  'Done',
                  style: TextStyle(fontSize: 14),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  // filterBottomSheet() {
  //   showModalBottomSheet(
  //     context: Get.context!,
  //     isScrollControlled: true,
  //     backgroundColor: Colors.white,
  //     shape: const RoundedRectangleBorder(
  //       borderRadius: BorderRadius.only(
  //         topLeft: Radius.circular(20),
  //         topRight: Radius.circular(20),
  //       ),
  //     ),
  //     builder: (BuildContext context) {
  //       return Padding(
  //         padding: const EdgeInsets.fromLTRB(16, 10, 10, 10),
  //         child: Column(
  //           crossAxisAlignment: CrossAxisAlignment.start,
  //           mainAxisSize: MainAxisSize.min,
  //           children: [
  //             Row(
  //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //               children: [
  //                 const Icon(
  //                   Icons.menu,
  //                   //color: ThemeHelper.blue1,
  //                 ),
  //                 const SizedBox(width: 10),
  //                 const Text(
  //                   'Sort',
  //                   style: TextStyle(
  //                     fontWeight: FontWeight.w600,
  //                     //color: ThemeHelper.blue1,
  //                     fontSize: 16,
  //                   ),
  //                 ),
  //                 const Spacer(),
  //                 IconButton(
  //                   visualDensity: VisualDensity.compact,
  //                   onPressed: () {
  //                     Get.back();
  //                   },
  //                   icon: const Icon(
  //                     Icons.close,
  //                     color: Colors.red,
  //                   ),
  //                 ),
  //               ],
  //             ),
  //             Obx(
  //               () => CustomRadioButton2(
  //                 title: 'All',
  //                 groupValue: viewModel.filterRadioBtn.value,
  //                 value: 'all',
  //                 onChanged: (value) {
  //                   viewModel.radioBtnSelection(value);
  //                 },
  //               ),
  //             ),
  //             Obx(
  //               () => CustomRadioButton2(
  //                 title: 'Date, old to new',
  //                 groupValue: viewModel.filterRadioBtn.value,
  //                 value: 'oldToNew',
  //                 onChanged: (value) {
  //                   viewModel.radioBtnSelection(value);
  //                 },
  //               ),
  //             ),
  //             Obx(
  //               () => CustomRadioButton2(
  //                 title: 'Date, new to old',
  //                 groupValue: viewModel.filterRadioBtn.value,
  //                 value: 'newToOld',
  //                 onChanged: (value) {
  //                   viewModel.radioBtnSelection(value);
  //                 },
  //               ),
  //             ),
  //             const SizedBox(height: 10),
  //             CustomTextBtn(
  //               title: 'Done',
  //               onPressed: () {
  //                 Get.back();
  //               },
  //             ),
  //           ],
  //         ),
  //       );
  //     },
  //   );
  // }
}
