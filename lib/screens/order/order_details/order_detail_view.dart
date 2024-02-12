import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:ismmart_ecommerce/screens/order/order_details/order_detail_viewModel.dart';

import '../../../helpers/theme_helper.dart';
import '../../../widgets/custom_appbar.dart';
import '../../../widgets/custom_button.dart';
import '../../../widgets/custom_network_image.dart';
import '../../../widgets/custom_text.dart';
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
                    // _customField2(
                    //   DateFormat("y MMM d").format(
                    //     DateTime.parse(
                    //         viewModel.orderItemModel.value.createdAt ?? "now"),
                    //   ),
                    // ),
                    // Padding(
                    //   padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
                    //   child: Icon(
                    //     Icons.circle,
                    //     color: Colors.grey.shade400,
                    //     size: 5,
                    //   ),
                    // ),
                    // _customField2(
                    //     "${DateFormat("y MMM d").format(DateTime.parse(viewModel.orderItemModel.value.createdAt!))} at ${DateFormat("h:mm a").format(DateTime.parse(viewModel.orderItemModel.value.createdAt!))}"),
                    // SizedBox(width: 8),
                  ],
                ),
                _customField2(viewModel
                            .orderItemModel.value.orderDetails?.market !=
                        null
                    ? '${viewModel.orderItemModel.value.orderDetails?.market!} Store'
                    : 'status'),
              ],
            ),
            // Padding(
            //   padding: const EdgeInsets.only(top: 10, bottom: 10),
            //   child: Row(
            //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //     children: [
            //       _customField1(viewModel.orderItemModel.value.customer?.name
            //               .toString() ??
            //           "name"),
            //       _customField1(
            //           "Rs. ${viewModel.orderItemModel.value.totals?.total?.toStringAsFixed(2) ?? "total"}"),
            //     ],
            //   ),
            // ),
            // Row(
            //   children: [
            //     _status(
            //         viewModel.orderItemModel.value.paymentStatus ?? "status"),
            //     SizedBox(width: 8),
            //     _status(viewModel.orderItemModel.value.fulfilmentStatus ??
            //         "status"),
            //   ],
            // ),
            const SizedBox(height: 20),
            // Row(
            //   children: [
            //     _customField2(
            //         "${viewModel.orderItemModel.value.lineitems?.length.toString()} items"),
            //     Padding(
            //       padding: const EdgeInsets.only(right: 8, left: 8),
            //       child: Icon(
            //         Icons.circle,
            //         color: Colors.grey.shade400,
            //         size: 5,
            //       ),
            //     ),
            //     _customField2("Standard")
            //   ],
            // ),
            // Padding(
            //     padding: const EdgeInsets.only(top: 8, bottom: 8),
            //     child: _status("COD Verified")),
            // _customField1("Location"),
            // Padding(
            //   padding: const EdgeInsets.only(top: 8, bottom: 8),
            //   child: _customField2(
            //       "Plot No. 60, Street 12, G-8/1,Islamabad Capital Territory 44080\nPakistan"),
            // ),
            //_buildFrame2(),
            const SizedBox(width: 8),
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
                                  // _status(viewModel
                                  //         .orderItemModel
                                  //         .value
                                  //         .lineitems?[index]
                                  //         .fulfilmentStatus ??
                                  //     "status"),
                                  // const SizedBox(
                                  //   height: 8,
                                  // ),
                                  Row(
                                    children: [
                                      CustomNetworkImage(
                                        width: 40,
                                        height: 40,
                                        imageUrl: viewModel.orderItemModel.value
                                                .lineitems?[index].media ??
                                            'assets/images/image_not_found.png',
                                        shape: BoxShape.rectangle,
                                        // assetsImage: const AssetImage(
                                        //     'assets/images/image_not_found.png'),
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
                                  //if status is delivered than show the review button
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
                                        onPressed: () {},
                                        icon: Icons.edit,
                                        radius: 20,
                                        height: 10,
                                      )),
                                    )
                                  // Padding(
                                  //   padding: const EdgeInsets.only(
                                  //     top: 16.0,
                                  //     left: 56.0,
                                  //   ),
                                  //   child: _customField2(
                                  //       "Rs. ${viewModel.orderItemModel.value.lineitems?[index].totals?.total.toString()}  x ${viewModel.orderItemModel.value.lineitems?[index].qty?.toString()}"),
                                  // ),
                                  // const SizedBox(
                                  //   height: 12,
                                  // )
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
            // Container(
            //   decoration: const BoxDecoration(
            //     //color: ThemeHelper.grey3,
            //     borderRadius: BorderRadius.only(
            //       bottomLeft: Radius.circular(5),
            //       bottomRight: Radius.circular(5),
            //     ),
            //   ),
            //   padding: const EdgeInsets.all(
            //     8.0,
            //   ),
            //   child: Column(
            //     children: [
            //       Row(
            //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //         children: [
            //           _customField3("Sub Total"),
            //           SizedBox(width: 8),
            //           _customField2(
            //               "Rs. ${viewModel.orderItemModel.value.totals?.subTotal?.toStringAsFixed(2) ?? "0"}"),
            //         ],
            //       ),
            //       Padding(
            //         padding: const EdgeInsets.only(top: 8, bottom: 8),
            //         child: Row(
            //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //           children: [
            //             _customField3("Shipping Fee"),
            //             SizedBox(
            //               width: 8,
            //             ),
            //             _customField2(
            //                 "Rs. ${viewModel.orderItemModel.value.totals?.shipping?.toStringAsFixed(2) ?? "0"}"),
            //           ],
            //         ),
            //       ),
            //       Row(
            //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //         children: [
            //           _customField3("Sales Tax"),
            //           SizedBox(
            //             width: 8,
            //           ),
            //           _customField2(
            //               "Rs. ${viewModel.orderItemModel.value.totals?.tax?.toStringAsFixed(2) ?? "0"}"),
            //         ],
            //       ),
            //       Padding(
            //         padding: const EdgeInsets.only(top: 8, bottom: 8),
            //         child: Row(
            //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //           children: [
            //             _customField3("Promo Discount"),
            //             SizedBox(width: 8),
            //             _customField2(
            //                 "Rs. ${viewModel.orderItemModel.value.totals?.discount?.toStringAsFixed(2) ?? "0"}"),
            //           ],
            //         ),
            //       ),
            //       Row(
            //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //         children: [
            //           _customField3("Total Amount"),
            //           SizedBox(
            //             width: 8,
            //           ),
            //           _customField2(
            //               "Rs. ${viewModel.orderItemModel.value.totals?.total?.toStringAsFixed(2) ?? "0"}"),
            //         ],
            //       ),
            //     ],
            //   ),
            // ),
            const SizedBox(
              height: 17,
            ),
            _customField2("Order Information"),
            //const Divider(),
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
                  // _status(viewModel.orderItemModel.value.fulfilmentStatus ??
                  //     "status"),
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
      // style: newFontStyleSize12Grey2.copyWith(
      //   color: newColorLightGrey3,
      //   fontWeight: FontWeight.w600,
      // ),
    );
  }

  Widget _customField3(String text1) {
    return CustomText(
      title: text1,
      // style: newFontStyle5.copyWith(
      //   fontWeight: FontWeight.w200,
      // ),
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
