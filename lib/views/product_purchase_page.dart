import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../models/product.dart';


class ProductPurchasePage extends StatefulWidget {
  final Product product;

  ProductPurchasePage({required this.product});

  @override
  _ProductPurchasePageState createState() => _ProductPurchasePageState();
}

class _ProductPurchasePageState extends State<ProductPurchasePage> {
  // Track the selected variant
  Varient? selectedVariant;

  @override
  void initState() {
    super.initState();
    // Default to the first variant
    selectedVariant = widget.product.varients.isNotEmpty ? widget.product.varients[0] : null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Purchase ${widget.product.productName}'),
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
            _buildVariantDropdown(),
            SizedBox(height: 24),
            // Total Price Section
            _buildPriceSection(),
            SizedBox(height: 32),
            // Purchase Button
            _buildPurchaseButton(),
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
            image: NetworkImage(widget.product.images.first.url),
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
          widget.product.productName,
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 8),
        Text(
          "Brand: ${widget.product.brand}",
          style: TextStyle(fontSize: 16, color: Colors.grey[700]),
        ),
      ],
    );
  }

  // Widget to display dropdown for variant selection
  Widget _buildVariantDropdown() {
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
        DropdownButton<Varient>(
          value: selectedVariant,
          onChanged: (Varient? newValue) {
            setState(() {
              selectedVariant = newValue;
            });
          },
          items: widget.product.varients.map<DropdownMenuItem<Varient>>((Varient variant) {
            return DropdownMenuItem<Varient>(
              value: variant,
              child: Text(
                "${variant.color} - ${variant.size} (Qty: ${variant.qty})",
                style: TextStyle(fontSize: 16),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  // Widget to display the price section
  Widget _buildPriceSection() {
    return Row(
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
          '\$${widget.product.price.toStringAsFixed(2)}',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.green[700],
          ),
        ),
      ],
    );
  }

  // Widget for the purchase button
  Widget _buildPurchaseButton() {
    return Center(
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          padding: EdgeInsets.symmetric(vertical: 16, horizontal: 32),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          backgroundColor: Colors.blueAccent,
        ),
        onPressed: selectedVariant == null ? null : () {
          // Logic for confirming the purchase
          Get.snackbar(
            'Purchase Confirmed',
            'You have successfully purchased ${widget.product.productName} (${selectedVariant?.color} - ${selectedVariant?.size})!',
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.green[100],
            colorText: Colors.black87,
          );
        },
        child: Text(
          'Confirm Purchase',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
