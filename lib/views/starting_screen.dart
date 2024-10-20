import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/starting_screen_controller.dart';
import 'home_page.dart';
import 'interests_selection_page.dart';

// ignore: use_key_in_widget_constructors
class StartingScreen extends StatelessWidget {
  final startingScreenController = Get.put(StartingScreenController());

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      // Check the status of isFreshBoot
      if (startingScreenController.isLoading.value) {
        return const Center(child: CircularProgressIndicator());
      } else {
        return startingScreenController.isFreshBoot.value
            ? InterestSelectionPage()
            : HomePage();
      }
    });
  }
}
