import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get/get.dart';
import 'package:ismmart_ecommerce/helpers/theme_helper.dart';
import 'package:ismmart_ecommerce/screens/auth/login/login_view.dart';
import 'package:ismmart_ecommerce/screens/home/home_view.dart';
import 'package:ismmart_ecommerce/screens/product_details/product_details_view.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
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
      home: HomeView(),
      //getPages: AppRouter().getRoutes(),
    );
  }
}
