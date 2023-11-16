class LoginFormData {
  String? username;
  String? password;

  LoginFormData({
    this.username,
    this.password,
  });

  Map<String, dynamic> toJson() => {
    'username': username,
    'password': password,
  };
}
