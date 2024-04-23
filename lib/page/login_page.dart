import 'dart:convert';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application/token_manager.dart';
import 'package:flutter_application/widget/app_bar_widget.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';
import 'package:http/http.dart' as http;
import '../model/login_form_data.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPage();
}

class _LoginPage extends State<LoginPage> {
  final formKey = GlobalKey<FormState>();
  LoginFormData formData = LoginFormData();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(
        hasBack: false,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Center(
              child: Form(
                  key: formKey,
                  child: Column(
                    children: [
                      Container(
                        child: Text(
                          "Login",
                          style: TextStyle(
                            fontSize: 35,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        margin: EdgeInsets.only(top: 50),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(32),
                        child: Image.asset(
                          "assets/images/login.jpg",
                          width: 250,
                          height: 250,
                        ),
                      ),
                      Container(
                          width: 400,
                          child: TextFormField(
                              keyboardType: TextInputType.text,
                              decoration: InputDecoration(
                                labelText: "이메일",
                              ),
                              onChanged: (value) {
                                formData.username = value;
                              })),
                      Container(
                        width: 400,
                        child: TextField(
                            keyboardType: TextInputType.text,
                            obscureText: true,
                            decoration: InputDecoration(
                              labelText: "비밀번호",
                            ),
                            onChanged: (value) {
                              formData.password = value;
                            }),
                      ),
                      Container(
                        width: 400,
                        margin: EdgeInsets.only(top: 24),
                        child: ElevatedButton(
                            onPressed: () async {
                              if (await login() == true) {
                                showToast("success");
                              } else {
                                showToast("fail");
                              }
                            },
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.blueAccent,
                                foregroundColor: Colors.black),
                            child: Text("로그인")),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 10),
                        child: Column(
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
                                        ..onTap =
                                            () => context.push('/register')),
                                ],
                              ),
                            ),
                          ],
                        ),
                        // margin: EdgeInsets.only(bottom: 50),
                      )
                    ],
                  ))),
        ),
      ),
    );
  }

  Future<bool> login() async {
    try {
      var result = await http.post(
        // http://34.22.93.157:3000
        Uri.parse('http://localhost:3000/login'),
        headers: <String, String>{
          'Content-Type': 'application/json',
        },
        body: json.encode(formData),
      );
      print(result.body);
      print(formData.username);
      if (result.statusCode == 200) {
        TokenManager.setToken(json.decode(result.body)['token']);
        if (formData.username == 'masterNangKong') {
          print("들어와요?");
          // 마스터 계정일 때 관리 페이지로 (임시)
          context.go('/waiting_list');
        } else {
          // 로그인 후에는 홈 페이지로 이동
          context.go('/');
        }
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print(e);
      return false;
    }
  }

  void showToast(result) {
    if (result == "success") {
      Fluttertoast.showToast(
        msg: "로그인 되었습니다.",
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.blue,
        textColor: Colors.white,
        fontSize: 20,
      );
    } else {
      Fluttertoast.showToast(
        msg: "로그인에 실패하였습니다.",
        gravity: ToastGravity.CENTER,
        backgroundColor: Colors.red,
        textColor: Colors.black,
        fontSize: 20,
      );
    }
  }
}
