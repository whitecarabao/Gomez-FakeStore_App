import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

class Product {
  late int id;
  late int productId;
  late String title;
  late String description;
  late dynamic price;
  late int? quantity;
  late String image;
  late String category;

  Product(
      {required this.id, required this.title, required this.description, required this.price, required this.image, required this.quantity, required this.category});
toJson() => {
    'id': id,
    'productId': productId,
    'title': title,
    'description': description,
    'price': price,
    'quantity': quantity,
    'image': image,
    'category': category
  };
  factory Product.fromJson(Map<String, dynamic> json){
    //print("hello! fromJson()");
    //print("testProd " + json['productId']);


    return Product(

      id: json['productId'] != null ? json['productId'] : json['id'],
      title: json['title'],
      description: json['description'],
      price: json['price'],
      image: json['image'],
      category: json['category'],
      quantity: json['quantity'],

    );
  }



}