import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SelectPeoplePage extends StatefulWidget {
  SelectPeoplePage({Key? key}) : super(key: key);

  @override
  _SelectPeoplePageState createState() => _SelectPeoplePageState();
}

class _SelectPeoplePageState extends State<SelectPeoplePage> {
  static final storage = FlutterSecureStorage();
  final String title = '';
  dynamic userInfo = '';
  String selected = '';
  final List<String> peopleCountList = ['1명', '2명', '3명', '4명', '5명 이상'];

  //flutter_secure_storage 사용을 위한 초기화 작업
  @override
  void initState() {
    super.initState();
    setState(() {
      print(22);
      print(peopleCountList[0]);
      selected = peopleCountList[0];
    });

    // 비동기로 flutter secure storage 정보를 불러오는 작업
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _asyncMethod();
    });
  }

  _asyncMethod() async {
    // read 함수로 key값에 맞는 정보를 불러오고 데이터타입은 String 타입
    // 데이터가 없을때는 null을 반환
    userInfo = await storage.read(key: 'login');
    print(userInfo);
    // user의 정보가 있다면 로그인 후 들어가는 첫 페이지로 넘어가게 합니다.
    if (userInfo != null) {
    } else {
      print('로그인이 필요합니다');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          // automaticallyImplyLeading: false,
          centerTitle: true,
          backgroundColor: Colors.blueAccent,
          title: Text("YNK Tabling",
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              )),
          actions: [
            IconButton(
              icon: Icon(Icons.account_circle),
              onPressed: () {
                Navigator.pushNamed(context, '/login');
              },
            ),
          ],
        ),
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
                    Navigator.pushNamed(context, '/');
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
        ))));
  }
}
