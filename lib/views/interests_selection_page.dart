import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:giselle_mobile/controllers/interest_controller.dart';
import 'package:giselle_mobile/views/home_page.dart';

// ignore: use_key_in_widget_constructors
class InterestSelectionPage extends StatelessWidget {
  final InterestController interestController = Get.put(InterestController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: Column(
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(60.0),
            child: Image.asset("assets/logo.png"),
          ),
        ),
        Expanded(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                const Text(
                  'Select your Interests!',
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: context.height * 0.3,
                  width: context.width * 0.8,
                  child: GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        childAspectRatio: 2,
                      ),
                      itemCount: interestController.interests.length,
                      itemBuilder: (context, index) {
                        return Obx(() => FilterChip(
                              label: Text(interestController.interests[index]),
                              selected: interestController.selectedInterests
                                  .contains(
                                      interestController.interests[index]),
                              onSelected: (bool selected) {
                                interestController.toggleInterest(
                                    interestController.interests[index]);
                              },
                            ));
                      }),
                ),
                Obx(() => FilledButton(
                      onPressed: interestController.selectedInterests.length > interestController.interests.length / 5
                          ? () {
                              interestController.saveInterests();
                              Get.off(HomePage());
                            }
                          : null,
                      child: const Text("Let's Go!"),
                    )),
              ],
            ),
          ),
        ),
      ],
    )));
  }
}
