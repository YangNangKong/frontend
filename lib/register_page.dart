import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_application/register_form_data.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;

import 'home.dart';

class RegisterPage extends StatefulWidget {
  RegisterPage({Key? key}) : super(key: key);
  @override
  State<RegisterPage> createState() => _RegisterPage();
}

class _RegisterPage extends State<RegisterPage> {
  final formKey = GlobalKey<FormState>();
  RegisterFormData formData = RegisterFormData();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.blueAccent,
        title: Text("YNK Tabling",
            style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            )),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Center(
            child: Form(
              key: formKey,
              child: Column(
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
                        fontWeight: FontWeight.bold
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 300,
                    child: TextFormField(
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        labelText: "이름",
                      ),
                      onChanged: (value){
                        formData.username = value;
                      },
                    ),
                  ),
                  SizedBox(
                    width: 300,
                    child: TextFormField(
                      obscureText: true,
                      decoration: InputDecoration(
                        labelText: "비밀 번호",
                      ),
                      onChanged: (value){
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
                      onChanged: (value){
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
                      onChanged: (value){
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
                        child: Text(
                            "회원 가입",
                            style: TextStyle(
                          fontWeight: FontWeight.bold
                        )
                      )
                    ),
                  ),
                ],
              ),
            )
          ),
        ),
      ),
    );
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
    print(result.statusCode);
    if (result.statusCode == 201) {
      showToast("success");
      sleep(Duration(seconds: 1));
      Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage()));
    } else if (result.statusCode == 400) {
      // TODO: 유효성 검사에 실패한 필드에 실패 내용 노출
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
    } else {
      Fluttertoast.showToast(
        msg: "회원 등록에 실패하였습니다.",
        gravity: ToastGravity.CENTER,
        backgroundColor: Colors.red,
        textColor: Colors.black,
        fontSize: 20,
      );
    }
  }

}
