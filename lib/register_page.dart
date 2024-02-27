import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_application/register_form_data.dart';
import 'package:flutter_application/widget/app_bar_widget.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;

import 'home_page.dart';

class RegisterPage extends StatefulWidget {
  RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPage();
}

class _RegisterPage extends State<RegisterPage> {
  final formKey = GlobalKey<FormState>();
  RegisterFormData formData = RegisterFormData();
  bool _isDuplicatedCheckPass = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Center(
              child: Form(
            key: formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  margin: EdgeInsets.only(
                    top: 100,
                    bottom: 50,
                  ),
                  child: Text(
                    "회원 등록",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 24,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 300,
                      margin: EdgeInsets.only(left: 90),
                      child: TextFormField(
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                          labelText: "이름",
                        ),
                        onChanged: (value) {
                          formData.username = value;
                        },
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 10),
                      child: ElevatedButton(
                          onPressed: !_isDuplicatedCheckPass
                              ? () async {
                                  bool result =
                                      await checkDuplicated(formData.username);
                                  setState(() {
                                    _isDuplicatedCheckPass = result;
                                  });
                                }
                              : null,
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.lightGreen,
                              minimumSize: Size(50, 30)),
                          child: Text(
                            '중복 체크',
                          )),
                    )
                  ],
                ),
                SizedBox(
                  width: 300,
                  child: TextFormField(
                    obscureText: true,
                    decoration: InputDecoration(
                      labelText: "비밀 번호",
                    ),
                    onChanged: (value) {
                      formData.password = value;
                    },
                  ),
                ),
                SizedBox(
                  width: 300,
                  child: TextFormField(
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      labelText: "이메일",
                    ),
                    onChanged: (value) {
                      formData.email = value;
                    },
                  ),
                ),
                SizedBox(
                  width: 300,
                  child: TextFormField(
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      labelText: "핸드폰 번호",
                    ),
                    onChanged: (value) {
                      formData.phoneNumber = value;
                    },
                  ),
                ),
                Container(
                  width: 250,
                  margin: EdgeInsets.only(top: 24),
                  child: ElevatedButton(
                      onPressed: register,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blueAccent,
                        foregroundColor: Colors.white,
                      ),
                      child: Text("회원 가입",
                          style: TextStyle(fontWeight: FontWeight.bold))),
                ),
              ],
            ),
          )),
        ),
      ),
    );
  }

  Future<bool> checkDuplicated(String? username) async {
    // 유저 중복체크 로직
    print("중복체크를 시작합니다.");
    var result = await http.get(
      Uri.parse('http://10.0.2.2:3000/user?user_name=' + username!),
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
    );

    if (jsonDecode(result.body)['status'] == false) {
      return true;
    }
    return false;
  }

  Future<void> register() async {
    var result = await http.post(
      Uri.parse('http://10.0.2.2:3000/user'),
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
      body: jsonEncode(formData),
    );
    print(result.body);
    // print(result.statusCode);
    if (result.statusCode == 200) {
      showToast("success");
      sleep(Duration(seconds: 1));
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => HomePage()),
      );
    } else if (result.statusCode == 400) {
      // TODO: 유효성 검사에 실패한 필드에 실패 내용 노출
      Map<String, dynamic> decodedJson = json.decode(result.body);
      List<dynamic> errors = decodedJson['errors'];
      print(errors);
      List<String> fieldErrorMessages = [];
      for (var error in errors) {
        if (error['type'] == 'field') {
          fieldErrorMessages.add(error['msg']);
        }
      }
      // 결과 출력
      print(fieldErrorMessages);
      showToast("invalid");
    } else {
      showToast("fail");
    }
  }

  void showToast(result) {
    if (result == "success") {
      Fluttertoast.showToast(
        msg: "회원 등록에 성공했습니다.",
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.blue,
        textColor: Colors.white,
        fontSize: 20,
      );
    } else if (result == "fail") {
      Fluttertoast.showToast(
        msg: "회원 등록에 실패하였습니다.",
        gravity: ToastGravity.CENTER,
        backgroundColor: Colors.red,
        textColor: Colors.black,
        fontSize: 20,
      );
    } else {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('알림'),
            content: Text('입력하신 정보가 올바르지 않습니다.'),
            actions: [
              TextButton(
                child: Text('닫기'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }
  }
}
