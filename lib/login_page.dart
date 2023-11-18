import 'dart:convert';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application/register_page.dart';
import 'package:http/http.dart' as http;

import 'login_form_data.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({ Key? key }) : super(key: key);
  @override
  State<LoginPage> createState() => _LoginPage();
}

class _LoginPage extends State<LoginPage> {
  final formKey = GlobalKey<FormState>();
  LoginFormData formData = LoginFormData();

  @override
  void initState() {
  super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.amber,
        title: Text(
            "YNK Tabling",
            style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            )
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Center(
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(32),
                    child: Image.network(
                      "https://tumblbug-pci.imgix.net/c854afea9f2858de047ed6c4037079a86d8e85c2/4ca37de55d78bcfd0d96d1a157d808698c143913/1dfc9a35b736b925bc75efe3f532a229991851d6/855bab0e-496b-4693-a436-4472cf71184c.jpeg?ixlib=rb-1.1.0&w=1240&h=930&auto=format%2Ccompress&lossless=true&fit=crop&s=3763fe763047bf77397bc94117ff2984",
                      width: 400,
                      height: 400,
                    ),
                  ),
                  Container(
                      width: 400,
                      child: TextFormField(
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                            labelText: "이메일",
                          ),
                          onChanged: (value){
                            formData.username = value;
                          }
                      )
                  ),
                  Container(
                    width: 400,
                    child: TextField(
                        keyboardType: TextInputType.text,
                        obscureText: true,
                        decoration: InputDecoration(
                          labelText: "비밀번호",
                        ),
                        onChanged: (value){
                          formData.password = value;
                        }
                    ),
                  ),
                  Container(
                    width: 400,
                    margin: EdgeInsets.only(top: 24),
                    child: ElevatedButton(
                        onPressed: login,
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.amber,
                            foregroundColor: Colors.black38
                        ),
                        child: Text("관리자 로그인")
                    ),
                  ),
                  Column(
                    children: [
                      RichText(
                        text: TextSpan(
                          text: '아직 회원이 아니신가요? ',
                          style: TextStyle(
                            fontSize: 15,
                            color: Colors.black,
                          ),
                          children: <TextSpan>[
                            TextSpan(
                                text: '회원가입',
                                style: TextStyle(
                                  color: Colors.blueAccent,
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                ),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () => Navigator.push(context, MaterialPageRoute(builder: (context) => RegisterPage()))
                            ),
                          ],
                        ),
                      ),
                    ],
                  )
                ],
              ),
            )
          ),
        ),
      ),
    );
  }

  Future<void> login() async {
    var result = await http.post(
      Uri.parse('http://10.0.2.2:3000/login'),
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
      body: json.encode(formData),
    );
    // print(json.encode(formData));
    // print(result.body);
    if (result.statusCode == 200) {
      _showDialog('Successfully sign in');
    } else {
      _showDialog('Failed to sign in');
    }
  }

  void _showDialog(String message) {
    showDialog<void>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(message),
        actions: [
          TextButton(
            child: const Text('OK'),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ],
      ),
    );
  }
}