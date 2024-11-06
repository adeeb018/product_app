import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import '../models/category.dart';
import '../models/product.dart';

class CategoriesRepository {

  final String categoryUrl = 'https://prethewram.pythonanywhere.com/api/Top_categories/';

  Future<List<Category>> fetchCategories() async {
    final response = await http.get(Uri.parse(categoryUrl));
    if (response.statusCode == 200) {
      debugPrint(response.body);
      List<dynamic> categoriesJson = jsonDecode(response.body);
      return categoriesJson.map((json) => Category.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load products');
    }
  }
}
