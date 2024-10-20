import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/product.dart';
import '../services/api_service.dart';

class ProductController extends GetxController {
  var products = <Product>[].obs;
  var isLoading = true.obs;

  @override
  void onInit() {
    super.onInit();
    fetchInitialProducts();
  }

  void fetchInitialProducts() async {
    try {
      isLoading(true);
      var interests = await _getSavedInterests();
      products.value = await ApiService.fetchProducts(interests, 10);
    } finally {
      isLoading(false);
    }
  }

  void fetchsearchResults(String keyword) async {
    try {
      isLoading(true);
      products.value = await ApiService.fetchProducts(keyword, 10);
    } finally {
      isLoading(false);
    }
  }

  Future<String> _getSavedInterests() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(
          'saved_interests',
        ) ??
        "";
  }
}
