import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:product_app/widgets/show_dialogue.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../utils/network_utils.dart';

class AuthRepository {
  final String loginUrl = 'https://api.escuelajs.co/api/v1/auth/login';

  Future<void> login(String email, String password, BuildContext context) async {

    if (!(await NetworkUtils.isConnected())) {
      ShowMyDialogue.showErrorDialog(context, 'No internet connection. Please check your network.');
      throw Exception('No internet connection');
    }else {
      try {
        final response = await http.post(
          Uri.parse(loginUrl),
          body: jsonEncode({'email': email, 'password': password}),
          headers: {'Content-Type': 'application/json'},
        );
        if (response.statusCode == 201) {
          final body = jsonDecode(response.body);
          SharedPreferences prefs = await SharedPreferences.getInstance();
          await prefs.setString('access_token', body['access_token']);
        } else {
          throw Exception('Failed to load profile. ${response.body}');
        }
      } catch (e) {
        ShowMyDialogue.showErrorDialog(context, "Network error: $e");
        rethrow;
      }
    }
  }

  Future<void> logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('access_token');
  }
}
