import 'package:get/get.dart';
import 'package:ismmart_ecommerce/screens/auth/forgot_password/reset_password/success_view.dart';
import 'package:ismmart_ecommerce/screens/auth/login/login_view.dart';
import 'package:ismmart_ecommerce/screens/auth/sign_up/signup_methods/singup_methods_view.dart';
import 'package:ismmart_ecommerce/screens/home/home_view.dart';
import 'package:ismmart_ecommerce/screens/splashscreen/splasch_screen_view.dart';

import '../screens/auth/sign_up/signup/signup_view.dart';
import '../screens/bottom_navigation/bottom_navigation_view.dart';
import '../screens/edit_user_profile/edit_user_profile_view.dart';

class AppRoutes {
  static const initRoute = "/";

  static const singupMethodsViewRoute = "/singupMethodsViewRoute";
  static const signUpViewRoute = "/SignUpView";
  static const loginViewRoute = "/loginView";
  static const bottomNavigationViewRoute = "/BottomNavigationView";
  static const editUserProfileViewRoute = "/EditUserProfileView";

  static const successViewRoute = "/successView";

  List<GetPage> getRoutes() {
    return [
      GetPage(name: initRoute, page: () => SplashScreenView()),
      GetPage(name: loginViewRoute, page: () => LogInView()),
      GetPage(name: singupMethodsViewRoute, page: () => SignUpMethodsView()),
      //GetPage(name: '', page: () => HomeView()),
      GetPage(name: signUpViewRoute, page: () => SignUpView()),
      GetPage(name: successViewRoute, page: () => SuccessView()),
      GetPage(
          name: editUserProfileViewRoute, page: () => EditUserProfileView()),
      GetPage(
          name: bottomNavigationViewRoute, page: () => BottomNavigationView()),
    ];
  }
}
