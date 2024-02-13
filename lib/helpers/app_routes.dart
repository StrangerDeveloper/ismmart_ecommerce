import 'package:get/get.dart';
import 'package:ismmart_ecommerce/screens/auth/forgot_password/reset_password/success_view.dart';
import 'package:ismmart_ecommerce/screens/auth/login/login_view.dart';
import 'package:ismmart_ecommerce/screens/auth/sign_up/signup_methods/singup_methods_view.dart';
import 'package:ismmart_ecommerce/screens/home/home_view.dart';

import '../screens/auth/sign_up/signup/signup_view.dart';

abstract class AppRouter {
  List<GetPage> getRoutes();
}

class AppRoutes extends AppRouter {
  static const initRoute = "/";

  static const singupMethodsViewRoute = "/singupMethodsViewRoute";
  static const signUpViewRoute = "/SignUpView";

  static const successViewRoute = "/successView";

  @override
  List<GetPage> getRoutes() {
    return [
      GetPage(name: initRoute, page: () => LogInView()),
      GetPage(name: singupMethodsViewRoute, page: () => SignUpMethodsView()),
      GetPage(name: '', page: () => HomeView()),
      GetPage(name: signUpViewRoute, page: () => SignUpView()),
      GetPage(name: successViewRoute, page: ()=>SuccessView()),
    ];
  }
}
