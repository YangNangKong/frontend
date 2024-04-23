class RegisterFormData {
  String? username;
  String? password;
  String? email;
  String? phoneNumber;
  String userType = 'member';

  RegisterFormData({
    this.username,
    this.password,
    this.email,
    this.phoneNumber,
  });

  Map<String, dynamic> toJson() => {
    'user_name': username,
    'password': password,
    'email': email,
    'phone_number': phoneNumber,
    'user_type': userType
  };
}
