import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import '../../../helpers/api_base_helper.dart';
import '../../../helpers/global_variables.dart';

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

    // TODO: implement onReady
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
          .postMethod(url: "Urls.login", body: param)
          .then((parsedJson) async {
        if (parsedJson['success'] == true) {
          GlobalVariable.showLoader.value = false;
          print(parsedJson['data']['token']);
          GetStorage().write('token', parsedJson['data']['token']);
          GetStorage().write('status', parsedJson['data']['status']);
          GlobalVariable.token = parsedJson['data']['token'];
          String status = parsedJson['data']['status'] ?? "";
          accountStatusCheck(status, emailController.text);
        } else if (parsedJson['message'] == 'Invalid credentials') {
          // AppConstant.displaySnackBar(
          //   "Error",
          //   "Wrong Credential",
          // );

          GlobalVariable.showLoader.value = false;
        } else {
          // AppConstant.displaySnackBar(
          //   "Error",
          //   parsedJson['message'],
          // );

          GlobalVariable.showLoader.value = false;
        }
      }).catchError((e) {
        // AppConstant.displaySnackBar(
        //   "Error",
        //   e.toString(),
        // );
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
        print(credential);
        print(value);

        await ApiBaseHelper()
            .postMethod(url: "Urls.login", body: param)
            .then((parsedJson) {
          if (parsedJson['success'] == true) {
            String status = parsedJson['data']['status'] ?? "";
            accountStatusCheck(status, emailController.text);
            GlobalVariable.showLoader.value = false;
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
      print(error);
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
        Map<dynamic, dynamic> param = {
          "social": {
            "name": "Apple",
            "token": '${appleCredential.identityToken}',
          }
        };

        await ApiBaseHelper()
            .postMethod(url: " Urls.login", body: param)
            .then((parsedJson) {
          if (parsedJson['success'] == true) {
            String status = parsedJson['data']['status'] ?? "";
            accountStatusCheck(status, emailController.text);
            GlobalVariable.showLoader.value = false;
            GlobalVariable.token = parsedJson['data']['token'];
            GlobalVariable.showLoader.value = false;
          } else {
            GlobalVariable.showLoader.value = false;
            // AppConstant.displaySnackBar(
            //   "Error",
            //   'Account not found',
            // );
          }
        });
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

  // ----------  Status Enums Check of Account-------
  accountStatusCheck(String status, String email) {
    // if (status == "Approved") {
    //   Get.offAll(() => DrawerBottomBarView());
    // } else if (status == "Rejected") {
    //   var param = {
    //     'status': 'Rejected',
    //     'remarks': 'due to wrong id card',
    //     'email': ''
    //   };
    //   Get.offAll(() => AccountStatusView(), arguments: param);
    // } else if (status == "Pending") {
    //   var param = {
    //     'status': 'Pending',
    //   };
    //   Get.offAll(() => AccountStatusView(), arguments: param);
    // } else if (status == "Not Verified") {
    //   var param = {
    //     'status': 'Not Verified',
    //     'remarks': 'due to verify by your Gmail / Email Account',
    //     'email': email
    //   };
    //   Get.offAll(() => AccountStatusView(), arguments: param);
    // }
  }
}
