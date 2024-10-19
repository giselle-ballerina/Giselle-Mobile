import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class InterestController extends GetxController {
  final List<String> interests = [
    "Casual",
    "Formal",
    "Sporty",
    "Streetwear",
    "Chic",
    "Trendy",
    "Classic",
    "Outdoor",
    "Denim",
    "Activewear",
    "Summer",
    "Winter",
    "Kids",
    "Men",
    "Women"
  ];
  var selectedInterests = <String>[].obs;

  void toggleInterest(String interest) {
    if (selectedInterests.contains(interest)) {
      selectedInterests.remove(interest);
    } else {
      selectedInterests.add(interest);
    }
  }

  Future<void> saveInterests() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('selected_interests', selectedInterests.join('+'));
    
  }
}
