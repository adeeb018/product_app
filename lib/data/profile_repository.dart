import 'dart:convert';

import 'package:flutter/cupertino.dart';

import '../models/user_profile.dart';
import 'package:http/http.dart' as http;

import '../utils/network_utils.dart';
import '../widgets/show_dialogue.dart';

class ProfileRepository {
  final String baseUrl = "https://api.escuelajs.co/api/v1"; // API base URL
  final String accessToken; // Access token for authorization

  ProfileRepository({required this.accessToken});

  // Fetch the user profile data
  Future<UserProfile> getProfile(BuildContext context) async {

    if (!(await NetworkUtils.isConnected())) {
      throw Exception('No internet connection');
    } else {
      try {
        final response = await http.get(
          Uri.parse('$baseUrl/auth/profile'), // Assuming '/auth/profile' is the endpoint for profile data
          headers: {
            'Authorization': 'Bearer $accessToken', // Attach the access token in header
          },
        );

        if (response.statusCode == 200) {
          // If the response is successful, return the parsed UserProfile
          return UserProfile.fromJson(jsonDecode(response.body));
        } else {
          throw Exception('Failed to load profile');
        }
      } catch (e) {
        ShowMyDialogue.showErrorDialog(context, "Network error: $e");
        throw Exception('Network Error');
      }
    }

  }
}