import 'package:flutter/material.dart';
import 'package:flutter_application/select_people_page.dart';
import 'package:flutter_application/widget/app_bar_widget.dart';
import 'package:numeric_keyboard/numeric_keyboard.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  final String title = '';

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String text = '';
  String hintText = '핸드폰 번호를 입력 해주세요.';

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    bool isHintText = text.isEmpty || text == hintText;
    return Scaffold(
      appBar: AppBarWidget(),
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
                            color: isHintText ? Colors.black26 : Colors.black),
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
                            if (text.length == 11) {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      SelectPeoplePage(number: text),
                                ),
                              );
                            }
                          },
                          leftIcon: Icon(
                            Icons.check,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        )),
      ),
    );
  }

  String formatPhoneNumber(String formatted, bool isHintText) {
    if (isHintText) {
      return hintText;
    }
    if (formatted.length > 11) {
      // 11자리 이상 입력방지
      formatted = formatted.substring(0, 11);
    }
    // 숫자 이외의 문자 제거
    formatted = formatted.replaceAll(RegExp(r'\D'), '');
    // 핸드폰 번호 포맷팅
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

  _onKeyboardTap(String value) {
    setState(() {
      text = text + value;
    });
  }
}
