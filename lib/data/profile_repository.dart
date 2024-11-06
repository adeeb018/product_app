import 'dart:convert';

import '../models/user_profile.dart';
import 'package:http/http.dart' as http;

class ProfileRepository {
  final String baseUrl = "https://api.escuelajs.co/api/v1"; // API base URL
  final String accessToken; // Access token for authorization

  ProfileRepository({required this.accessToken});

  // Fetch the user profile data
  Future<UserProfile> getProfile() async {
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
  }
}