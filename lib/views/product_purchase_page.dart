import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../models/product.dart' as products;


class ProductPurchasePage extends StatelessWidget {
  final products.Product product;

  ProductPurchasePage({required this.product});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Purchase ${product.productName}'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Purchasing: ${product.productName}',
              style: TextStyle(fontSize: 24),
            ),
            SizedBox(height: 16),
            Text(
              'Price: \$${product.price.toStringAsFixed(2)}',
              style: TextStyle(fontSize: 20, color: Colors.green),
            ),
            SizedBox(height: 24),
            ElevatedButton(
              onPressed: () {
                // Logic for purchasing the product
                Get.snackbar('Purchase Success', '${product.productName} purchased successfully!');
              },
              child: Text('Confirm Purchase'),
            ),
          ],
        ),
      ),
    );
  }
}
