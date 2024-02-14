import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
import 'package:ismmart_ecommerce/screens/splashscreen/splash_screen_viewmodel.dart';

class SplashScreenView extends StatelessWidget {
  SplashScreenView({super.key});
  final SplashScreenViewModel viewModel = Get.put(SplashScreenViewModel());

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Stack(
        children: [
          Positioned.fill(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 130),
              child: const CircleAvatar(
                backgroundColor: Colors.black,
              )
                  .animate()
                  .slideY(
                      begin: -0.9,
                      end: 0.5,
                      duration: NumDurationExtensions(0.9).seconds)
                  .then(delay: NumDurationExtensions(200).milliseconds)
                  // .slideY(end: -0.5, duration: 0.9.seconds)
                  // .then(delay: 200.milliseconds)
                  .slideY(
                      end: -0.5, duration: NumDurationExtensions(0.5).seconds)
                  .then(delay: NumDurationExtensions(1).seconds)
                  .scaleXY(end: 20, duration: NumDurationExtensions(2).seconds)
                  .then(delay: NumDurationExtensions(2).seconds),
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: Image.asset("assets/images/ismartsplashscreen.png")
                .animate()
                .fadeIn(
                    delay: NumDurationExtensions(2).seconds,
                    duration: NumDurationExtensions(900).milliseconds)
                .slideX(
                    begin: 3,
                    duration: NumDurationExtensions(500).milliseconds),
          ),
        ],
      ),
    );
  }
}
