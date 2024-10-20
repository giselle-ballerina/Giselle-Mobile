import 'dart:convert';

Shop shopFromJson(String str) => Shop.fromJson(json.decode(str));

String shopToJson(Shop data) => json.encode(data.toJson());

class Shop {
    String shopId;
    String shopName;
    Owner owner;
    String description;
    String background;
    Color color;
    String logo;
    Color font;
    List<Insight> insights;

    Shop({
        required this.shopId,
        required this.shopName,
        required this.owner,
        required this.description,
        required this.background,
        required this.color,
        required this.logo,
        required this.font,
        required this.insights,
    });

    factory Shop.fromJson(Map<String, dynamic> json) => Shop(
        shopId: json["shopId"],
        shopName: json["shopName"],
        owner: Owner.fromJson(json["owner"]),
        description: json["description"],
        background: json["background"],
        color: Color.fromJson(json["color"]),
        logo: json["logo"],
        font: Color.fromJson(json["font"]),
        insights: List<Insight>.from(json["insights"].map((x) => Insight.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "shopId": shopId,
        "shopName": shopName,
        "owner": owner.toJson(),
        "description": description,
        "background": background,
        "color": color.toJson(),
        "logo": logo,
        "font": font.toJson(),
        "insights": List<dynamic>.from(insights.map((x) => x.toJson())),
    };
}

class Color {
    String primary;
    String secondary;

    Color({
        required this.primary,
        required this.secondary,
    });

    factory Color.fromJson(Map<String, dynamic> json) => Color(
        primary: json["primary"],
        secondary: json["secondary"],
    );

    Map<String, dynamic> toJson() => {
        "primary": primary,
        "secondary": secondary,
    };
}

class Insight {
    int totalViews;
    int totalLikes;
    int totalShares;
    int totalOrders;
    double totalRevenue;
    int totalProducts;

    Insight({
        required this.totalViews,
        required this.totalLikes,
        required this.totalShares,
        required this.totalOrders,
        required this.totalRevenue,
        required this.totalProducts,
    });

    factory Insight.fromJson(Map<String, dynamic> json) => Insight(
        totalViews: json["totalViews"],
        totalLikes: json["totalLikes"],
        totalShares: json["totalShares"],
        totalOrders: json["totalOrders"],
        totalRevenue: json["totalRevenue"]?.toDouble(),
        totalProducts: json["totalProducts"],
    );

    Map<String, dynamic> toJson() => {
        "totalViews": totalViews,
        "totalLikes": totalLikes,
        "totalShares": totalShares,
        "totalOrders": totalOrders,
        "totalRevenue": totalRevenue,
        "totalProducts": totalProducts,
    };
}

class Owner {
    String name;
    String email;
    String userId;
    String phone;
    String address;

    Owner({
        required this.name,
        required this.email,
        required this.userId,
        required this.phone,
        required this.address,
    });

    factory Owner.fromJson(Map<String, dynamic> json) => Owner(
        name: json["name"],
        email: json["email"],
        userId: json["userId"],
        phone: json["phone"],
        address: json["address"],
    );

    Map<String, dynamic> toJson() => {
        "name": name,
        "email": email,
        "userId": userId,
        "phone": phone,
        "address": address,
    };
}
