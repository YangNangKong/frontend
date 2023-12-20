import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:numeric_keyboard/numeric_keyboard.dart';

List<String> dropDownList = ['1명', '2명', '3명', '4명', '5명 이상'];

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);
  final String title = '';

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String text = '';
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
    userInfo = await storage.read(key:'login');
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
          backgroundColor: Colors.amber,
          title: Text(
              "YNK Tabling",
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              )
          ),
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
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  children: <Widget>[
                    Flexible(
                      fit: FlexFit.tight,
                      child: Container(
                        child: Image.network(
                          "https://tumblbug-pci.imgix.net/c854afea9f2858de047ed6c4037079a86d8e85c2/4ca37de55d78bcfd0d96d1a157d808698c143913/1dfc9a35b736b925bc75efe3f532a229991851d6/855bab0e-496b-4693-a436-4472cf71184c.jpeg?ixlib=rb-1.1.0&w=1240&h=930&auto=format%2Ccompress&lossless=true&fit=crop&s=3763fe763047bf77397bc94117ff2984",
                          width: 400,
                          // height: 400,
                        ),
                      ),
                    ),
                    Flexible(
                      fit: FlexFit.tight,
                      child: Column(
                        children: [
                          Text(text,
                            style: TextStyle(
                              fontSize: 30,
                            ),
                          ),
                          Container(
                            width: 700,
                            // color: Colors.orange,
                            child: NumericKeyboard(
                              onKeyboardTap: _onKeyboardTap,
                              textColor: Colors.black,
                              rightButtonFn: () {
                                setState(() {
                                  text = text.substring(0, text.length - 1);
                                });
                              },
                              rightIcon: Icon(
                                Icons.backspace,
                                color: Colors.black,
                              ),
                              leftButtonFn: () {
                                print('left button clicked');
                              },
                              leftIcon: Icon(
                                Icons.check,
                                color: Colors.black,
                              ),
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                '인원',
                                style: TextStyle(
                                  fontSize: 30,
                                ),
                              ),
                              Container(
                                width: 100,
                                child: DropdownButton(
                                  items: dropDownList.map<DropdownMenuItem<String>>((
                                      String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(
                                        value,
                                        style: TextStyle(
                                          fontSize: 20,
                                        ),
                                      ),
                                    );
                                  }).toList(), onChanged: (value) {},
                                )
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            )
          ),
        )
    );
  }

  _onKeyboardTap(String value) {
    setState(() {
      text = text + value;
    });
  }
}