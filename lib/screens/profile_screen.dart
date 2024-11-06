import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../data/profile_repository.dart';
import '../models/user_profile.dart'; // Import UserProfile model

class ProfileScreen extends StatelessWidget {
  final String accessToken; // Access token passed to the screen

  ProfileScreen({required this.accessToken});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
      ),
      body: FutureBuilder<UserProfile>(
        future: ProfileRepository(accessToken: accessToken).getProfile(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          if (snapshot.hasData) {
            final profile = snapshot.data!; // UserProfile instance

            return Container(
              alignment: Alignment.center,
              child: Column(
                children: [
                  // Avatar
                  CircleAvatar(
                    radius: 50,
                    backgroundImage: NetworkImage(profile.avatar),
                    backgroundColor: Colors.grey[200],
                  ),
                  SizedBox(height: 16),
                  // Name
                  Text(
                    'Name: ${profile.name}',
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 8),
                  // Email
                  Text('Email: ${profile.email}', style: TextStyle(fontSize: 18)),
                  SizedBox(height: 8),
                  // Role
                  Text('Role: ${profile.role}', style: TextStyle(fontSize: 18)),
                  SizedBox(height: 8),
                  // CreatedAt
                  Text(
                    'Account Created: ${formatDate(profile.createdAt).toString()}',
                    style: TextStyle(fontSize: 18),
                  ),
                  SizedBox(height: 8),
                  // UpdatedAt
                  Text(
                    'Last Updated: ${formatDate(profile.updatedAt).toString()}',
                    style: TextStyle(fontSize: 18),
                  ),
                ],
              ),
            );
          }

          return Center(child: Text('No data available.'));
        },
      ),
    );
  }
  String formatDate(DateTime dateTime) {
    final DateFormat formatter = DateFormat('yyyy-MM-dd'); // You can customize the format
    return formatter.format(dateTime); // Returns the formatted date as a string
  }
}