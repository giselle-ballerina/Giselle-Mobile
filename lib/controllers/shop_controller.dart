import 'package:get/get.dart';
import '../models/shop.dart';
import '../services/api_service.dart';

class ShopController extends GetxController {
  var shops = <Shop>[].obs;
  var isLoading = true.obs;
  var searchQuery = ''.obs;
  
  @override
  void onInit() {
    _fetchShops();
    super.onInit();
  }

  void _fetchShops() async {
    try {
      isLoading(true);
      var fetchedShops = await ApiService.fetchShops();
      shops.value = fetchedShops;
    } finally {
      isLoading(false);
    }
  }

  List<Shop> get filteredShops {
    if (searchQuery.value.isEmpty) {
      return shops;
    } else {
      return shops
          .where((shop) => shop.shopName
              .toLowerCase()
              .contains(searchQuery.value.toLowerCase()))
          .toList();
    }
  }

  void updateSearchQuery(String query) {
    searchQuery.value = query;
  }
}