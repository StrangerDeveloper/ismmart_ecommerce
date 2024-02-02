import 'package:get/get.dart';
import '../../../../helpers/global_variables.dart';

class SignupMehtodsViewModel extends GetxController {
  RxString socialName = ''.obs;
  RxString socialEmail = ''.obs;
  RxString socialToken = ''.obs;
  RxString socialPlatform = ''.obs;

  //----------Google singin---------
  // final googleSignin = GoogleSignIn();
  // Future googleLogIn() async {
  //   GlobalVariable.showLoader.value = true;
  //   GoogleSignIn googleSignin = GoogleSignIn(
  //     scopes: [
  //       'email',
  //       'https://www.googleapis.com/auth/contacts.readonly',
  //     ],
  //   );
  //   GoogleSignInAccount? credential;
  //   try {
  //     await googleSignin.signOut();
  //
  //     credential = await googleSignin.signIn();
  //     GlobalVariable.showLoader.value = false;
  //     // credential?.authentication.ignore();
  //     socialName.value = credential?.displayName ?? "";
  //     socialEmail.value = credential?.email ?? "";
  //     socialPlatform.value = 'Google';
  //     GlobalVariable.showLoader.value = false;
  //
  //     // Get.to(() => SignUp1View());
  //   } catch (error) {
  //     GlobalVariable.showLoader.value = false;
  //     debugPrint("$error");
  //   }
  //   update();
  //   // debugPrint("google signin Credential ===> ${credential}");
  // }

//apple login
//   appleSignin() async {
//     if (Platform.isIOS) {
//       final credential = await SignInWithApple.getAppleIDCredential(
//         scopes: [
//           AppleIDAuthorizationScopes.email,
//           AppleIDAuthorizationScopes.fullName,
//         ],
//       );
//
//       debugPrint("apple login====>>>  $credential   ");
//
//       // Now send the credential (especially `credential.authorizationCode`) to your server to create a session
//       // after they have been validated with Apple (see `Integration` section for more information on how to do this)
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
