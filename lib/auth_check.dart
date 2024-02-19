import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'home_page.dart';
import 'login_page.dart';

class AuthCheck extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _isLoggedIn(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator(); // 인증 상태를 확인하는 동안 로딩 중 표시
        }
        if (snapshot.hasData && snapshot.data == true) {
          return HomePage(); // 사용자가 로그인된 상태라면 홈 페이지 표시
        } else {
          return LoginPage(); // 사용자가 로그인되지 않은 상태라면 로그인 페이지 표시
        }
      },
    );
  }

  Future<bool> _isLoggedIn() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token'); // SharedPreferences에서 토큰을 불러옴
    print(token);
    return token != null; // 토큰이 null이 아니면 사용자가 로그인된 상태로 판단
  }
}
