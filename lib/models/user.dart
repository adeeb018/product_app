class User {
  final String accessToken;
  final String refreshToken;

  User({required this.accessToken, required this.refreshToken});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      accessToken: json['access_token'],
      refreshToken: json['refresh_token'],
    );
  }
}
