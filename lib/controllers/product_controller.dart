import 'package:get/get.dart';
import '../models/product.dart';
import '../services/api_service.dart';

class ProductController extends GetxController {
  var products = <Product>[].obs;
  var isLoading = true.obs;
  var searchQuery = ''.obs;

  @override
  void onInit() {
    fetchProducts();
    super.onInit();
  }

  void fetchProducts() async {
    try {
      isLoading(true);
      var fetchedProducts = await ApiService.fetchProducts();
      products.value = fetchedProducts;
    } finally {
      isLoading(false);
    }
  }

  List<Product> get filteredProducts {
    if (searchQuery.value.isEmpty) {
      return products;
    } else {
      return products
          .where((product) =>
              product.title.toLowerCase().contains(searchQuery.value.toLowerCase()))
          .toList();
    }
  }

  void updateSearchQuery(String query) {
    searchQuery.value = query;
  }
}
