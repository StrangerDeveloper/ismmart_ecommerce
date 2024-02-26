import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../../../helpers/app_strings.dart';
import '../../../screens/order/order_details/order_detail_model.dart';
import '../../../helpers/app_colors.dart';
import '../../../widgets/custom_popup.dart';
import 'order_detail_viewmodel.dart';
import '../../../helpers/theme_helper.dart';
import '../../../widgets/custom_appbar.dart';
import '../../../widgets/custom_button.dart';
import '../../../widgets/custom_network_image.dart';
import '../../../widgets/custom_text.dart';
import '../../../widgets/custom_textfield.dart';
import '../../../widgets/pick_image.dart';

class OrderDetailView extends StatelessWidget {
  final OrderDetailViewModel viewModel = Get.put(OrderDetailViewModel());
  OrderDetailView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar2(
        title: "Order Details",
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
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 17, bottom: 17),
                    child: _buildOrderListFrame(),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: _buildOrderDetail(context),
                  ),
                  _buildOrderInfo(context),
                ],
              ),
            ),
          ),
          //const LoaderView(),
        ],
      ),
    );
  }

  Widget _buildOrderListFrame() {
    return Padding(
      padding: const EdgeInsets.only(left: 8, right: 8),
      child: Column(
        children: [
          Row(
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
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              RichText(
                text: TextSpan(
                  children: [
                    const TextSpan(
                      text: "Tracking number: ",
                      style: TextStyle(
                        color: AppColors.grey2,
                        fontSize: 15,
                      ),
                    ),
                    TextSpan(
                      text:
                          viewModel.orderItemModel.value.deliveryStatus ?? "TN",
                      style: ThemeHelper.textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                        color: AppColors.black,
                      ),
                    ),
                  ],
                ),
              ),
              _status(
                  viewModel.orderItemModel.value.deliveryStatus ?? "status"),
            ],
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
            _customField2("${viewModel.lineItemList.length.toString()} Items"),
            Padding(
              padding: const EdgeInsets.only(top: 10.0, bottom: 17.0),
              child: Obx(
                () => viewModel.lineItemList.isEmpty
                    ? const Center(
                        child: Text(
                          "No items found",
                          style: TextStyle(fontSize: 20, color: Colors.black),
                        ),
                      )
                    : ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: viewModel.lineItemList.length,
                        itemBuilder: (context, index) {
                          Lineitems lineitems = viewModel.lineItemList[index];
                          return _listViewItem(context, lineitems);
                        },
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _listViewItem(BuildContext context, Lineitems? model) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: AppColors.white,
        boxShadow: const [
          BoxShadow(
            color: AppColors.grey1,
            blurRadius: 10,
            offset: Offset(0, 0),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            Align(
              alignment: Alignment.topRight,
              child: _status(model?.deliveryStatus ?? "status"),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    CustomNetworkImage(
                      width: 40,
                      height: 40,
                      imageUrl: model?.media?[0].url ??
                          'assets/images/image_not_found.png',
                      shape: BoxShape.rectangle,
                    ),
                    const SizedBox(
                      width: 16,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _customField2(model?.name ?? "product name"),
                        Padding(
                          padding:
                              const EdgeInsets.only(top: 6.0, bottom: 12.0),
                          child: _customField1(model?.storeName ?? "Vendor"),
                        ),
                        Row(
                          children: model?.options?.map((e) {
                                return Padding(
                                    padding: const EdgeInsets.only(right: 8.0),
                                    child: RichText(
                                      text: TextSpan(
                                        children: [
                                          TextSpan(
                                            text: "Options: ",
                                            style: ThemeHelper
                                                .textTheme.bodySmall
                                                ?.copyWith(
                                              color: AppColors.grey2,
                                            ),
                                          ),
                                          TextSpan(
                                            text: e,
                                            style: ThemeHelper
                                                .textTheme.bodySmall
                                                ?.copyWith(
                                              color: AppColors.black,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ));
                              }).toList() ??
                              [],
                        ),

                        //                 ?.copyWith(
                        //               color: AppColors.black,
                        //               fontWeight: FontWeight.bold,
                        //             ),
                        //           ),
                        //         ],
                        //       ),
                        //     ),
                        //     const Gap(90),
                        //     _customField2(
                        //         "Rs. ${model.lineItemTotals?.total?.toStringAsFixed(2) ?? "total"}"),
                        //   ],
                        // ),
                      ],
                    ),
                  ],
                ),
                Align(
                  alignment: Alignment.bottomRight,
                  child: _customField2(
                      "Rs. ${model?.lineItemTotals?.total?.toStringAsFixed(2) ?? "total"}"),
                ),
                if (model?.fulfilmentStatus == "delivered")
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 16.0,
                      left: 56.0,
                    ),
                    child: (CustomIconTextBtn(
                      title: "Write a review",
                      onPressed: () {
                        showModalBottomSheet(
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(12),
                              topRight: Radius.circular(12),
                            ),
                          ),
                          backgroundColor: Colors.white,
                          context: context,
                          builder: (BuildContext context) {
                            double rating = 0;
                            return SingleChildScrollView(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  _buildHeader(context),
                                  _buildRatingSection(rating),
                                  _buildCommentSection(),
                                  _buildPhotoSection(),
                                  _buildLeaveReviewButton(),
                                  const SizedBox(height: 20)
                                ],
                              ),
                            );
                          },
                        );
                      },
                      icon: Icons.edit,
                      radius: 20,
                      height: 10,
                    )),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOrderInfo(BuildContext ctx) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _customField2("Order Information"),
          const SizedBox(height: 15),
          _customOrderInfo(
            text1: "Shipping Address:",
            text2: viewModel.orderItemModel.value.address?.shipping?.address ??
                "Home, Chino Hills, CA 91709, USA",
          ),
          _customOrderInfo(
            text1: "Payment Method:",
            text2: viewModel.orderItemModel.value.paymentType ?? "COD",
          ),
          _customOrderInfo(
            text1: "Delivery Method:",
            text2: "Leopards, 3 days, 15",
          ),
          _customOrderInfo(
            text1: "Discount:",
            text2: viewModel.orderItemModel.value.totals?.discount.toString() ??
                "10%, Personal promo code",
          ),
          _customOrderInfo(
            text1: "Total Amount:",
            text2:
                "${viewModel.orderItemModel.value.totals?.total.toString() ?? "133"} Rs",
          ),
        ],
      ),
    );
  }

  Widget _customOrderInfo({required String text1, required String text2}) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: _customField1(text1),
          ),
          Expanded(
            child: _customField2(text2),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        top: 12.0,
        right: 12.0,
        left: 12.0,
      ),
      child: Row(
        children: [
          const Padding(
            padding: EdgeInsets.only(left: 2.0, right: 12.0),
            child: Icon(
              Icons.menu,
              color: Colors.black,
            ),
          ),
          CustomText(
              title: "Write a Review",
              style: ThemeHelper.textTheme.titleSmall?.copyWith(
                fontWeight: FontWeight.bold,
                fontSize: 14,
                color: AppColors.black,
              )),
          const Spacer(),
          IconButton(
            icon: const Icon(
              Icons.close,
              color: Colors.red,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }

  Widget _buildRatingSection(double rating) {
    return Padding(
      padding: const EdgeInsets.only(left: 16.0, right: 16, top: 8, bottom: 16),
      child: Column(
        children: [
          CustomText(
            title: "Rate the product",
            textAlign: TextAlign.center,
            style: ThemeHelper.textTheme.titleSmall?.copyWith(
              fontWeight: FontWeight.bold,
              fontSize: 14,
              color: AppColors.black,
            ),
          ),
          const SizedBox(
            height: 12,
          ),
          RatingBar.builder(
            unratedColor: Colors.grey,
            initialRating: rating,
            minRating: 0,
            direction: Axis.horizontal,
            itemPadding: const EdgeInsets.all(6),
            itemCount: 5,
            itemSize: 50,
            itemBuilder: (context, _) => Icon(
              rating == 0
                  ? Icons.star_border_rounded
                  : (rating > _.toDouble()
                      ? Icons.star_rounded
                      : Icons.star_border_rounded),
              color: Colors.amber,
            ),
            onRatingUpdate: (newrating) {
              rating = newrating;
            },
            tapOnlyMode: true,
          ),
        ],
      ),
    );
  }

  Widget _buildCommentSection() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: CustomTextField1(
        title: "Comment",
        maxLines: 7,
        hintText: AppStrings.writeComment,
      ),
    );
  }

  Widget _buildPhotoSection() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: InkWell(
        onTap: () async {
          viewModel.userProfileImage.value =
              await PickImage().pickSingleImage() ?? File('');
        },
        child: Card(
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.black,
                  ),
                  child: const Icon(
                    Icons.camera_alt,
                    color: Colors.white,
                    size: 20,
                  ),
                ),
                const SizedBox(height: 8),
                const CustomText(title: "Add your photos"),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLeaveReviewButton() {
    return Align(
      alignment: Alignment.center,
      child: CustomTextBtn2(
        onPressed: () {
          Get.back();
          showDialog(
            context: Get.context!,
            builder: (BuildContext context) {
              return CustomPopup(
                title: "Done!",
                text: AppStrings.review,
                icon: Icons.check_circle,
              );
            },
          );
        },
        width: 300,
        title: "Leave Review",
        textStyle: GoogleFonts.inter(
          fontSize: 14,
          fontWeight: FontWeight.w500,
          color: Colors.white,
        ),
      ),
    );
  }

  Widget _customField1(String text1) {
    return CustomText(
      title: text1.toString(),
      style: ThemeHelper.textTheme.bodySmall?.copyWith(
        color: AppColors.grey2,
      ),
    );
  }

  Widget _customField2(String text) {
    return CustomText(
      title: text,
      style: ThemeHelper.textTheme.titleSmall?.copyWith(
        fontWeight: FontWeight.bold,
        fontSize: 15,
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
}
