import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_application/page/home_page.dart';
import 'package:flutter_application/token_manager.dart';
import 'package:flutter_application/widget/app_bar_widget.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;

class SelectPeoplePage extends StatefulWidget {
  final String number;

  SelectPeoplePage({required this.number});

  @override
  _SelectPeoplePageState createState() => _SelectPeoplePageState();
}

class _SelectPeoplePageState extends State<SelectPeoplePage> {
  final String title = '';
  String selected = '';
  final List<String> peopleCountList = ['1명', '2명', '3명', '4명', '5명 이상'];

  @override
  void initState() {
    super.initState();
    setState(() {
      selected = peopleCountList[0];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(),
      body: Center(
        child: SingleChildScrollView(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                '인원 수',
                style: TextStyle(
                  fontSize: 30,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10.0),
                child: Container(
                  width: 150,
                  height: 60,
                  margin: EdgeInsets.only(left: 50),
                  child: DropdownButton(
                    value: selected,
                    items: peopleCountList
                        .map(
                          (e) => DropdownMenuItem(
                            value: e, // 선택 시 onChanged 를 통해 반환할 value
                            child: Text(e),
                          ),
                        )
                        .toList(),
                    onChanged: (value) {
                      // items 의 DropdownMenuItem 의 value 반환
                      setState(() {
                        selected = value!;
                      });
                    },
                    borderRadius: BorderRadius.circular(10),
                    menuMaxHeight: 300,
                    isExpanded: true,
                    alignment: Alignment.bottomLeft,
                    iconSize: 40,
                    style: TextStyle(fontSize: 25, color: Colors.black),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 30),
                child: Container(
                  child: ElevatedButton(
                    onPressed: () async {
                      registerWaiting(widget.number, selected);
                    },
                    style: ElevatedButton.styleFrom(
                        padding:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                        backgroundColor: Colors.blueAccent),
                    child: Text(
                      '확인',
                      style: TextStyle(
                        fontSize: 30,
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<void> registerWaiting(String number, dynamic people) async {
    var result;
    Map<String, dynamic> data = {
      'shop_id': 1,
      'tabling_type': "waiting",
      'personnel': int.parse(((people.replaceAll("명", "")).replaceAll("이상", "").trim())),
      'phone_number': formatPhoneNumber(number),
    };

    String? token = await TokenManager.getToken();
    if (token != null) {
      result = await http.post(
        // http://34.22.93.157:3000
        Uri.parse('http://10.0.2.2:3000/tabling/waiting-list/add'),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ' + token,
        },
        body: json.encode(data),
      );
    } else {
      Navigator.of(context).pushNamed('/login');
      print("로그인실패");
    }

    if (result != null && result.statusCode == 201) {
      showToast("success");
      // 제거할 경로가 더 이상 남지 않을 때까지 스택의 모든 경로를 제거
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => HomePage()),
          (Route<dynamic> route) => false);
    } else {
      showToast("fail");
    }
  }

  String formatPhoneNumber(String phoneNumber) {
    if (phoneNumber.length != 11) {
      return phoneNumber;
    }

    String firstPart = phoneNumber.substring(0, 3);
    String secondPart = phoneNumber.substring(3, 7);
    String thirdPart = phoneNumber.substring(7);

    return '$firstPart-$secondPart-$thirdPart';
  }

  void showToast(result) {
    if (result == "success") {
      Fluttertoast.showToast(
        msg: "정상적으로 등록되었습니다.",
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.blue,
        textColor: Colors.white,
        fontSize: 20,
      );
    } else {
      Fluttertoast.showToast(
        msg: "등록에 실패했습니다. 관리자에게 문의해주세요.",
        gravity: ToastGravity.CENTER,
        backgroundColor: Colors.red,
        textColor: Colors.black,
        fontSize: 20,
      );
    }
  }
}
