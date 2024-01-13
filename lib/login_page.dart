import 'dart:convert';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'login_form_data.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPage();
}

class _LoginPage extends State<LoginPage> {
  final formKey = GlobalKey<FormState>();
  LoginFormData formData = LoginFormData();
  static final storage = FlutterSecureStorage();
  dynamic userInfo = '';

  //flutter_secure_storage 사용을 위한 초기화 작업
  @override
  void initState() {
    super.initState();

    // 비동기로 flutter secure storage 정보를 불러오는 작업
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _asyncMethod();
    });
  }

  _asyncMethod() async {
    // read 함수로 key값에 맞는 정보를 불러오고 데이터타입은 String 타입
    // 데이터가 없을때는 null을 반환
    userInfo = await storage.read(key: 'login');
    // user의 정보가 있다면 로그인 후 들어가는 첫 페이지로 넘어가게 합니다.
    if (userInfo != null) {
      Navigator.pushNamed(context, '/');
    } else {
      print('로그인이 필요합니다');
    }
  }

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
                                Navigator.pushNamed(context, '/');
                              }
                            },
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.amber,
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
                                        ..onTap = () => Navigator.pushNamed(
                                            context, '/register')),
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
        Uri.parse('http://10.0.2.2:3000/login'),
        headers: <String, String>{
          'Content-Type': 'application/json',
        },
        body: json.encode(formData),
      );
      // print(result.body);
      if (result.statusCode == 200) {
        var val = json.encode(formData);
        print(val);
        await storage.write(
          key: 'login',
          value: val,
        );
        showToast("success");
        return true;
      } else {
        showToast("fail");
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
