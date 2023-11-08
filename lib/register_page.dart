import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class RegisterPage extends StatelessWidget {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  RegisterPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.amber,
        title: Text("YNK Tabling",
            style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            )),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  width: 300,
                  child: TextField(
                    controller: nameController,
                    decoration: InputDecoration(
                      labelText: "이름",
                    ),
                  ),
                ),
                SizedBox(
                  width: 300,
                  child: TextField(
                    obscureText: true,
                    controller: passwordController,
                    decoration: InputDecoration(
                      labelText: "비밀 번호",
                    ),
                  ),
                ),
                SizedBox(
                  width: 300,
                  child: TextField(
                    obscureText: true,
                    controller: emailController,
                    decoration: InputDecoration(
                      labelText: "이메일",
                    ),
                  ),
                ),
                SizedBox(
                  width: 300,
                  child: TextField(
                    controller: phoneNumberController,
                    decoration: InputDecoration(
                      labelText: "핸드폰 번호",
                    ),
                  ),
                ),
                Container(
                  width: 250,
                  margin: EdgeInsets.only(top: 24),
                  child: ElevatedButton(
                      onPressed: postUserRequest,
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.amber,
                          foregroundColor: Colors.black38),
                      child: Text("회원 가입")),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> postUserRequest() async {
    var response = await http.post(
      Uri.parse('http://localhost:3000/url'),
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'name': nameController.text,
        'user_type': 'master',
        'password': passwordController.text,
        'email': emailController.text,
        'phone_number': phoneNumberController.text,
      }),
    );
    print(response.body);
    // return response.body; //반환받은 데이터(이메일) 반환
  }
}
