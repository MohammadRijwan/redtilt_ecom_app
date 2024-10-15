// To parse this JSON data, do
//
//     final product = productFromJson(jsonString);

import 'dart:convert';

List<Product> productFromJson(String str) =>
    List<Product>.from(json.decode(str).map((x) => Product.fromJson(x)));

String productToJson(List<Product> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Product {
  final int? id;
  final String? title;
  final double? price;
  final String? description;
  final String? image;
  final int qty;

  Product({
    this.id,
    this.title,
    this.price,
    this.description,
    this.image,
    this.qty = 0,
  });

  Product copyWith({
    int? id,
    String? title,
    double? price,
    String? description,
    String? image,
    int? qty,
  }) {
    return Product(
      id: id ?? this.id,
      title: title ?? this.title,
      price: price ?? this.price,
      description: description ?? this.description,
      image: image ?? this.image,
      qty: qty ?? this.qty,
    );
  }

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        id: json["id"],
        title: json["title"],
        price: json["price"]?.toDouble(),
        description: json["description"],
        image: json["image"],
        qty: json["qty"] ?? 0,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "price": price,
        "description": description,
        "image": image,
        "qty": qty,
      };
}
