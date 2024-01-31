import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:ismmart_ecommerce/screens/signup/singup_view.dart';
import 'package:get/get.dart';
import 'package:ismmart_ecommerce/helpers/app_routes.dart';
import 'package:ismmart_ecommerce/helpers/theme_helper.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'ISMMART eCommerce',
      theme: ThemeHelper.lightTheme,
      darkTheme: ThemeHelper.darkTheme,
      home: SignupView(),
      //getPages: AppRouter().getRoutes(),
    );
  }
}
