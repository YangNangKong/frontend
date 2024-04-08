import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  final FocusNode _idFocusNode = FocusNode();
  final FocusNode _passwordFocusNode = FocusNode();
  final FocusNode _confirmPasswordFocusNode = FocusNode();
  final FocusNode _emailFocusNode = FocusNode();
  final FocusNode _isPhoneNumberNode = FocusNode();
  Timer? _debounce;

  bool _isIdValid = false;
  bool _isConfirmPasswordValid = true;
  bool _isDuplicated = false;
  bool _checkPass = false;
  bool _isEmailValid = false;
  bool _isPhoneNumberValid = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: SingleChildScrollView(
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
                            focusNode: _idFocusNode,
                            keyboardType: TextInputType.text,
                            decoration: InputDecoration(
                              labelText: "이름",
                              suffixIcon: _isDuplicated
                                  ? Icon(Icons.error, color: Colors.red)
                                  : null,
                              errorText: _isDuplicated ? '중복된 아이디입니다.' : null,
                            ),
                            onChanged: (value) {
                              formData.username = value;
                              if (_isDuplicated) {
                                setState(() {
                                  _isDuplicated = false;
                                });
                              }
                              setState(() {
                                _isIdValid = value.isNotEmpty;
                              });
                            },
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 10),
                          child: ElevatedButton(
                              onPressed: !_isDuplicated && _isIdValid
                                  ? () async {
                                      bool result = await checkDuplicated(
                                          formData.username);
                                      if (!result && _isIdValid) {
                                        // 중복이 아니고 아이디가 유효하면 패스워드로 이동
                                        FocusScope.of(context)
                                            .requestFocus(_passwordFocusNode);
                                      }
                                      // print(result);
                                      setState(() {
                                        _checkPass = !result;
                                        _isDuplicated = result;
                                        _isIdValid = false;
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
                        controller: _passwordController,
                        focusNode: _passwordFocusNode,
                        decoration: InputDecoration(
                          labelText: "비밀 번호",
                          suffixIcon:
                              _confirmPasswordController.text.isNotEmpty &&
                                      !_isConfirmPasswordValid
                                  ? Icon(Icons.error, color: Colors.red)
                                  : null,
                          errorText:
                              _confirmPasswordController.text.isNotEmpty &&
                                      !_isConfirmPasswordValid
                                  ? '비밀번호가 일치하지 않습니다.'
                                  : null,
                        ),
                        onChanged: (value) {
                          formData.password = value;
                        },
                      ),
                    ),
                    SizedBox(
                      width: 300,
                      child: TextFormField(
                          obscureText: true,
                          controller: _confirmPasswordController,
                          focusNode: _confirmPasswordFocusNode,
                          decoration: InputDecoration(
                            labelText: '비밀번호 확인',
                            suffixIcon:
                                _confirmPasswordController.text.isNotEmpty &&
                                        !_isConfirmPasswordValid
                                    ? Icon(Icons.error, color: Colors.red)
                                    : null,
                            errorText:
                                _confirmPasswordController.text.isNotEmpty &&
                                        !_isConfirmPasswordValid
                                    ? '비밀번호가 일치하지 않습니다.'
                                    : null,
                          ),
                          onChanged: (value) {
                            if (value == '') {
                              setState(() {
                                _isConfirmPasswordValid = true;
                              });
                            }

                            if (_debounce?.isActive ?? false)
                              _debounce!.cancel();
                            _debounce = Timer(Duration(milliseconds: 1000), () {
                              setState(() {
                                _isConfirmPasswordValid =
                                    _confirmPasswordController.text ==
                                        _passwordController.text;
                              });
                            });
                          }),
                    ),
                    SizedBox(
                      width: 300,
                      child: TextFormField(
                        controller: _emailController,
                        keyboardType: TextInputType.emailAddress,
                        inputFormatters: [
                          FilteringTextInputFormatter.deny(RegExp(r'\s'))
                        ],
                        decoration: InputDecoration(
                          labelText: "이메일",
                          suffixIcon:
                              this._emailController.text != '' && !_isEmailValid
                                  ? Icon(Icons.error, color: Colors.red)
                                  : null,
                          errorText:
                              this._emailController.text != '' && !_isEmailValid
                                  ? '이메일 형식이 잘못되었습니다.'
                                  : null,
                        ),
                        onChanged: (value) {
                          formData.email = value;
                          if (_debounce?.isActive ?? false) _debounce!.cancel();
                          _debounce = Timer(Duration(milliseconds: 1000), () {
                            setState(() {
                              _isEmailValid =
                                  EmailValidator.validate(value.trim());
                            });
                          });
                        },
                      ),
                    ),
                    SizedBox(
                      width: 300,
                      child: TextFormField(
                        controller: _phoneNumberController,
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                          labelText: "핸드폰 번호 (-를 포함하여 입력)",
                          suffixIcon:
                              this._phoneNumberController.text.isNotEmpty &&
                                      !_isPhoneNumberValid
                                  ? Icon(Icons.error, color: Colors.red)
                                  : null,
                          errorText:
                              this._phoneNumberController.text.isNotEmpty &&
                                      !_isPhoneNumberValid
                                  ? '핸드폰 번호 형식이 잘못되었습니다.'
                                  : null,
                        ),
                        onChanged: (value) {
                          formData.phoneNumber = value;
                          if (_debounce?.isActive ?? false) _debounce!.cancel();
                          _debounce = Timer(Duration(milliseconds: 1000), () {
                            setState(() {
                              _isPhoneNumberValid = _validatePhoneNumber(value);
                            });
                          });
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
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _emailController.dispose();
    _phoneNumberController.dispose();
    _idFocusNode.dispose();
    _passwordFocusNode.dispose();
    _confirmPasswordFocusNode.dispose();
    _emailFocusNode.dispose();
    _isPhoneNumberNode.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
  }

  bool _validatePhoneNumber(String value) {
    final RegExp phoneNumberRegex = RegExp(r'^01[0-9]{1}-[0-9]{4}-[0-9]{4}$');
    return phoneNumberRegex.hasMatch(value);
  }

  Future<bool> checkDuplicated(String? username) async {
    // 유저 중복체크 로직
    var result = await http.get(
      Uri.parse('http://10.0.2.2:3000/user?user_name=' + username!),
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
    );
    if (jsonDecode(result.body)['status'] == false) {
      return false;
    }
    return true;
  }

  Future<void> register() async {
    // 유효성 검사 통과 못하면 리턴
    if (!_isConfirmPasswordValid ||
        !_checkPass ||
        !_isEmailValid ||
        !_isPhoneNumberValid) {
      return;
    }

    var result = await http.post(
      Uri.parse('http://10.0.2.2:3000/user'),
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
      body: jsonEncode(formData),
    );

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
      List<String> fieldErrorMessages = [];
      for (var error in errors) {
        if (error['type'] == 'field') {
          fieldErrorMessages.add(error['msg']);
        }
      }
      // 결과 출력
      // print(fieldErrorMessages);
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
