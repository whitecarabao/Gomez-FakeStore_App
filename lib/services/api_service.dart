import 'package:gomez_store_app/models/product.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../models/cart.dart';

class ApiService {
  static const String baseUrl = 'https://fakestoreapi.com';
  static const String productsUrl = '$baseUrl/products';

  Future<List<Product>> getProductsByCategory(String categoryName) {
    print(
        "getting items from " + baseUrl + "/products/category/" + categoryName);
    return http
        .get(Uri.parse(baseUrl + "/products/category/" + categoryName))
        .then((response) {
      print(response.body);
      final List<Product> products = List<Product>.from(
          json.decode(response.body).map((x) => Product.fromJson(x)));
      return products;
    });
  }

  Future<dynamic> get(String s) async {
    var response = http.get(Uri.parse(s)).then((resp) {
      if (resp.statusCode == 200) {
        return json.decode(resp.body);
      } else {
        return {'errMsg': 'Error occured'};
      }
      return {'errMsg': 'Error occured'};
    });
  }

  Future<Product?> getProduct(id) {
    print("getting product from " + baseUrl + "/products/" + id.toString());
    return http.get(Uri.parse(baseUrl + "/products/" + id.toString())).then((resp) {
      print("getProd via ID: " + resp.body);
      if (resp.statusCode == 200) {
        return Product.fromJson(json.decode(resp.body));
      } else {
        return null;
      }
    });
  }

  updateCart(int qty, int id) {
    return http
        .put(Uri.parse(baseUrl + "/carts/2"),
            body: json.encode({
              'userId': 2,
              'date': DateTime.now().toIso8601String(),
              'products': [
                {'productId': id, 'quantity': qty}
              ]
            }))
        .then((resp) {
      print("premature response: " + resp.body);
      if (resp.statusCode == 200) {
        print("cart" + resp.body);
        return json.decode(resp.body);
      } else {
        return {'errMsg': 'Error occured'};
      }
    });
  }

  Future<List<Product>> getAllProducts() {
    return http.get(Uri.parse(baseUrl + "/products")).then((resp) {
      if (resp.statusCode == 200) {
        //sprint(json.decode(resp.body));
        return (json.decode(resp.body) as List<dynamic>)
            .map((e) => Product.fromJson(e))
            .toList();
      } else {
        return [];
      }
    });
  }

  login(String user, String pass) async {
    print("login api called");
    return http.post(Uri.parse("$baseUrl/auth/login"), body: {
      "username": user,
      "password": pass,
    }).then((resp) {
      print(resp.body);
      return json.decode(resp.body);
    });
  }

  Future<Cart> getCart(String s) async {
    return http.get(Uri.parse(baseUrl + "/carts/2")).then((resp) {
      if (resp.statusCode == 200) {
        print("cart getCart func for cart $s called: ${json.decode(resp.body)['products']}");
        return Cart.fromJson(json.decode(resp.body));
      } else {
        return Cart(
            id: 2, userId: 2, products: <Product>[], date: DateTime.now());
      }
    });
  }

  deleteCart(String s) {
    return http.delete(Uri.parse(baseUrl + "/carts/" + s)).then((resp) {
      if (resp.statusCode == 200) {
        return json.decode(resp.body);
      } else {
        return {'errMsg': 'Error occured'};
      }
    });
  }

  getAllCategories() {
    return http.get(Uri.parse(baseUrl + "/products/categories")).then((resp) {
      if (resp.statusCode == 200) {
        return json.decode(resp.body);
      } else {
        return {'errMsg': 'Error occured'};
      }
    });
  }
}
