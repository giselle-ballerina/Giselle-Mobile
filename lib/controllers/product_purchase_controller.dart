import 'package:get/get.dart';

import '../models/product.dart';


class ProductPurchaseController extends GetxController {
  final Product product;

  // Observable variables for variant and quantity
  var selectedVariant = Rx<Varient?>(null);
  var selectedQuantity = 1.obs;

  ProductPurchaseController(this.product) {
    // Initialize with the first variant, if available
    if (product.varients.isNotEmpty) {
      selectedVariant.value = product.varients[0];
    }
  }

  // Function to update the selected variant
  void updateSelectedVariant(Varient variant) {
    selectedVariant.value = variant;
    selectedQuantity.value = 1; // Reset quantity to 1 when variant changes
  }

  // Function to increment quantity
  void incrementQuantity() {
    if (selectedVariant.value != null && selectedQuantity.value < selectedVariant.value!.qty) {
      selectedQuantity.value++;
    }
  }

  // Function to decrement quantity
  void decrementQuantity() {
    if (selectedQuantity.value > 1) {
      selectedQuantity.value--;
    }
  }

  // Function to calculate total price
  double getTotalPrice() {
    return product.price * selectedQuantity.value;
  }
}
