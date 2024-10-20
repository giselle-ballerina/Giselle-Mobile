import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../models/product.dart' as products;
import 'product_purchase_page.dart';

class ProductShowcasePage extends StatelessWidget {
  final products.Product product;

  ProductShowcasePage({required this.product});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(product.productName),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildProductImages(),
              SizedBox(height: 16),
              _buildProductDetails(),
              SizedBox(height: 16),
              _buildProductVariants(),
              SizedBox(height: 16),
              _buildTags(),
              SizedBox(height: 24),
              _buildPurchaseButton(),
            ],
          ),
        ),
      ),
    );
  }

  // Widget to display product images as a horizontal scrollable list
  Widget _buildProductImages() {
    return SizedBox(
      height: 200,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: product.images.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Image.network(
              product.images[index].url,
              height: 200,
              width: 200,
              fit: BoxFit.cover,
            ),
          );
        },
      ),
    );
  }

  // Widget to display basic product details
  Widget _buildProductDetails() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          product.productName,
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 8),
        Text(
          "Brand: ${product.brand}",
          style: TextStyle(fontSize: 16),
        ),
        SizedBox(height: 8),
        Text(
          "Price: \$${product.price.toStringAsFixed(2)}",
          style: TextStyle(fontSize: 18, color: Colors.green),
        ),
        SizedBox(height: 16),
        Text(
          product.description,
          style: TextStyle(fontSize: 16),
        ),
      ],
    );
  }

  // Widget to display product variants (color, size, quantity)
  Widget _buildProductVariants() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Available Variants",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 8),
        ListView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: product.varients.length,
          itemBuilder: (context, index) {
            final variant = product.varients[index];
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 4.0),
              child: Text(
                "${variant.color} - ${variant.size} (Qty: ${variant.qty})",
                style: TextStyle(fontSize: 16),
              ),
            );
          },
        ),
      ],
    );
  }

  // Widget to display product tags
  Widget _buildTags() {
    return Wrap(
      spacing: 8.0,
      children: product.tags.map((tag) => Chip(label: Text(tag.name))).toList(),
    );
  }

  // Purchase button that navigates to the purchase page
  Widget _buildPurchaseButton() {
    return Center(
      child: ElevatedButton(
        onPressed: () {
          // Navigate to the purchase page
          Get.to(() => ProductPurchasePage(product: product));
        },
        child: Text("Buy Now"),
      ),
    );
  }
}
