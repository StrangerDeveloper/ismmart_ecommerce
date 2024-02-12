import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:ismmart_ecommerce/screens/order/order_details/order_detail_viewModel.dart';

import '../../../helpers/theme_helper.dart';
import '../../../widgets/custom_appbar.dart';
import '../../../widgets/custom_button.dart';
import '../../../widgets/custom_network_image.dart';
import '../../../widgets/custom_text.dart';
import '../../../widgets/custom_textfield.dart';
import '../../../widgets/loader_view.dart';

class OrderDetailView extends StatelessWidget {
  final OrderDetailViewModel viewModel = Get.put(OrderDetailViewModel());
  OrderDetailView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar2(
        title: "Order Details",
        centerTitle: true,
        containsLeading: true,
      ),
      body: Stack(
        children: [
          Container(
            width: MediaQuery.of(context).size.width * 1,
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
            ),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 17, bottom: 17),
                    child: _buildOrderListFrame(),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10, bottom: 10),
                    child: _buildOrderDetail(context),
                  ),
                ],
              ),
            ),
          ),
          const LoaderView(),
        ],
      ),
    );
  }

  Widget _buildOrderListFrame() {
    return Padding(
      padding: const EdgeInsets.only(left: 8, right: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _customField2(
              "Order No ${viewModel.orderItemModel.value.orderId ?? "1234"}"),
          _customField1(
            DateFormat("y MMM d").format(
              DateTime.parse(viewModel.orderItemModel.value.createdAt ??
                  DateTime.now().toString()),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOrderDetail(ctx) {
    return Obx(
      () => Container(
        width: MediaQuery.of(ctx).size.width * 1,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
        ),
        padding: const EdgeInsets.all(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    _customField2(
                        "Tracking Number: ${viewModel.orderItemModel.value.orderId ?? "TN"}"),
                  ],
                ),
                _customField2(viewModel
                            .orderItemModel.value.orderDetails?.market !=
                        null
                    ? '${viewModel.orderItemModel.value.orderDetails?.market!} Store'
                    : 'status'),
              ],
            ),
            const SizedBox(height: 20),
            _customField2(
                "${viewModel.orderItemModel.value.lineitems?.length.toString() ?? "length"} Items"),
            Obx(
              () =>
                  // viewModel.lineItemList.isEmpty
                  //     ? const Center(
                  //         child: Text("No items found"),
                  //       )
                  //     :
                  ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount:
                    viewModel.orderItemModel.value.lineitems?.length ?? 2,
                itemBuilder: (context, index) {
                  return Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    color: const Color(0xFFF9FAFB),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Align(
                            alignment: Alignment.topRight,
                            child: _status(viewModel.orderItemModel.value
                                    .lineitems?[index].fulfilmentStatus ??
                                "status"),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      CustomNetworkImage(
                                        width: 40,
                                        height: 40,
                                        imageUrl: viewModel.orderItemModel.value
                                                .lineitems?[index].media ??
                                            'assets/images/image_not_found.png',
                                        shape: BoxShape.rectangle,
                                      ),
                                      const SizedBox(
                                        width: 16,
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          _customField2(viewModel
                                                  .orderItemModel
                                                  .value
                                                  .lineitems?[index]
                                                  .name ??
                                              "product name"),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                top: 6.0, bottom: 12.0),
                                            child: _customField1(viewModel
                                                    .orderItemModel
                                                    .value
                                                    .orderId
                                                    ?.toString() ??
                                                "Vendor"),
                                          ),
                                          _customField1(
                                              "Color: ${viewModel.orderItemModel.value.lineitems?[index].sku.toString() ?? "color"}"),
                                          _customField1(
                                              "Size: ${viewModel.orderItemModel.value.lineitems?[index].sku.toString() ?? "size"}"),
                                        ],
                                      ),
                                    ],
                                  ),
                                  if (viewModel.orderItemModel.value
                                          .lineitems?[index].fulfilmentStatus ==
                                      "delivered")
                                    CustomIconTextBtn(
                                      title: "Write a review",
                                      onPressed: () {},
                                      icon: Icons.edit,
                                    )
                                  else
                                    Padding(
                                      padding: const EdgeInsets.only(
                                        top: 16.0,
                                        left: 56.0,
                                      ),
                                      child: (CustomIconTextBtn(
                                        title: "Write a review",
                                        onPressed: () {
                                          showModalBottomSheet(
                                              shape:
                                                  const RoundedRectangleBorder(
                                                borderRadius: BorderRadius.only(
                                                  topLeft: Radius.circular(12),
                                                  topRight: Radius.circular(12),
                                                ),
                                              ),
                                              backgroundColor: Colors.white,
                                              context: context,
                                              builder: (BuildContext context) {
                                                double _rating = 0;
                                                return Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                        top: 12.0,
                                                        right: 12.0,
                                                        left: 12.0,
                                                      ),
                                                      child: Row(
                                                        children: [
                                                          const Padding(
                                                            padding:
                                                                EdgeInsets.only(
                                                                    left: 2.0,
                                                                    right:
                                                                        12.0),
                                                            child: Icon(
                                                              Icons.menu,
                                                              color:
                                                                  Colors.black,
                                                            ),
                                                          ),
                                                          const Text(
                                                            "Write a Review",
                                                            // style: newFontStyle2
                                                            //     .copyWith(
                                                            //   color: ThemeHelper
                                                            //       .blue1,
                                                            // ),
                                                          ),
                                                          const Spacer(),
                                                          IconButton(
                                                            icon: const Icon(
                                                              Icons
                                                                  .cancel_outlined,
                                                              color:
                                                                  Colors.black,
                                                            ),
                                                            onPressed: () {
                                                              Navigator.pop(
                                                                  context);
                                                            },
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              left: 16.0,
                                                              right: 16,
                                                              top: 8,
                                                              bottom: 16),
                                                      child: Column(
                                                        children: [
                                                          const CustomText(
                                                            title:
                                                                "Rate the product",
                                                          ),
                                                          const SizedBox(
                                                            height: 12,
                                                          ),
                                                          RatingBar.builder(
                                                            unratedColor:
                                                                Colors.grey,
                                                            initialRating:
                                                                _rating,
                                                            minRating: 0,
                                                            direction:
                                                                Axis.horizontal,
                                                            itemPadding:
                                                                EdgeInsets.all(
                                                                    6),
                                                            itemCount: 5,
                                                            itemSize: 50,
                                                            itemBuilder:
                                                                (context, _) =>
                                                                    Icon(
                                                              _rating == 0
                                                                  ? Icons
                                                                      .star_border_rounded
                                                                  : (_rating >
                                                                          _
                                                                              .toDouble()
                                                                      ? Icons
                                                                          .star
                                                                      : Icons
                                                                          .star_border_rounded),
                                                              color:
                                                                  Colors.amber,
                                                            ),
                                                            onRatingUpdate:
                                                                (rating) {
                                                              _rating = rating;
                                                            },
                                                            tapOnlyMode: true,
                                                          ),
                                                          const CustomTextField1(
                                                            title: "Comment",
                                                            maxLines: 7,
                                                            hintText:
                                                                "Please write your comment here...",
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    // Expanded(
                                                    //   child:
                                                    //       SingleChildScrollView(
                                                    //     child:
                                                    //         _buildBottomSheetContent(),
                                                    //   ),
                                                    // ),
                                                    // Align(
                                                    //   alignment:
                                                    //       Alignment.bottomRight,
                                                    //   child: Padding(
                                                    //     padding:
                                                    //         const EdgeInsets
                                                    //             .only(
                                                    //             left: 16.0,
                                                    //             right: 16,
                                                    //             top: 8,
                                                    //             bottom: 16),
                                                    //     child:
                                                    //         CustomRoundedTextBtn(
                                                    //       title: "Post",
                                                    //       height: 48.v,
                                                    //       width: MediaQuery.of(
                                                    //                   context)
                                                    //               .size
                                                    //               .width *
                                                    //           0.1,
                                                    //       borderRadius: 8.h,
                                                    //       backgroundColor:
                                                    //           ThemeHelper.blue1,
                                                    //       onPressed: () {
                                                    //         Navigator.pop(
                                                    //             context);
                                                    //       },
                                                    //     ),
                                                    //   ),
                                                    // ),
                                                  ],
                                                );
                                              });
                                        },
                                        icon: Icons.edit,
                                        radius: 20,
                                        height: 10,
                                      )),
                                    )
                                ],
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                  top: 50.0,
                                ),
                                child: _customField1(
                                    "Rs. ${viewModel.orderItemModel.value.lineitems?[index].totals?.total?.toStringAsFixed(2) ?? "total"}"),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(
              height: 17,
            ),
            _customField2("Order Information"),
            Container(
              height: MediaQuery.of(ctx).size.height * 0.17,
              width: MediaQuery.of(ctx).size.width * 1,
              padding: const EdgeInsets.all(8),
              margin: const EdgeInsets.only(top: 8),
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: BorderRadius.circular(5),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _customField1(viewModel.orderItemModel.value.lineitems?[0]
                              .assignedRider?.name ??
                          "Shipping Method:"),
                      _customField1(viewModel.orderItemModel.value.lineitems?[0]
                              .assignedRider?.cnic ??
                          "id"),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _customField1(viewModel.orderItemModel.value.lineitems?[0]
                              .assignedRider?.name ??
                          "Payment Method:"),
                      _customField1(viewModel.orderItemModel.value.lineitems?[0]
                              .assignedRider?.cnic ??
                          "id"),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _customField1(viewModel.orderItemModel.value.lineitems?[0]
                              .assignedRider?.name ??
                          "Delivery Method:"),
                      _customField1(viewModel.orderItemModel.value.lineitems?[0]
                              .assignedRider?.cnic ??
                          "id"),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _customField1(viewModel.orderItemModel.value.lineitems?[0]
                              .assignedRider?.name ??
                          "Discount:"),
                      _customField1(
                          viewModel.orderItemModel.value.deliveryStatus ??
                              "id"),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _customField1(viewModel.orderItemModel.value.lineitems?[0]
                              .assignedRider?.name ??
                          "Total Amount:"),
                      _customField1(
                          viewModel.orderItemModel.value.deliveryStatus ??
                              "id"),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _customField1(String text1) {
    return CustomText(
      title: text1.toString(),
      //style: newFontStyle5,
    );
  }

  Widget _customField2(String text) {
    return CustomText(
      title: text,
      style: ThemeHelper.textTheme.titleSmall?.copyWith(
        fontWeight: FontWeight.bold,
        fontSize: 15,
      ),
    );
  }

  Widget _status(String value) {
    Color color = statusColor(value);
    return Text(
      value,
      style: TextStyle(
        color: color,
        fontSize: 10,
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
}
