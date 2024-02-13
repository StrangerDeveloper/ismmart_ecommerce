import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:ismmart_ecommerce/helpers/common_function.dart';
import 'package:ismmart_ecommerce/screens/bottom_navigation/bottom_navigation_view.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import '../../../helpers/api_base_helper.dart';
import '../../../helpers/global_variables.dart';
import '../../../helpers/urls.dart';

class LogInViewModel extends GetxController {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  GlobalKey<FormState> signInFormKey = GlobalKey<FormState>();
  RxBool obscurePassword = true.obs;

  @override
  void onReady() async {
    // NotificationsServices.permissonRequest();
    // NotificationsServices.firebaseInit(Get.context!);
    // NotificationsServices.setupInteractMessage(Get.context!);
    // NotificationsServices.forgroundMessage();
    // NotificationsServices.tokenRefresh();
    // NotificationsServices.getToken();

  
    super.onReady();
  }

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    // GlobalVariable.showLoader.value = false;
    super.onClose();
  }

  void signIn() {
    GlobalVariable.noInternet(false);
    if (signInFormKey.currentState?.validate() ?? false) {
      Map<String, dynamic> param = {
        "email": emailController.text,
        "password": passwordController.text,
      };

      GlobalVariable.showLoader.value = true;

      ApiBaseHelper()
          .postMethod(url: Urls.login, body: param)
          .then((parsedJson) async {
        if (parsedJson['success'] == true) {
          GlobalVariable.showLoader.value = false;
          GlobalVariable.token = parsedJson['data']['token'];
          Get.offAll(() => BottomNavigationView());
        } else if (parsedJson['message'] == 'Invalid credentials') {
          CommonFunction.showSnackBar(
            title: "Error",
            message: "Wrong Credential",
          );

          GlobalVariable.showLoader.value = false;
        } else {
          CommonFunction.showSnackBar(
            title: "Error",
            message: parsedJson['message'],
          );

          GlobalVariable.showLoader.value = false;
        }
      }).catchError((e) {
        CommonFunction.showSnackBar(
          title: "Error",
          message: e.toString(),
        );
        GlobalVariable.showLoader.value = false;
      });
    }
  }

  final googleSignin = GoogleSignIn();
  GoogleSignInAccount? _user;
  GoogleSignInAccount get user => _user!;
  Future googleLogIn() async {
    GlobalVariable.showLoader.value = true;
    GoogleSignIn googleSignIn = GoogleSignIn(
      scopes: [
        'email',
        'https://www.googleapis.com/auth/contacts.readonly',
      ],
    );
    GoogleSignInAccount? credential;
    try {
      // Get.to(DrawerBottomBarView());
      await googleSignIn.signOut();
      credential = await googleSignIn.signIn();
      GlobalVariable.showLoader.value = false;

      credential?.authentication.then((value) async {
        Map<dynamic, dynamic> param = {
          "social": {
            "name": "Google",
            "token": '${value.accessToken}',
          }
        };
        CommonFunction.debugPrint(credential);

        await ApiBaseHelper()
            .postMethod(url: Urls.login, body: param)
            .then((parsedJson) {
          if (parsedJson['success'] == true) {
            GlobalVariable.token = parsedJson['data']['token'];
            GlobalVariable.showLoader.value = false;
          } else {
            GlobalVariable.showLoader.value = false;
            // AppConstant.displaySnackBar(
            //   "Error",
            //   '${parsedJson['message']}',
            // );
          }
        });
      });
    } catch (error) {
      CommonFunction.debugPrint(error);
      GlobalVariable.showLoader.value = false;
      //  debugPrint("$error");
    }
    update();
    // debugPrint("google signin Credential ===> ${credential}");
  }

  appleSignin() async {
    if (Platform.isIOS) {
      final appleCredential = await SignInWithApple.getAppleIDCredential(
        scopes: [
          AppleIDAuthorizationScopes.email,
          AppleIDAuthorizationScopes.fullName,
          AppleIDAuthorizationScopes.values[0],
        ],
      );
      appleCredential.state;

      try {
        // Map<dynamic, dynamic> param = {
        //   "social": {
        //     "name": "Apple",
        //     "token": '${appleCredential.identityToken}',
        //   }
        // };

        // await ApiBaseHelper()
        //     .postMethod(url: " Urls.login", body: param)
        //     .then((parsedJson) {
        //   if (parsedJson['success'] == true) {
        //     String status = parsedJson['data']['status'] ?? "";
        //     accountStatusCheck(status, emailController.text);
        //     GlobalVariable.showLoader.value = false;
        //     GlobalVariable.token = parsedJson['data']['token'];
        //     GlobalVariable.showLoader.value = false;
        //   } else {
        //     GlobalVariable.showLoader.value = false;
        //     // AppConstant.displaySnackBar(
        //     //   "Error",
        //     //   'Account not found',
        //     // );
        //   }
        // });
      } catch (error) {
        GlobalVariable.showLoader.value = false;
      }

      // Now send the credential (especially `credential.authorizationCode`) to your server to create a session
      // after they have bee n validated with Apple (see `Integration` section for more information on how to do this)
    }
  }

  resetValues() {
    emailController.clear();
    passwordController.clear();
  }
}
