import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/shop_controller.dart';
import '../controllers/product_controller.dart';
import '../models/product.dart' as product_model;
import '../models/shop.dart' as shop_model;

// ignore: use_key_in_widget_constructors
class HomePage extends StatelessWidget {
  final ProductController productController = Get.put(ProductController());
  final ShopController shopController = Get.put(ShopController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Giselle'),
      ),
      body: Column(
        children: [
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 20.0, vertical: 8.0),
            child: TextField(
              onChanged: (value) => value == ""
                  ? {
                      (productController.updateSearchQuery(value)),
                      (shopController.updateSearchQuery(value))
                    }
                  : null,
              onSubmitted: (value) => {
                (productController.updateSearchQuery(value)),
                (shopController.updateSearchQuery(value))
              },
              decoration: const InputDecoration(
                labelText: 'Search',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.search),
              ),
            ),
          ),
          Expanded(
            child: Obx(() {
              if (productController.isLoading.value ||
                  shopController.isLoading.value) {
                return const Center(child: CircularProgressIndicator());
              }

              var combinedList = [
                ...productController.filteredProducts,
                ...shopController.filteredShops
              ];
              // combinedList.shuffle();

              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                child: combinedList.isNotEmpty
                    ? GridView.builder(
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: 0.8,
                        ),
                        itemCount: combinedList.length,
                        itemBuilder: (context, index) {
                          var item = combinedList[index];
                          if (item is product_model.Product) {
                            return GestureDetector(
                              onTap: () {
                                // Get.to(() => ProductPage(product: product));
                              },
                              child: Card(
                                color: Colors.purple[100],
                                child: Column(
                                  children: [
                                    Expanded(
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Image.network(item.images[0].url,
                                            fit: BoxFit.cover),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        children: [
                                          Text(item.productName,
                                              textAlign: TextAlign.center),
                                          Text("Rs. ${item.price}",
                                              textAlign: TextAlign.center),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          } else if (item is shop_model.Shop) {
                            return GestureDetector(
                              onTap: () {
                                // Get.to(() => ShopPage(shop: shop));
                              },
                              child: Card(
                                color: Colors.purple[300],
                                child: Column(
                                  children: [
                                    Expanded(
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Image.network(item.logo,
                                            fit: BoxFit.cover),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        children: [
                                          Text(item.shopName,
                                              textAlign: TextAlign.center),
                                          Text(item.description,
                                              textAlign: TextAlign.center),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          }
                          return null;
                        },
                      )
                    : const Center(child: Text('Sorry, No products found!')),
              );
            }),
          ),
        ],
      ),
    );
  }
}
