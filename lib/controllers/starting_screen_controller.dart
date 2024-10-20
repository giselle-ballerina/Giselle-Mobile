import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StartingScreenController extends GetxController {
  var isLoading = true.obs;
  var isFreshBoot = false.obs;

  @override
  void onInit() {
    super.onInit();
    _checkFreshBoot();
  }

  Future<void> _checkFreshBoot() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final bool? freshBoot = prefs.getBool('fresh_boot');

    if (freshBoot == null || freshBoot == true) {
      isFreshBoot.value = true; // Set fresh boot as true if first time
    } else {
      isFreshBoot.value = false; // Set as not fresh boot if already launched
    }

    isLoading.value = false; // Hide the loading indicator
    await prefs.setBool('fresh_boot', false);
  }
}
