class LoginFormData {
  String? username;
  String? password;

  LoginFormData({
    this.username,
    this.password,
  });

  Map<String, dynamic> toJson() => {
    'user_name': username,
    'password': password,
  };
}
