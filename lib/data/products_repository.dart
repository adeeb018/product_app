import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import '../models/product.dart';
import '../utils/network_utils.dart';
import '../widgets/show_dialogue.dart';

class ProductsRepository {

  final String productsUrl = 'https://prethewram.pythonanywhere.com/api/parts_categories/';

  Future<List<Product>> fetchProducts(BuildContext context) async {

    if (!(await NetworkUtils.isConnected())) {
      ShowMyDialogue.showErrorDialog(context, 'No internet connection. Please check your network.');
      throw Exception('No internet connection');
    }else {
      try {
        final response = await http.get(Uri.parse(productsUrl));
        if (response.statusCode == 200) {
          debugPrint(response.body);
          List<dynamic> productJson = jsonDecode(response.body);
          return productJson.map((json) => Product.fromJson(json)).toList();
        } else {
          throw Exception('Failed to load products');
        }
      } catch (e) {
        ShowMyDialogue.showErrorDialog(context, "Network error: $e");
        rethrow;
      }
    }

  }
}
