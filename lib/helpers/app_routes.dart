import 'package:get/get.dart';
import 'package:ismmart_ecommerce/screens/auth/forgot_password/reset_password/success_view.dart';
import 'package:ismmart_ecommerce/screens/auth/login/login_view.dart';
import 'package:ismmart_ecommerce/screens/auth/sign_up/signup_methods/singup_methods_view.dart';
import 'package:ismmart_ecommerce/screens/home/home_view.dart';
import 'package:ismmart_ecommerce/screens/order/order_details/order_detail_view.dart';
import 'package:ismmart_ecommerce/screens/splashscreen/splasch_screen_view.dart';

import '../screens/auth/sign_up/signup/signup_view.dart';
import '../screens/bottom_navigation/bottom_navigation_view.dart';
import '../screens/edit_user_profile/edit_user_profile_view.dart';

class AppRoutes {
  static const initRoute = "/";

  static const singupMethodsViewRoute = "/singupMethodsViewRoute";
  static const signUpViewRoute = "/SignUpView";
  static const loginViewRoute = "/loginView";
  static const editProfileViewRoute = "/editUserProfileView";
  static const successViewRoute = "/successView";

  static const bottomNavViewRoute = "/bottomNav";
  static const homeRoute = "/homeView";
  static const orderDetailViewRoute = "/orderDetailView";

  List<GetPage> getRoutes() {
    return [
      GetPage(name: initRoute, page: () => SplashScreenView()),
      GetPage(name: bottomNavViewRoute, page: () => BottomNavigationView()),
      GetPage(name: homeRoute, page: () => HomeView()),
      GetPage(name: loginViewRoute, page: () => LogInView()),
      GetPage(name: singupMethodsViewRoute, page: () => SignUpMethodsView()),
      GetPage(name: signUpViewRoute, page: () => SignUpView()),
      GetPage(name: successViewRoute, page: () => const SuccessView()),
      GetPage(name: editProfileViewRoute, page: () => EditUserProfileView()),
      GetPage(name: orderDetailViewRoute, page: () => OrderDetailView()),
    ];
  }
}
