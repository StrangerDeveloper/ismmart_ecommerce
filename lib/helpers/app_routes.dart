import 'package:get/get.dart';
import 'package:ismmart_ecommerce/screens/auth/login/login_view.dart';
import 'package:ismmart_ecommerce/screens/home/home_view.dart';

abstract class AppRouter {
  List<GetPage> getRoutes();
}

class AppRoutes extends AppRouter {
  @override
  List<GetPage> getRoutes() {
    return [
      GetPage(name: '', page: () => LogInView()),
      GetPage(name: '', page: () => HomeView()),
    ];
  }
}
