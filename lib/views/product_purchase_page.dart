import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/product_purchase_controller.dart';
import '../models/product.dart';

class ProductPurchasePage extends StatelessWidget {
  final Product product;

  ProductPurchasePage({required this.product});

  @override
  Widget build(BuildContext context) {
    // Initialize the controller with the product
    final ProductPurchaseController controller = Get.put(ProductPurchaseController(product));

    return Scaffold(
      appBar: AppBar(
        title: Text('Purchase ${product.productName}'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Product Image
            _buildProductImage(),
            SizedBox(height: 24),
            // Product Info Section
            _buildProductInfo(),
            SizedBox(height: 24),
            // Variant Dropdown
            _buildVariantDropdown(controller),
            SizedBox(height: 24),
            // Quantity Selector
            _buildQuantitySelector(controller),
            SizedBox(height: 24),
            // Total Price Section
            _buildPriceSection(controller),
            SizedBox(height: 32),
            // Purchase Button
            _buildPurchaseButton(controller),
          ],
        ),
      ),
    );
  }

  // Widget to display the product image
  Widget _buildProductImage() {
    return Center(
      child: Container(
        width: 200,
        height: 200,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          image: DecorationImage(
            image: NetworkImage(product.images.first.url),
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }

  // Widget to display product name, brand information
  Widget _buildProductInfo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          product.productName,
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 8),
        Text(
          "Brand: ${product.brand}",
          style: TextStyle(fontSize: 16, color: Colors.grey[700]),
        ),
      ],
    );
  }

  // Widget to display dropdown for variant selection
  Widget _buildVariantDropdown(ProductPurchaseController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Select Variant",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 8),
        Obx(() => DropdownButton<Varient>(
              value: controller.selectedVariant.value,
              onChanged: (Varient? newValue) {
                if (newValue != null) {
                  controller.updateSelectedVariant(newValue);
                }
              },
              items: product.varients.map<DropdownMenuItem<Varient>>((Varient variant) {
                return DropdownMenuItem<Varient>(
                  value: variant,
                  child: Text(
                    "${variant.color} - ${variant.size} (Available: ${variant.qty})",
                    style: TextStyle(fontSize: 16),
                  ),
                );
              }).toList(),
            )),
      ],
    );
  }

  // Widget to display the quantity selection
  Widget _buildQuantitySelector(ProductPurchaseController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Select Quantity",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            // Decrement button
            IconButton(
              onPressed: () {
                controller.decrementQuantity();
              },
              icon: Icon(Icons.remove),
            ),
            // Quantity display
            Obx(() => Text(
                  '${controller.selectedQuantity.value}',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                )),
            // Increment button
            IconButton(
              onPressed: () {
                controller.incrementQuantity();
              },
              icon: Icon(Icons.add),
            ),
          ],
        ),
      ],
    );
  }

  // Widget to display the price section
  Widget _buildPriceSection(ProductPurchaseController controller) {
    return Obx(() => Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Total Price',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              '\$${controller.getTotalPrice().toStringAsFixed(2)}',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.green[700],
              ),
            ),
          ],
        ));
  }

  // Widget for the purchase button
  Widget _buildPurchaseButton(ProductPurchaseController controller) {
    return Center(
      child: Obx(() => ElevatedButton(
            style: ElevatedButton.styleFrom(
              padding: EdgeInsets.symmetric(vertical: 16, horizontal: 32),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              backgroundColor: Colors.blueAccent,
            ),
            onPressed: controller.selectedVariant.value == null
                ? null
                : () {
                    // Logic for confirming the purchase
                    Get.snackbar(
                      'Purchase Confirmed',
                      'You have successfully purchased ${controller.selectedQuantity.value} x ${product.productName} (${controller.selectedVariant.value?.color} - ${controller.selectedVariant.value?.size})!',
                      snackPosition: SnackPosition.BOTTOM,
                      backgroundColor: Colors.green[100],
                      colorText: Colors.black87,
                    );
                  },
            child: Text(
              'Confirm Purchase',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          )),
    );
  }
}
