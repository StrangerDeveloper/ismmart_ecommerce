import 'dart:io';

import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:ismmart_ecommerce/helpers/app_routes.dart';
import 'package:ismmart_ecommerce/helpers/common_function.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import '../../../../helpers/global_variables.dart';

class SignupMehtodViewModel extends GetxController {
  RxString socialName = ''.obs;
  RxString socialEmail = ''.obs;
  RxString socialToken = ''.obs;
  RxString socialPlatform = ''.obs;

  // ----------Google singin---------
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

      credential?.authentication.then((value) async {
        socialName.value = credential?.displayName ?? "";
        socialEmail.value = credential?.email ?? "";

        socialPlatform.value = 'Google';
        socialToken.value = '${value.accessToken}';

        GlobalVariable.showLoader.value = false;
        CommonFunction.debugPrint("social name ==>>>> ${socialName.value}");

        Get.toNamed(AppRoutes.signUpViewRoute);
      });
    } catch (error) {
      print(error);
      GlobalVariable.showLoader.value = false;
      //  debugPrint("$error");
    }
    update();
    // debugPrint("google signin Credential ===> ${credential}");
  }

// apple login
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
      } catch (error) {
        GlobalVariable.showLoader.value = false;
      }

      // Now send the credential (especially `credential.authorizationCode`) to your server to create a session
      // after they have bee n validated with Apple (see `Integration` section for more information on how to do this)
    }
  }

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
