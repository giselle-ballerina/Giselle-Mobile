import 'dart:convert';
import 'package:http/http.dart' as http_client;
import '../models/product.dart';
import '../models/shop.dart';

class ApiService {
  static const String apiUrl = 'http://139.59.246.168:9091';

  static Future<List<Product>> fetchProducts(String keyword, int count) async {
    final response = await http_client.get(Uri.parse('$apiUrl/recommendedItems?query=$keyword&top_k=$count'));

    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      return data.map((json) => Product.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load products');
    }
  }

  static Future<List<Shop>> fetchShops() async {
    final response = await http_client.get(Uri.parse('$apiUrl/shops'));

    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      return data.map((json) => Shop.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load shops');
    }
  }
}
