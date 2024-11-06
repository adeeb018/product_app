import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import '../models/product.dart';

class ProductsRepository {

  final String productsUrl = 'https://prethewram.pythonanywhere.com/api/parts_categories/';
  // final String productsUrl = 'https://prethewram.pythonanywhere.com/api/Top_categories/';

  Future<List<Product>> fetchProducts() async {
    final response = await http.get(Uri.parse(productsUrl));
    if (response.statusCode == 200) {
      // debugPrint(response.body);
      List<dynamic> productJson = jsonDecode(response.body);
      return productJson.map((json) => Product.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load products');
    }
  }
}
