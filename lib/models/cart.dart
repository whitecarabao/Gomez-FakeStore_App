//create model for fakestore api cart
import 'package:gomez_store_app/models/product.dart';
import 'package:json_annotation/json_annotation.dart';

part 'cart.g.dart';

@JsonSerializable()
class Cart {
  int? id;
  int userId;
  List<dynamic> products;
  DateTime date;

  Cart(
      {required this.id, required this.userId, required this.products, required this.date});

  factory Cart.fromJson(Map<String, dynamic> json) => _$CartFromJson(json);

  Map<String, dynamic> toJson() => _$CartToJson(this);
}



