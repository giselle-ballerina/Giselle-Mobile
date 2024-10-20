import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/product_purchase_controller.dart';
import '../models/product.dart';

class ProductPurchasePage extends StatelessWidget {
  final Product product;

  ProductPurchasePage({required this.product});

  @override
  Widget build(BuildContext context) {
    final ProductPurchaseController controller = Get.put(ProductPurchaseController(product));

    return Scaffold(
      appBar: AppBar(
        title: Text('Purchase ${product.productName}'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildProductImage(context),
              SizedBox(height: 24),
              _buildProductInfo(),
              SizedBox(height: 24),
              _buildVariantDropdown(controller),
              SizedBox(height: 24),
              _buildQuantitySelector(controller),
              SizedBox(height: 24),
              _buildPriceSection(controller),
              SizedBox(height: 32),
              _buildPurchaseButton(controller),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProductImage(BuildContext context) {
    return Center(
      child: Container(
        width: MediaQuery.of(context).size.width * 0.5,
        height: MediaQuery.of(context).size.width * 0.5,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          image: DecorationImage(
            image: NetworkImage(product.images.first.url),
            fit: BoxFit.cover,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 8.0,
              offset: Offset(0, 4),
            ),
          ],
        ),
      ),
    );
  }

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
        Obx(() => Container(
              padding: EdgeInsets.symmetric(horizontal: 12),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.shade300),
                borderRadius: BorderRadius.circular(8),
              ),
              child: DropdownButton<Varient>(
                value: controller.selectedVariant.value,
                onChanged: (Varient? newValue) {
                  if (newValue != null) {
                    controller.updateSelectedVariant(newValue);
                  }
                },
                items: product.varients.map<DropdownMenuItem<Varient>>((Varient variant) {
                  String processedColor = 'FF' + variant.color.replaceFirst('#', '');
                  Color color = Color(int.parse(processedColor, radix: 16));

                  return DropdownMenuItem<Varient>(
                    value: variant,
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
                          "${variant.size} (Available: ${variant.qty})",
                          style: TextStyle(fontSize: 16),
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ),
            )),
      ],
    );
  }

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
            IconButton(
              onPressed: () {
                controller.decrementQuantity();
              },
              icon: Icon(Icons.remove),
            ),
            Obx(() => Text(
                  '${controller.selectedQuantity.value}',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                )),
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

  Widget _buildPurchaseButton(ProductPurchaseController controller) {
    return Center(
      child: Obx(() => ElevatedButton(
            style: ElevatedButton.styleFrom(
              padding: EdgeInsets.symmetric(vertical: 16, horizontal: 32),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              backgroundColor: Colors.purple,
            ),
            onPressed: controller.selectedVariant.value == null
                ? null
                : () {
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
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
            ),
          )),
    );
  }
}
