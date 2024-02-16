import 'package:get/get.dart';
import 'package:ismmart_ecommerce/screens/auth/forgot_password/reset_password/success_view.dart';
import 'package:ismmart_ecommerce/screens/auth/login/login_view.dart';
import 'package:ismmart_ecommerce/screens/auth/sign_up/signup_methods/singup_methods_view.dart';
import 'package:ismmart_ecommerce/screens/bank_list/bank_list_view.dart';
import 'package:ismmart_ecommerce/screens/checkout/checkout_view.dart';
import 'package:ismmart_ecommerce/screens/faq/faq_view.dart';
import 'package:ismmart_ecommerce/screens/home/home_view.dart';
import 'package:ismmart_ecommerce/screens/order/order_details/order_detail_view.dart';
import 'package:ismmart_ecommerce/screens/order/order_listing/order_listing_view.dart';
import 'package:ismmart_ecommerce/screens/product_details/product_details_view.dart';
import 'package:ismmart_ecommerce/screens/profile_details/profile_view.dart';
import 'package:ismmart_ecommerce/screens/shipping_address_list/shipping_address_list_view.dart';
import 'package:ismmart_ecommerce/screens/splashscreen/splasch_screen_view.dart';

import '../screens/add_shipping_address/add_shipping_address_view.dart';
import '../screens/auth/sign_up/signup/signup_view.dart';
import '../screens/bottom_navigation/bottom_navigation_view.dart';
import '../screens/edit_user_profile/edit_user_profile_view.dart';

class AppRoutes {
  static const initRoute = "/";

  static const singupMethodsViewRoute = "/singupMethodsViewRoute";
  static const signUpViewRoute = "/SignUpView";
  static const loginViewRoute = "/loginView";
  static const successViewRoute = "/successView";

  static const profileViewRoute = "/profileView";
  static const editProfileViewRoute = "/editProfileView";

  static const productDetailsRoute = "/productDetails";

  static const bottomNavViewRoute = "/bottomNav";
  static const homeRoute = "/homeView";
  static const orderDetailViewRoute = "/orderDetailView";

  static const notificationRoute = "/notification";

  static const orderViewRoute = "/ordersview";

  static const shippingAdressRoute = "/shippingAdress";
  static const bankListRoute = "/banklisting";
  static const checkoutViewRoute = "/CheckoutView";

  static const faqsRoutes = "/faqs";
  static const addShippingAddressViewRoute = "/AddShippingAddressView";

  List<GetPage> getRoutes() {
    return [
      GetPage(name: initRoute, page: () => SplashScreenView()),
      GetPage(name: bottomNavViewRoute, page: () => BottomNavigationView()),
      GetPage(name: homeRoute, page: () => HomeView()),
      GetPage(name: loginViewRoute, page: () => LogInView()),
      GetPage(name: singupMethodsViewRoute, page: () => SignUpMethodsView()),
      GetPage(name: signUpViewRoute, page: () => SignUpView()),
      GetPage(name: successViewRoute, page: () => const SuccessView()),
      GetPage(name: profileViewRoute, page: () => ProfileView()),
      GetPage(name: editProfileViewRoute, page: () => EditUserProfileView()),
      GetPage(name: productDetailsRoute, page: () => ProductDetailsView()),

      //GetPage(name: notificationRoute, page: ()=> Notification)
      GetPage(name: orderViewRoute, page: () => OrderListingView()),
      GetPage(name: orderDetailViewRoute, page: () => OrderDetailView()),
      GetPage(name: shippingAdressRoute, page: () => ShippingAddressListView()),

      GetPage(name: bankListRoute, page: () => BankListView()),

      GetPage(name: faqsRoutes, page: () => FaqView()),
      GetPage(name: checkoutViewRoute, page: () => CheckoutView()),
      GetPage(
          name: addShippingAddressViewRoute,
          page: () => AddShippingAddressView()),
    ];
  }
}
