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
        centerTitle: true,
        // AppBar color for consistency
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildProductImages(context), // Pass context here
              SizedBox(height: 16),
              _buildProductDetails(),
              Divider(),
              SizedBox(height: 16),
              _buildProductVariants(),
              Divider(),
              SizedBox(height: 16),
              if (product.tags.isNotEmpty &&
                  product.tags.any((tag) => tag.name.isNotEmpty))
                _buildTags(),
              SizedBox(height: 24),
              _buildPurchaseButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProductImages(BuildContext context) {
    // Check if there's only one image and handle centering
    bool isSingleImage = product.images.length == 1;

    return SizedBox(
      height: 300, // Increased height for better visibility
      child: isSingleImage
          ? Center(
              child: GestureDetector(
                onTap: () {
                  // Navigate to full-screen image view
                  _showFullScreenImage(context, product.images[0].url);
                },
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black26,
                        offset: Offset(0, 2),
                        blurRadius: 6,
                      ),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.network(
                      product.images[0].url,
                      fit: BoxFit
                          .contain, // Changed to contain for full visibility
                    ),
                  ),
                ),
              ),
            )
          : ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: product.images.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: GestureDetector(
                    onTap: () {
                      // Navigate to full-screen image view
                      _showFullScreenImage(context, product.images[index].url);
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black26,
                            offset: Offset(0, 2),
                            blurRadius: 6,
                          ),
                        ],
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.network(
                          product.images[index].url,
                          fit: BoxFit
                              .contain, // Changed to contain for full visibility
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
    );
  }

  void _showFullScreenImage(BuildContext context, String imageUrl) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => Scaffold(
          backgroundColor: Colors.black,
          body: Center(
            child: GestureDetector(
              onTap: () {
                Navigator.pop(context); // Go back on tap
              },
              child: Image.network(
                imageUrl,
                fit: BoxFit.contain,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildProductDetails() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          product.productName,
          style: TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.bold,
              color: Colors.black87), // Adjusted font size
        ),
        SizedBox(height: 8),
        Text(
          "Brand: ${product.brand}",
          style: TextStyle(
              fontSize: 16, color: Colors.grey[700]), // Adjusted font size
        ),
        SizedBox(height: 8),
        Text(
          "Price: \$${product.price.toStringAsFixed(2)}",
          style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Colors.green[700]), // Adjusted font size
        ),
        SizedBox(height: 16),
        Text(
          product.description,
          style: TextStyle(
              fontSize: 14, color: Colors.black54), // Adjusted font size
        ),
      ],
    );
  }

  Widget _buildProductVariants() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Available Variants",
          style: TextStyle(
              fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black87),
        ),
        SizedBox(height: 8),
        ListView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: product.varients.length,
          itemBuilder: (context, index) {
            final variant = product.varients[index];
            String processedColor = 'FF' + variant.color.replaceFirst('#', '');
            Color color = Color(int.parse(processedColor, radix: 16));

            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 4.0),
              child: Row(
                children: [
                  Container(
                    width: 24,
                    height: 24,
                    decoration: BoxDecoration(
                      color: color,
                      borderRadius: BorderRadius.circular(4),
                      border: Border.all(color: Colors.grey.shade300),
                    ),
                  ),
                  SizedBox(width: 12),
                  Text(
                    "${variant.size} (Qty: ${variant.qty})",
                    style: TextStyle(fontSize: 16, color: Colors.black87),
                  ),
                ],
              ),
            );
          },
        ),
      ],
    );
  }

  Widget _buildTags() {
    return Wrap(
      spacing: 8.0,
      children: product.tags
          .map((tag) => Chip(
                label: Text(tag.name, style: TextStyle(color: Colors.white)),
                backgroundColor: Colors.blue,
              ))
          .toList(),
    );
  }

  Widget _buildPurchaseButton() {
    return Center(
      child: ElevatedButton(
        onPressed: () {
          Get.to(() => ProductPurchasePage(product: product));
        },
        child: Text(
          "Buy Now",
          style: TextStyle(
              fontSize: 18, color: Colors.white), // Adjusted font size
        ),
        style: ElevatedButton.styleFrom(
          padding: EdgeInsets.symmetric(horizontal: 32, vertical: 12),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          backgroundColor: Colors.purple, // Set button color to purple
        ),
      ),
    );
  }
}
