import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_workers/utils/debouncer.dart';
import 'package:ismmart_ecommerce/helpers/app_colors.dart';

class CommonFunction {
  // static logout() {
  //   GetStorage().write('token', '');
  //   GetStorage().write('status', '');
  //   Get.offAll(() => LogInView());
  // }

  static final Debouncer debouncer =
      Debouncer(delay: const Duration(milliseconds: 800));

  // static DateTime convertStringToDate(String stringDate) {
  //   return DateFormat("yyyy-MM-dd hh:mm:ss").parse(stringDate);
  // }
  //
  // static String convertTimeStampToTime(String stringDate) {
  //   DateTime date = DateTime.fromMillisecondsSinceEpoch(int.parse(stringDate));
  //   return DateFormat("yyyy-MM-dd hh:mm a").format(date);
  // }
  //
  // static String formatDateTime(String dateTime) {
  //   DateTime date = DateFormat("yyyy-MM-ddThh:mm:ss.000000Z").parse(dateTime);
  //   return DateFormat('yyyy-MM-dd hh:mm a').format(date);
  // }

  // static String formattedDataTime(String customFormat, DateTime timestamp) {
  //   var date =
  //       DateTime.fromMicrosecondsSinceEpoch(timestamp.microsecondsSinceEpoch);
  //
  //   return DateFormat(customFormat).format(date);
  // }
  //
  // static String convertDateFormat(String stringDate,
  //     {format = 'dd MMM, yyyy'}) {
  //   DateTime inputDate = DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'")
  //       .parseUtc(stringDate)
  //       .toLocal();
  //   String outputDate = DateFormat(format).format(inputDate);
  //   return outputDate;
  // }
  //
  static void closeKeyboard() {
    FocusScope.of(Get.context!).requestFocus(FocusNode());
  }


  static debugPrint(Object? object) {
    if (kDebugMode) {
      print(object);
    }
  }

  static showBottomSheet({
    List? itemsList,
    int? selectedIndex,
    required BuildContext context,
    final void Function(int)? onChanged,
  }) {
    int tempIndex = 0;
    Get.bottomSheet(
      Container(
        height: 250,
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
                  initialItem: selectedIndex ?? 0,
                ),
                itemExtent: 40,
                onSelectedItemChanged: (int index) {
                  tempIndex = index;
                },
                children: List.generate(
                  (itemsList ?? []).length,
                  (int index) {
                    return Center(
                      child: Text(
                        itemsList != null ? itemsList[index].name! : '',
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
                onChanged!(tempIndex);
                Get.back();
              },
              child: const Text(
                'Done',
                style: TextStyle(fontSize: 14),
              ),
            ),
          ],
        ),
      ),
    );
  }

  static showSnackBar(
      {String? title, String? message, SnackPosition? position}) {
    Color bgColor = AppColors.green;
    var icon = Icons.gpp_good_sharp;
    var titleNew = title;

    if (title!.toLowerCase().contains('error')) {
      titleNew = "Oops!";
      bgColor = AppColors.red;
      icon = Icons.error_outline;
    }

    var messageNew = message;

    Get.snackbar(titleNew!.capitalizeFirst!.toString(), messageNew.toString(),
        duration: const Duration(milliseconds: 1000),
        snackPosition: position ?? SnackPosition.TOP,
        backgroundColor: bgColor,
        icon: Icon(
          icon,
          color: AppColors.white,
        ),
        colorText: AppColors.white);
  }

  static String calculatePercentage2(num priceParam, num discountParam) {
    double percentage = double.tryParse(discountParam.toString()) ?? 0.0;
    double price = double.tryParse(priceParam.toString()) ?? 0.0;
    double finalPrice = price - (price * (percentage/100));
    return finalPrice.toString();
  }
}
