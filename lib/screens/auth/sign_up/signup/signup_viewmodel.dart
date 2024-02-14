import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:ismmart_ecommerce/helpers/app_routes.dart';
import 'package:ismmart_ecommerce/helpers/common_function.dart';
import 'package:ismmart_ecommerce/screens/auth/login/login_view.dart';

import '../../../../helpers/api_base_helper.dart';
import '../../../../helpers/global_variables.dart';
import '../../../../helpers/urls.dart';
import '../signup_methods/signup_mehods_viewmodel.dart';

class SignUpViewModel extends GetxController {
  GlobalKey<FormState> signUpFormKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController cnicController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  RxBool obscurePassword = true.obs;
  RxBool obscureConfirmPassword = true.obs;
  Rxn phoneErrorText = Rxn<String>();
  RxString countryCode = '+92'.obs;
  RxBool isChecked = false.obs;
  FocusNode myfocus = FocusNode();

  final SignupMehtodViewModel _socialviewModel =
      Get.put(SignupMehtodViewModel());
  String socialToken = '';
  @override
  void onReady() {
    GlobalVariable.showLoader.value = false;
    nameController.text = _socialviewModel.socialName.value;
    emailController.text = _socialviewModel.socialEmail.value;
    emailController.text = _socialviewModel.socialEmail.value;
    socialToken = _socialviewModel.socialToken.value;
    print("====== social name ===${nameController.text}");

    super.onReady();
  }

  @override
  void onClose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    phoneNumberController.dispose();
    GlobalVariable.showLoader.value = false;

    super.onClose();
  }

  List<http.MultipartFile> fileList = [];
  Future<void> signUp() async {
    fileList.clear();
    if (signUpFormKey.currentState?.validate() ?? false) {
      if (isChecked.value == true) {
        String regex =
            r'[^\p{Alphabetic}\p{Mark}\p{Decimal_Number}\p{Connector_Punctuation}\p{Join_Control}\s]+';
        final String cnicNo =
            cnicController.text.replaceAll(RegExp(regex, unicode: true), '');

        Map<String, String> param = {};
        if (_socialviewModel.socialPlatform.value != "" &&
            _socialviewModel.socialToken.value != "") {
          param = {
            "name": nameController.text,
            "email": emailController.text,
            "gender": genderList[genderSelectedIndex.value],
            "cnic": cnicNo,
            "phone": countryCode.value + phoneNumberController.text,
            "password": passwordController.text,
            "confirmPassword": confirmPasswordController.text,
            "social":
                "{ social[name]: ${_socialviewModel.socialPlatform.value}, social[token]: ${_socialviewModel.socialToken.value}   }",
          };
        } else {
          param = {
            "name": nameController.text,
            "email": emailController.text,
            "gender": genderList[genderSelectedIndex.value],
            "cnic": cnicNo,
            "phone": countryCode.value + phoneNumberController.text,
            "password": passwordController.text,
            "confirmPassword": confirmPasswordController.text,
          };
        }
        print(param);
        GlobalVariable.showLoader.value = true;
        await ApiBaseHelper()
            .postMethod(url: Urls.register, body: param)
            .then((parsedJson) {
          if (parsedJson['success'] == true) {
            GlobalVariable.showLoader.value = false;
            Get.toNamed(AppRoutes.loginViewRoute);
          } else {
            GlobalVariable.showLoader(false);
            CommonFunction.showSnackBar(
              title: 'Error',
              message: parsedJson['message'],
            );
          }
        });
      } else {
        CommonFunction.showSnackBar(
          title: 'Error',
          message: 'Please Accept Terms & Condition',
        );
      }
    } else {
      GlobalVariable.showLoader(false);
    }
  }

  //
  // //Google singin
  // RxString socialSignUpId = ''.obs;
  // RxString socialSignUpName = ''.obs;
  // RxString socialsignUpEmail = ''.obs;
  // RxString socialSignUPimgUrl = ''.obs;
  //
  // final googleSignin = GoogleSignIn();
  // GoogleSignInAccount? _user;
  // GoogleSignInAccount get user => _user!;
  // Future googleLogIn() async {
  //   GoogleSignIn googleSignIn = GoogleSignIn(
  //     scopes: [
  //       'email',
  //       'https://www.googleapis.com/auth/contacts.readonly',
  //     ],
  //   );
  //
  //   try {
  //     GoogleSignInAccount? credential = await googleSignIn.signIn();
  //     //print(credential);
  //     socialSignUpId.value = credential?.id ?? "";
  //     socialSignUpName.value = credential?.displayName ?? "";
  //     socialsignUpEmail.value = credential?.email ?? "";
  //     socialSignUPimgUrl.value = credential?.photoUrl ?? "";
  //   } catch (error) {
  //     debugPrint("$error");
  //   }
  //   //update();
  //   //  var a = credential['GoogleSignInAccount']['displayName'];
  // }

// //apple login
//   appleSignin() async {
//     if (Platform.isIOS) {
//       final credential = await SignInWithApple.getAppleIDCredential(
//         scopes: [
//           AppleIDAuthorizationScopes.email,
//           AppleIDAuthorizationScopes.fullName,
//         ],
//       );
//
//       debugPrint("apple login====>>>  $credential");
//
//       // Now send the credential (especially `credential.authorizationCode`) to your server to create a session
//       // after they have been validated with Apple (see `Integration` section for more information on how to do this)
//     }
//   }

  //-------- Gender
  TextEditingController genderController = TextEditingController();
  RxInt genderSelectedIndex = 0.obs;
  List genderList = ['Male', 'Female', 'Other'];

  validatorPhoneNumber(String? value) {
    if (GetUtils.isBlank(value)!) {
      phoneErrorText.value = "Field is required";
    } else if (value!.length > 16 || value.length < 7) {
      phoneErrorText.value = "Incorrect Phone number";
    } else {
      phoneErrorText.value = null;
    }
  }
}
