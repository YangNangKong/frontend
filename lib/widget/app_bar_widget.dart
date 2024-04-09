import 'package:flutter/material.dart';
import 'package:flutter_application/login_page.dart';
import 'package:flutter_application/token_manager.dart';

class AppBarWidget extends StatefulWidget implements PreferredSizeWidget {
  final String currentPage;

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);

  AppBarWidget({Key? key, required this.currentPage}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _AppBarWidgetState();
}

class _AppBarWidgetState extends State<AppBarWidget> with RouteAware {
  final String adminPassword = "exit"; // 임시 로그아웃 비밀번호
  final Future<String?> token = TokenManager.getToken();
  TextEditingController passwordController = TextEditingController();
  bool _isHasLeading = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.currentPage != '/' && widget.currentPage != '/login') {
      setState(() {
        _isHasLeading = true;
      });
    }
    return AppBar(
      leading: _isHasLeading
          ? IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pop(context);
              },
            )
          : null,
      centerTitle: true,
      backgroundColor: Colors.blueAccent,
      title: Text(
        "YNK Tabling",
        style: TextStyle(
          fontSize: 32,
          fontWeight: FontWeight.bold,
          color: Colors.black87,
        ),
      ),
      actions: [
        // 로그인 되어 토큰이 발급된 상태에만 로그아웃 표시
        FutureBuilder<String?>(
          future: token,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done &&
                snapshot.hasData &&
                snapshot.data is String) {
              return Tooltip(
                message: '로그아웃',
                child: IconButton(
                  icon: Icon(Icons.exit_to_app),
                  onPressed: () async {
                    showDialog(
                      context: context,
                      barrierDismissible: true, //바깥 영역 터치시 닫을지 여부 결정
                      builder: ((context) {
                        return AlertDialog(
                          title: Text("로그아웃"),
                          content: TextField(
                            controller: passwordController,
                            obscureText: true,
                            decoration: InputDecoration(hintText: "관리자 비밀번호"),
                          ),
                          actions: <Widget>[
                            Container(
                              child: ElevatedButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: Text("취소"),
                              ),
                            ),
                            Container(
                              child: ElevatedButton(
                                onPressed: () {
                                  if (passwordController.text.toLowerCase() ==
                                      adminPassword) {
                                    // 비밀번호가 일치하는 경우 로그아웃
                                    TokenManager.removeToken();
                                    Navigator.of(context).pushAndRemoveUntil(
                                        MaterialPageRoute(
                                            builder: (context) => LoginPage()),
                                        (Route<dynamic> route) => false);
                                  } else {
                                    // 비밀번호가 일치하지 않는 경우
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text("비밀번호가 일치하지 않습니다."),
                                        duration: Duration(seconds: 2),
                                      ),
                                    );
                                  }
                                },
                                child: Text("확인"),
                              ),
                            ),
                          ],
                        );
                      }),
                    );
                  },
                ),
              );
            } else {
              return SizedBox();
            }
          },
        ),
      ],
    );
  }
}

class RouteObserverProvider extends InheritedWidget {
  final RouteObserver<Route> routeObserver;

  RouteObserverProvider({required this.routeObserver, required Widget child})
      : super(child: child);

  static RouteObserverProvider of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<RouteObserverProvider>()!;
  }

  @override
  bool updateShouldNotify(RouteObserverProvider oldWidget) {
    return routeObserver != oldWidget.routeObserver;
  }
}
