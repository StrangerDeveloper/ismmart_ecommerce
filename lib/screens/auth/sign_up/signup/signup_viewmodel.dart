import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:ismmart_ecommerce/helpers/common_function.dart';

import '../../../../helpers/api_base_helper.dart';
import '../../../../helpers/global_variables.dart';
import '../../../../widgets/pick_image.dart';
import '../signup_methods/signup_mehods_viewmodel.dart';

class SignUpScreen1ViewModel extends GetxController {
  GlobalKey<FormState> signUpFormKey1 = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController cnicController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  Rx<File> cnicFrontImage = File('').obs;
  RxString cnicBackImage = ''.obs;
  RxBool cnicFrontImageErrorVisibility = false.obs;
  RxBool cnicBackImageErrorVisibility = false.obs;
  RxMap<String, dynamic> body = <String, dynamic>{}.obs;
  RxBool obscurePassword = true.obs;
  RxBool obscureConfirmPassword = true.obs;
  Rxn phoneErrorText = Rxn<String>();
  RxString countryCode = '+92'.obs;
  RxBool changeView = false.obs;
  RxBool isChecked = false.obs;
  FocusNode myfocus = FocusNode();

  validatorPhoneNumber(String? value) {
    if (GetUtils.isBlank(value)!) {
      phoneErrorText.value = "Field is required";
    } else if (value!.length > 16 || value.length < 7) {
      phoneErrorText.value = "Incorrect Phone number";
    } else {
      phoneErrorText.value = null;
    }
  }

  selectImage(RxString imageVar, RxBool imageVisibilityVar) async {
    final image = await PickImage().pickSingleImage();
    if (image != null) {
      imageVar.value = image.path;
      imageVisibilityVar.value = false;
    }
  }

  final SignupMehtodsViewModel _socialviewModel =
      Get.put(SignupMehtodsViewModel());
  String socialToken = '';
  @override
  void onReady() {
    GlobalVariable.showLoader.value = false;
    nameController.text = _socialviewModel.socialName.value;
    emailController.text = _socialviewModel.socialEmail.value;
    emailController.text = _socialviewModel.socialEmail.value;
    socialToken = _socialviewModel.socialToken.value;

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
  void signUpStep1() async {
    fileList.clear();
    //------    Image Varification and Send To Api ------------
    await imgCheck();
    if (signUpFormKey1.currentState?.validate() ??
        false ||
            cnicFrontImageErrorVisibility.value ||
            cnicFrontImageErrorVisibility.value) {
      if (isChecked.value == true) {
        //------- Social Signup Checks ----------
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
            "Socila":
                "{ social[name]: ${_socialviewModel.socialPlatform.value}, 'social[token]': ${_socialviewModel.socialToken.value}   }",
            'step': '1'
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
            'step': '1'
          };
        }
        changeView.value = true;
        body.value = param;
        GlobalVariable.showLoader.value = true;
        await ApiBaseHelper()
            .postMethodForImage(
                url: "Urls.register", files: fileList, fields: param)
            .then((parsedJson) {
          if (parsedJson['success'] == true) {
            GlobalVariable.showLoader.value = false;
            param.removeWhere((key, value) => value == "1");
            // Get.to(() => SignUp2View(), arguments: param);
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

  Future<void> imgCheck() async {
    print(fileList.length);
    print(cnicFrontImage.value);
    print(cnicBackImage.value);
    if (cnicFrontImage.value.path.isNotEmpty &&
        cnicBackImage.value.isNotEmpty) {
      fileList.add(
        await http.MultipartFile.fromPath(
          'cnicImages',
          cnicFrontImage.value.path,
          contentType: MediaType.parse('image/jpeg'),
        ),
      );
      fileList.add(
        await http.MultipartFile.fromPath(
          'cnicImages',
          cnicBackImage.value,
          contentType: MediaType.parse('image/jpeg'),
        ),
      );
    } else {
      cnicFrontImageErrorVisibility.value = true;
      cnicBackImageErrorVisibility.value = true;
      // AppConstant.displaySnackBar(
      //   " Error",
      //   " please upload CNIC Images",
      // );
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
}
