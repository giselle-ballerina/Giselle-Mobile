import 'dart:convert';

Product productFromJson(String str) => Product.fromJson(json.decode(str));

String productToJson(Product data) => json.encode(data.toJson());

class Product {
  String itemId;
  String shopId;
  double price;
  String productName;
  String description;
  String brand;
  List<Tag> tags;
  List<Varient> varients;
  List<Image> images;

  Product({
    required this.itemId,
    required this.shopId,
    required this.price,
    required this.productName,
    required this.description,
    required this.brand,
    required this.tags,
    required this.varients,
    required this.images,
  });

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        itemId: json["itemId"],
        shopId: json["shopId"],
        price: json["price"],
        productName: json["productName"],
        description: json["description"],
        brand: json["brand"],
        tags: List<Tag>.from(json["tags"].map((x) => Tag.fromJson(x))),
        varients: List<Varient>.from(
            json["varients"].map((x) => Varient.fromJson(x))),
        images: List<Image>.from(json["images"].map((x) => Image.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "itemId": itemId,
        "shopId": shopId,
        "price": price,
        "productName": productName,
        "description": description,
        "brand": brand,
        "tags": List<dynamic>.from(tags.map((x) => x.toJson())),
        "varients": List<dynamic>.from(varients.map((x) => x.toJson())),
        "images": List<dynamic>.from(images.map((x) => x.toJson())),
      };
}

class Image {
  String url;

  Image({
    required this.url,
  });

  factory Image.fromJson(Map<String, dynamic> json) => Image(
        url: json["url"],
      );

  Map<String, dynamic> toJson() => {
        "url": url,
      };
}

class Tag {
  String name;

  Tag({
    required this.name,
  });

  factory Tag.fromJson(Map<String, dynamic> json) => Tag(
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
      };
}

class Varient {
  String color;
  String size;
  int qty;

  Varient({
    required this.color,
    required this.size,
    required this.qty,
  });

  factory Varient.fromJson(Map<String, dynamic> json) => Varient(
        color: json["color"],
        size: json["size"],
        qty: json["qty"],
      );

  Map<String, dynamic> toJson() => {
        "color": color,
        "size": size,
        "qty": qty,
      };
}
