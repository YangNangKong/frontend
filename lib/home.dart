import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:numeric_keyboard/numeric_keyboard.dart';

// List<String> dropDownList = ['1명', '2명', '3명', '4명', '5명 이상'];

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);
  final String title = '';

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController _textEditingController = TextEditingController();
  String text = '';
  String hintText = '핸드폰 번호를 입력 해주세요.';
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
    print(userInfo);
    // user의 정보가 있다면 로그인 후 들어가는 첫 페이지로 넘어가게 합니다.
    if (userInfo != null) {
    } else {
      print('로그인이 필요합니다');
    }
  }

  @override
  Widget build(BuildContext context) {
    bool isHintText = text.isEmpty || text == hintText;
    return Scaffold(
        appBar: AppBar(
          // automaticallyImplyLeading: false,
          centerTitle: true,
          backgroundColor: Colors.amber,
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
              child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(left: 150),
                    // fit: FlexFit.tight,
                    child: Container(
                      child: Image.asset(
                        "assets/images/waiting.jpg",
                        width: 450,
                        height: 450,
                      ),
                    ),
                  ),
                  Flexible(
                    fit: FlexFit.tight,
                    child: Column(
                      children: [
                        Text(
                          formatPhoneNumber(text, isHintText),
                          style: TextStyle(
                              fontSize: 30,
                              color:
                                  isHintText ? Colors.black26 : Colors.black),
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
                        // Row(
                        //   mainAxisAlignment: MainAxisAlignment.center,
                        //   children: [
                        //     Text(
                        //       '인원',
                        //       style: TextStyle(
                        //         fontSize: 30,
                        //       ),
                        //     ),
                        //     Container(
                        //       width: 100,
                        //       child: DropdownButton(
                        //         items: dropDownList.map<DropdownMenuItem<String>>((
                        //             String value) {
                        //           return DropdownMenuItem<String>(
                        //             value: value,
                        //             child: Text(
                        //               value,
                        //               style: TextStyle(
                        //                 fontSize: 20,
                        //               ),
                        //             ),
                        //           );
                        //         }).toList(), onChanged: (value) {},
                        //       )
                        //     ),
                        //   ],
                        // )
                      ],
                    ),
                  ),
                ],
              ),
            ],
          )),
        ));
  }

  _onKeyboardTap(String value) {
    setState(() {
      text = text + value;
    });
  }

  String formatPhoneNumber(String formatted, bool isHintText) {
    if (isHintText) {
      return hintText;
    }
    formatted = formatted.replaceAll(RegExp(r'\D'), ''); // 숫자 이외의 문자 제거
    if (formatted.length >= 4) {
      formatted = formatted.substring(0, 3) +
          '-' +
          formatted.substring(3, formatted.length > 7 ? 7 : formatted.length) +
          (formatted.length >= 8
              ? '-' + formatted.substring(7, formatted.length)
              : '');
    }
    return formatted;
  }
}
