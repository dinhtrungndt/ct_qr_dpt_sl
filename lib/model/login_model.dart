class LoginModel {
  final String accessToken;
  final String refreshToken;
  final Map<String, dynamic> profile;

  LoginModel({
    required this.accessToken,
    required this.refreshToken,
    required this.profile,
  });
  factory LoginModel.fromJson(Map<String, dynamic> json) {
    return LoginModel(
        accessToken: json['accessToken'],
        refreshToken: json['refreshToken'],
        profile: json['profile']);
  }
}

class User {
  static String no_ = "";
  static String name = "";
  static String site = "";
  static String token = "";
  static String company = "";
}
