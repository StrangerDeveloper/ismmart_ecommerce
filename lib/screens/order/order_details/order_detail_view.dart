import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:ismmart_ecommerce/helpers/app_strings.dart';

import '../../../helpers/app_colors.dart';
import '../../../widgets/custom_popup.dart';
import 'order_detail_viewmodel.dart';
import '../../../helpers/theme_helper.dart';
import '../../../widgets/custom_appbar.dart';
import '../../../widgets/custom_button.dart';
import '../../../widgets/custom_network_image.dart';
import '../../../widgets/custom_text.dart';
import '../../../widgets/custom_textfield.dart';
import '../../../widgets/loader_view.dart';
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
          const LoaderView(),
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
                // child: _customField2(
                //     "Tracking Number: ${viewModel.orderItemModel.value.orderId ?? "TN"}"),
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
            _customField2(
                "${viewModel.orderItemModel.value.lineitems?.length.toString() ?? "length"} Items"),
            Padding(
              padding: const EdgeInsets.only(top: 10.0, bottom: 17.0),
              child: Obx(
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
                    return _listViewItem(context, index);
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _listViewItem(BuildContext context, int index) {
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
              child: _status(viewModel.orderItemModel.value.lineitems?[index]
                      .fulfilmentStatus ??
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
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _customField2(viewModel.orderItemModel.value
                                    .lineitems?[index].name ??
                                "product name"),
                            Padding(
                              padding:
                                  const EdgeInsets.only(top: 6.0, bottom: 12.0),
                              child: _customField1(viewModel
                                      .orderItemModel.value.orderId
                                      ?.toString() ??
                                  "Vendor"),
                            ),
                            RichText(
                                text: TextSpan(children: [
                              TextSpan(
                                text: "Color: ",
                                style:
                                    ThemeHelper.textTheme.bodySmall?.copyWith(
                                  color: AppColors.grey2,
                                ),
                              ),
                              TextSpan(
                                text: viewModel.orderItemModel.value
                                        .lineitems?[index].sku
                                        ?.toString() ??
                                    "color",
                                style:
                                    ThemeHelper.textTheme.bodySmall?.copyWith(
                                  color: AppColors.black,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ])),
                            // _customField1(
                            //     "Color: ${viewModel.orderItemModel.value.lineitems?[index].sku.toString() ?? "color"}"),
                            // _customField1(
                            //     "Size: ${viewModel.orderItemModel.value.lineitems?[index].sku.toString() ?? "size"}"),
                            RichText(
                                text: TextSpan(children: [
                              TextSpan(
                                text: "Size: ",
                                style:
                                    ThemeHelper.textTheme.bodySmall?.copyWith(
                                  color: AppColors.grey2,
                                ),
                              ),
                              TextSpan(
                                text: viewModel.orderItemModel.value
                                        .lineitems?[index].sku
                                        ?.toString() ??
                                    "size",
                                style:
                                    ThemeHelper.textTheme.bodySmall?.copyWith(
                                  color: AppColors.black,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ])),
                          ],
                        ),
                      ],
                    ),
                    if (viewModel.orderItemModel.value.lineitems?[index]
                            .fulfilmentStatus ==
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
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
                Padding(
                  padding: const EdgeInsets.only(
                    top: 60.0,
                  ),
                  child: _customField2(
                      "Rs. ${viewModel.orderItemModel.value.lineitems?[index].totals?.total?.toStringAsFixed(2) ?? "total"}"),
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
          Row(
            //mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: _customField1(viewModel.orderItemModel.value
                        .lineitems?[0].assignedRider?.name ??
                    "Shipping Method:"),
              ),
              Expanded(
                child: _customField2(viewModel.orderItemModel.value
                        .lineitems?[0].assignedRider?.cnic ??
                    "Home, Chino Hills, CA 91709, USA"),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: _customField1(viewModel.orderItemModel.value
                        .lineitems?[0].assignedRider?.name ??
                    "Payment Method:"),
              ),
              Expanded(
                child: _customField2(viewModel.orderItemModel.value
                        .lineitems?[0].assignedRider?.cnic ??
                    "COD"),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: _customField1(viewModel.orderItemModel.value
                        .lineitems?[0].assignedRider?.name ??
                    "Delivery Method:"),
              ),
              Expanded(
                child: _customField2(viewModel.orderItemModel.value
                        .lineitems?[0].assignedRider?.cnic ??
                    "Leopards, 3 days, 15"),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: _customField1(viewModel.orderItemModel.value
                        .lineitems?[0].assignedRider?.name ??
                    "Discount:"),
              ),
              Expanded(
                child: _customField2(
                    viewModel.orderItemModel.value.deliveryStatus ??
                        "10%, Personal promo code"),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: _customField1(viewModel.orderItemModel.value
                        .lineitems?[0].assignedRider?.name ??
                    "Total Amount:"),
              ),
              Expanded(
                child: _customField2(
                    viewModel.orderItemModel.value.deliveryStatus ?? "133"),
              ),
            ],
          )
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
      value,
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
