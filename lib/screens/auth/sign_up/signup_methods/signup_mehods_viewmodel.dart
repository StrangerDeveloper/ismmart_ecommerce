import 'dart:io';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:ismmart_ecommerce/helpers/app_routes.dart';
import 'package:ismmart_ecommerce/helpers/common_function.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import '../../../../helpers/api_base_helper.dart';
import '../../../../helpers/global_variables.dart';
import '../../../../helpers/urls.dart';

class SignupMehtodViewModel extends GetxController {
  RxString socialName = ''.obs;
  RxString socialEmail = ''.obs;
  RxString socialToken = ''.obs;
  RxString socialPlatform = ''.obs;

  // ----------Google singin---------
  final googleSignin = GoogleSignIn();
  GoogleSignInAccount? _user;
  GoogleSignInAccount get user => _user!;
  Future<void> googleLogIn() async {
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
          'provider': 'Google',
          "token": '${value.accessToken}',
        };
        CommonFunction.debugPrint(credential);

        await ApiBaseHelper()
            .postMethod(url: Urls.socialLogin, body: param)
            .then((parsedJson) {
          _parsedJson = parsedJson;
          if (parsedJson['success'] == true) {
            gotoNextPage();
          } else {
            error();
          }
        });
      });
    } catch (e) {
      error();
    }
    update();
    // debugPrint("google signin Credential ===> ${credential}");
  }

  Future<void> appleSignin() async {
    if (Platform.isIOS) {
      GlobalVariable.showLoader.value = true;

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
          'provider': 'Apple',
          "token": '${appleCredential.identityToken}',
        };

        await ApiBaseHelper()
            .postMethod(url: Urls.socialLogin, body: param)
            .then((parsedJson) {
          _parsedJson = parsedJson;
          if (parsedJson['success'] == true) {
            gotoNextPage();
          } else {
            error();
          }
        });
      } catch (e) {
        error();
      }

      // Now send the credential (especially `credential.authorizationCode`) to your server to create a session
      // after they have bee n validated with Apple (see `Integration` section for more information on how to do this)
    }
  }

  Map<String, dynamic> _parsedJson = {};
  void gotoNextPage() {
    GlobalVariable.showLoader.value = false;
    GetStorage().write('token', _parsedJson['data']['token']);
    // var a = GetStorage().read('token');
    GlobalVariable.token = _parsedJson['data']['token'];
    if (GlobalVariable.auth_From_CheckOut.value == true) {
      GlobalVariable.auth_From_CheckOut.value = false;
      Get.offAllNamed(AppRoutes.checkoutViewRoute);
    } else {
      Get.offAllNamed(AppRoutes.bottomNavViewRoute);
    }
  }

  void error() {
    CommonFunction.showSnackBar(
      title: "Error",
      message: _parsedJson['message'],
    );

    GlobalVariable.showLoader.value = false;
  }

  // final googleSignin = GoogleSignIn();
  // GoogleSignInAccount? _user;
  // GoogleSignInAccount get user => _user!;

//   Future googleLogIn() async {
//     GlobalVariable.showLoader.value = true;
//     GoogleSignIn googleSignIn = GoogleSignIn(
//       scopes: [
//         'email',
//         'https://www.googleapis.com/auth/contacts.readonly',
//       ],
//     );
//
//     GoogleSignInAccount? credential;
//     try {
//       // Get.to(DrawerBottomBarView());
//       await googleSignIn.signOut();
//       credential = await googleSignIn.signIn();
//
//       credential?.authentication.then((value) async {
//         socialName.value = credential?.displayName ?? "";
//         socialEmail.value = credential?.email ?? "";
//         socialPlatform.value = 'Google';
//         socialToken.value = '${value.accessToken}';
//         print('Google token--------${value.accessToken}');
//         GlobalVariable.showLoader.value = false;
//         CommonFunction.debugPrint("social name ==>>>> ${socialName.value}");
//
//         Get.toNamed(AppRoutes.signUpViewRoute);
//       });
//     } catch (error) {
//       print(error);
//       GlobalVariable.showLoader.value = false;
//       //  debugPrint("$error");
//     }
//     update();
//     // debugPrint("google signin Credential ===> ${credential}");
//   }
//
// // apple login
//   appleSignin() async {
//     if (Platform.isIOS) {
//       try {
//         GlobalVariable.showLoader.value = true;
//
//         final appleCredential = await SignInWithApple.getAppleIDCredential(
//           scopes: [
//             AppleIDAuthorizationScopes.email,
//             AppleIDAuthorizationScopes.fullName,
//             AppleIDAuthorizationScopes.values[0],
//           ],
//         );
//         GlobalVariable.showLoader.value = false;
//         appleCredential.state;
//         socialName.value = appleCredential.givenName.toString() +
//                 appleCredential.familyName.toString() ??
//             "";
//         socialEmail.value = appleCredential.email ?? "";
//         socialPlatform.value = 'Apple';
//         socialToken.value = '${appleCredential.identityToken}';
//         print("Apple token ---------${appleCredential.identityToken}");
//         Get.toNamed(AppRoutes.signUpViewRoute);
//
//         // print(appleCredential.userIdentifier);
//         // print(appleCredential.authorizationCode);
//         // print(appleCredential.);
//       } catch (error) {
//         GlobalVariable.showLoader.value = false;
//       }
//
//       // Now send the credential (especially `credential.authorizationCode`) to your server to create a session
//       // after they have bee n validated with Apple (see `Integration` section for more information on how to do this)
//     }
//   }

  @override
  void onReady() {
    GlobalVariable.showLoader.value = false;

    super.onReady();
  }

  @override
  void onClose() {
    GlobalVariable.showLoader.value = false;

    super.onClose();
  }
}
