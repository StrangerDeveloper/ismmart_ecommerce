import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:ismmart_ecommerce/helpers/app_strings.dart';
import 'package:ismmart_ecommerce/helpers/common_function.dart';
import 'package:ismmart_ecommerce/helpers/global_variables.dart';
import 'package:ismmart_ecommerce/helpers/urls.dart';

class ApiBaseHelper {
  final String _baseUrl = Urls.baseUrl;
  Map<String, String> header = {
    'Content-Type': 'application/json',
    'Authorization': 'Bearer ${GlobalVariable.token}',
  };

  Future<dynamic> getMethod({required String url}) async {
    try {
      Uri urlValue = Uri.parse(_baseUrl + url);
      CommonFunction.debugPrint(
          '*********************** Request ********************************');
      CommonFunction.debugPrint(urlValue);

      http.Response response = await http
          .get(urlValue, headers: header)
          .timeout(const Duration(seconds: 30));

      CommonFunction.debugPrint(
          '*********************** Response ********************************');
      CommonFunction.debugPrint(urlValue);
      CommonFunction.debugPrint(response.body);
      CommonFunction.colorConsole(
          '****************************************************************************************');

      Map<String, dynamic> parsedJSON = jsonDecode(response.body);
      return parsedJSON;
    } on SocketException catch (e) {
      debugPrint("$e");
      GlobalVariable.showLoader.value = false;
      CommonFunction.showSnackBar(
          title: 'Error', message: AppStrings.noInternetError);
      throw AppStrings.noInternetError;
    } on TimeoutException catch (_) {
      GlobalVariable.showLoader.value = false;
      CommonFunction.showSnackBar(
          title: 'Error', message: AppStrings.timeOutException);
      throw AppStrings.timeOutException;
    } on FormatException catch (_) {
      GlobalVariable.showLoader.value = false;
      CommonFunction.showSnackBar(
          title: 'Error', message: AppStrings.formatException);
      throw AppStrings.formatException;
    } catch (e) {
      GlobalVariable.showLoader.value = false;
      CommonFunction.showSnackBar(
          title: 'Error', message: AppStrings.generalApiError);
      throw e.toString();
    }
  }

  Future<dynamic> getMethodQueryParam({required String url, Map<String, String>? params}) async {
    try {

      Uri urlValue = Uri.parse(_baseUrl + url).replace(queryParameters: params);

      CommonFunction.debugPrint(
          '*********************** Request ********************************');
      CommonFunction.debugPrint(urlValue);

      http.Response response = await http
          .get(urlValue, headers: header)
          .timeout(const Duration(seconds: 30));

      CommonFunction.debugPrint(
          '*********************** Response ********************************');
      CommonFunction.debugPrint(urlValue);
      CommonFunction.debugPrint(response.body);
      CommonFunction.colorConsole(
          '****************************************************************************************');

      Map<String, dynamic> parsedJSON = jsonDecode(response.body);
      return parsedJSON;
    } on SocketException catch (e) {
      debugPrint("$e");
      GlobalVariable.showLoader.value = false;
      CommonFunction.showSnackBar(
          title: 'Error', message: AppStrings.noInternetError);
      throw AppStrings.noInternetError;
    } on TimeoutException catch (_) {
      GlobalVariable.showLoader.value = false;
      CommonFunction.showSnackBar(
          title: 'Error', message: AppStrings.timeOutException);
      throw AppStrings.timeOutException;
    } on FormatException catch (_) {
      GlobalVariable.showLoader.value = false;
      CommonFunction.showSnackBar(
          title: 'Error', message: AppStrings.formatException);
      throw AppStrings.formatException;
    } catch (e) {
      GlobalVariable.showLoader.value = false;
      CommonFunction.showSnackBar(
          title: 'Error', message: AppStrings.generalApiError);
      throw e.toString();
    }
  }

// Future<dynamic> deleteMethod({required String url}) async {
//   try {
//     Uri urlValue = Uri.parse(_baseUrl + url);
//     CommonFunction.debugPrint(
//         '*********************** Request ********************************');
//     CommonFunction.debugPrint(urlValue);
//
//     http.Response response = await http
//         .delete(urlValue, headers: header)
//         .timeout(const Duration(seconds: 30));
//
//     CommonFunction.debugPrint(
//         '*********************** Response ********************************');
//     CommonFunction.debugPrint(urlValue);
//     CommonFunction.debugPrint(response.body);
//     CommonFunction.colorConsole(
//         '****************************************************************************************');
//
//     Map<String, dynamic> parsedJSON = jsonDecode(response.body);
//     return parsedJSON;
//   } on SocketException catch (e) {
//     debugPrint("$e");
//     GlobalVariable.showLoader.value = false;
//     CustomSnackBar.showSnackBar(
//         title: 'Error', message: AppStrings.noInternetError);
//     throw AppStrings.noInternetError;
//   } on TimeoutException catch (_) {
//     GlobalVariable.showLoader.value = false;
//     CustomSnackBar.showSnackBar(
//         title: 'Error', message: AppStrings.timeOutException);
//     throw AppStrings.timeOutException;
//   } on FormatException catch (_) {
//     GlobalVariable.showLoader.value = false;
//     CustomSnackBar.showSnackBar(
//         title: 'Error', message: AppStrings.formatException);
//     throw AppStrings.formatException;
//   } catch (e) {
//     GlobalVariable.showLoader.value = false;
//     CustomSnackBar.showSnackBar(
//         title: 'Error', message: AppStrings.generalApiError);
//     throw e.toString();
//   }
// }

  Future<dynamic> postMethod({
    required String url,
    Object? body,
  }) async {
    try {
      if (body != null) {
        body = jsonEncode(body);
      }
      Uri urlValue = Uri.parse(_baseUrl + url);
      CommonFunction.debugPrint(
          '*********************** Request ********************************');
      CommonFunction.debugPrint(urlValue);
      CommonFunction.debugPrint(body);

      http.Response response = await http
          .post(urlValue, headers: header, body: body)
          .timeout(const Duration(seconds: 30));

      CommonFunction.debugPrint(
          '*********************** Response ********************************');
      CommonFunction.debugPrint(urlValue);
      CommonFunction.debugPrint(response.body);
      CommonFunction.colorConsole(
          '****************************************************************************************');

      Map<String, dynamic> parsedJSON = jsonDecode(response.body);
      return parsedJSON;
    } on SocketException catch (_) {
      GlobalVariable.showLoader.value = false;
      CommonFunction.showSnackBar(
          title: 'Error', message: AppStrings.noInternetError);
      throw AppStrings.noInternetError;
    } on TimeoutException catch (_) {
      GlobalVariable.showLoader.value = false;
      CommonFunction.showSnackBar(
          title: 'Error', message: AppStrings.timeOutException);
      throw AppStrings.timeOutException;
    } on FormatException catch (_) {
      GlobalVariable.showLoader.value = false;
      CommonFunction.showSnackBar(
          title: 'Error', message: AppStrings.formatException);
      throw AppStrings.formatException;
    } catch (e) {
      GlobalVariable.showLoader.value = false;
      CommonFunction.showSnackBar(
          title: 'Error', message: AppStrings.generalApiError);
      throw e.toString();
    }
  }

  Future<dynamic> putMethod({
    required String url,
    Object? body,
  }) async {
    try {
      if (body != null) {
        body = jsonEncode(body);
      }
      Uri urlValue = Uri.parse(_baseUrl + url);
      CommonFunction.debugPrint(
          '*********************** Request ********************************');
      CommonFunction.debugPrint(urlValue);
      CommonFunction.debugPrint(body);

      http.Response response = await http
          .put(urlValue, headers: header, body: body)
          .timeout(const Duration(seconds: 30));

      CommonFunction.debugPrint(
          '*********************** Response ********************************');
      CommonFunction.debugPrint(urlValue);
      CommonFunction.debugPrint(response.body);
      CommonFunction.colorConsole(
          '****************************************************************************************');

      Map<String, dynamic> parsedJSON = jsonDecode(response.body);
      return parsedJSON;
    } on SocketException catch (_) {
      GlobalVariable.showLoader.value = false;
      CommonFunction.showSnackBar(
          title: 'Error', message: AppStrings.noInternetError);
      throw AppStrings.noInternetError;
    } on TimeoutException catch (_) {
      GlobalVariable.showLoader.value = false;
      CommonFunction.showSnackBar(
          title: 'Error', message: AppStrings.timeOutException);
      throw AppStrings.timeOutException;
    } on FormatException catch (_) {
      GlobalVariable.showLoader.value = false;
      CommonFunction.showSnackBar(
          title: 'Error', message: AppStrings.formatException);
      throw AppStrings.formatException;
    } catch (e) {
      GlobalVariable.showLoader.value = false;
      CommonFunction.showSnackBar(
          title: 'Error', message: AppStrings.generalApiError);
      throw e.toString();
    }
  }

  Future<dynamic> postMethodForImage({
    required String url,
    required List<http.MultipartFile> files,
    required Map<String, String> fields,
  }) async {
    try {
      Uri urlValue = Uri.parse(_baseUrl + url);
      debugPrint(
          '*********************** Request ********************************');
      debugPrint("$urlValue");

      http.MultipartRequest request = http.MultipartRequest('POST', urlValue);
      request.headers.remove('Content-Type');
      request.headers.addAll({
        'Content-Type': 'multipart/form-data',
        'Authorization': 'Bearer ${GlobalVariable.token}',
      });
      request.fields.addAll(fields);
      request.files.addAll(files);

      http.StreamedResponse response = await request.send();
      Map<String, dynamic> parsedJson =
          await jsonDecode(await response.stream.bytesToString());

      debugPrint(
          '*********************** Response ********************************');
      debugPrint("$urlValue");
      debugPrint(parsedJson.toString());
      CommonFunction.colorConsole(
          '****************************************************************************************');
      return parsedJson;
    } on SocketException catch (_) {
      GlobalVariable.showLoader.value = false;
      GlobalVariable.noInternet(true);
      //CommonFunction.showSnackBar(titlege)(title, message: AppStrings.noInternetError);
      throw AppStrings.noInternetError;
    } on TimeoutException catch (_) {
      GlobalVariable.showLoader.value = false;
      CommonFunction.showSnackBar(
          title: 'Error', message: AppStrings.timeOutException);
      throw AppStrings.timeOutException;
    } on FormatException catch (_) {
      GlobalVariable.showLoader.value = false;
      CommonFunction.showSnackBar(
          title: 'Error', message: AppStrings.formatException);
      throw AppStrings.formatException;
    } catch (e) {
      GlobalVariable.showLoader.value = false;
      CommonFunction.showSnackBar(
          title: 'Error', message: AppStrings.generalApiError);
      throw e.toString();
    }
  }

// Future<dynamic> putMethodForImage({
//   required String url,
//   required List<http.MultipartFile> files,
//   required Map<String, String> fields,
// }) async {
//   try {
//     Uri urlValue = Uri.parse(_baseUrl + url);
//     debugPrint('*********************** Request ********************************');
//     debugPrint("$urlValue");
//
//     http.MultipartRequest request = http.MultipartRequest('PUT', urlValue);
//     request.headers.addAll(header);
//     request.fields.addAll(fields);
//     request.files.addAll(files);
//     http.StreamedResponse response = await request.send();
//     Map<String, dynamic> parsedJson =
//     await jsonDecode(await response.stream.bytesToString());
//
//     debugPrint(
//         '*********************** Response ********************************');
//     debugPrint("$urlValue");
//     debugPrint(parsedJson.toString());
//     CommonFunction.colorConsole(
//         '****************************************************************************************');
//     return parsedJson;
//   } on SocketException catch (_) {
//     GlobalVariable.showLoader.value = false;
//     GlobalVariable.noInternet(true);
//     //CommonFunction.showSnackBar(titlege)(title, message: AppStrings.noInternetError);
//     throw AppStrings.noInternetError;
//   } on TimeoutException catch (_) {
//     GlobalVariable.showLoader.value = false;
//     CommonFunction.showSnackBar('Error', AppStrings.timeOutException);
//     throw AppStrings.timeOutException;
//   } on FormatException catch (_) {
//     GlobalVariable.showLoader.value = false;
//     CommonFunction.showSnackBar('Error', AppStrings.formatException);
//     throw AppStrings.formatException;
//   } catch (e) {
//     GlobalVariable.showLoader.value = false;
//     CommonFunction.showSnackBar('Error', AppStrings.generalApiError);
//     throw e.toString();
//   }
// }
//
}
