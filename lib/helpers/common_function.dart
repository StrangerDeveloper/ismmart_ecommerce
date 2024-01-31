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
  // static void closeKeyboard() {
  //   FocusScope.of(Get.context!).requestFocus(FocusNode());
  // }

  static colorConsole(String value) {
    debugPrint('\x1B[32m$value\x1B[0m');
    // Black:   \x1B[30m
    // Red:     \x1B[31m
    // Green:   \x1B[32m
    // Yellow:  \x1B[33m
    // Blue:    \x1B[34m
    // Magenta: \x1B[35m
    // Cyan:    \x1B[36m
    // White:   \x1B[37m
    // Reset:   \x1B[0m
  }

  static debugPrint(Object? object) {
    if (kDebugMode) {
      print(object);
    }
  }


  static showSnackBar( {String? title, String? message,SnackPosition? position}) {
     var bgColor = AppColors.limeGreen;
    var icon = Icons.gpp_good_sharp;
    var titleNew = title;

    if (title!.toLowerCase().contains('error')) {
      titleNew = "Oops!";
     bgColor = AppColors.red;
      icon = Icons.error_outline;
    }

    var messageNew = message;
    // if (message.toString().toLowerCase().contains(SESSION_EXPIRED)) {
    //   messageNew =
    //       "Your session has expired. For security reasons, please sign in again to continue.";
    // } else if (message.toString().toLowerCase().contains(INVALID_USER)) {
    //   messageNew =
    //       "We're sorry, but we couldn't recognize that user. Please double-check and try again, or contact support for assistance.";
    // }

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
}
