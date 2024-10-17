class Product {
  final int id;
  final String title;
  final String description;
  final String image;

  Product({
    required this.id,
    required this.title,
    required this.description,
    required this.image,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      image: json['image'],
    );
  }
}
