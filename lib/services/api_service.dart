import 'dart:convert';
import 'package:http/http.dart' as http_client;
import '../models/product.dart';

class ApiService {
  static const String apiUrl = 'http://139.59.246.168:9091/items';

  static Future<List<Product>> fetchProducts() async {
    final response = await http_client.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      return data.map((json) => Product.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load products');
    }
  }
}
