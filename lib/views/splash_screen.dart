import './home_page.dart';
import 'onboarding_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/splash_screen_controller.dart';

class SplashScreen extends StatelessWidget {
  final splashController = Get.put(SplashScreenController());

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      // Check the status of isFreshBoot
      if (splashController.isLoading.value) {
        return const Center(child: CircularProgressIndicator());
      } else {
        return splashController.isFreshBoot.value
            ? OnboardingPage()
            : HomePage();
      }
    });
  }
}
