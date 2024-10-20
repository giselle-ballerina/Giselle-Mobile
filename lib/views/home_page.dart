import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/shop_controller.dart';
import '../controllers/product_controller.dart';
import '../models/product.dart' as product_model;
import '../models/shop.dart' as shop_model;
import 'product_showcase.dart';

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
      body: Container(
        color: Colors.grey[100], // Light grey background for body
        child: Column(
          children: [
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 8.0),
              child: TextField(
                onChanged: (value) => value == ""
                    ? {
                        (productController.fetchInitialProducts()),
                        (shopController.updateSearchQuery(value))
                      }
                    : null,
                onSubmitted: (value) => {
                  (productController.fetchsearchResults(value)),
                  (shopController.updateSearchQuery(value))
                },
                decoration: InputDecoration(
                  labelText: 'Search',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(
                        30.0), // Rounded corners for search bar
                  ),
                  prefixIcon: const Icon(Icons.search),
                  filled: true,
                  fillColor: Colors.white, // White background for search bar
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
                  ...productController.products,
                  ...shopController.filteredShops
                ];
                combinedList.shuffle();

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
                                  Get.to(
                                      () => ProductShowcasePage(product: item));
                                },
                                child: Card(
                                  clipBehavior: Clip.antiAlias,
                                  color: Colors
                                      .white, // White background for product cards
                                  child: Column(
                                    children: [
                                      Expanded(
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: ClipRRect(
                                            borderRadius: BorderRadius.circular(
                                                10.0), // Rounded corners for images
                                            child: Image.network(
                                              item.images[0].url,
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Column(
                                          children: [
                                            Text(
                                              item.productName,
                                              textAlign: TextAlign.center,
                                            ),
                                            Text(
                                              "Rs. ${item.price}",
                                              textAlign: TextAlign.center,
                                            ),
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
                                  clipBehavior: Clip.antiAlias,
                                  color: Colors
                                      .white, // White background for shop cards
                                  child: Column(
                                    children: [
                                      Expanded(
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: ClipRRect(
                                            borderRadius: BorderRadius.circular(
                                                10.0), // Rounded corners for shop logo
                                            child: Image.network(
                                              item.logo,
                                              fit: BoxFit.cover,
                                              height:
                                                  100, // Set a fixed height for the logo to make it appear larger
                                              width: double
                                                  .infinity, // Make it take full width
                                            ),
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Column(
                                          children: [
                                            Text(
                                              item.shopName,
                                              textAlign: TextAlign.center,
                                            ),
                                            Text(
                                              item.description,
                                              textAlign: TextAlign.center,
                                            ),
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
      ),
    );
  }
}
