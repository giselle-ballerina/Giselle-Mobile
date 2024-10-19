import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/product_controller.dart';
// import 'product_page.dart';

// ignore: use_key_in_widget_constructors
class HomePage extends StatelessWidget {
  final ProductController productController = Get.put(ProductController());

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
                  ? (productController.updateSearchQuery(value))
                  : null,
              onSubmitted: (value) =>
                  productController.updateSearchQuery(value),
              decoration: const InputDecoration(
                labelText: 'Search',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.search),
              ),
            ),
          ),
          Expanded(
            child: Obx(() {
              if (productController.isLoading.value) {
                return const Center(child: CircularProgressIndicator());
              }

              var products = productController.filteredProducts;

              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                child: products.isNotEmpty
                    ? GridView.builder(
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: 0.8,
                        ),
                        itemCount: products.length,
                        itemBuilder: (context, index) {
                          var product = products[index];
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
                                      child: Image.network(
                                          product.images[0].url,
                                          fit: BoxFit.cover),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      children: [
                                        Text(product.productName,
                                            textAlign: TextAlign.center),
                                        Text("Rs. ${product.price}",
                                            textAlign: TextAlign.center),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
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
