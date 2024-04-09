import 'package:flutter/material.dart';
import 'package:flutter_application/register_page.dart';
import 'package:flutter_application/login_page.dart';
import 'package:flutter_application/select_people_page.dart';

class Routes {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/login':
        return MaterialPageRoute(builder: (_) => LoginPage());
      case '/register':
        return MaterialPageRoute(builder: (_) => RegisterPage());
      case '/select':
        var params = (settings.arguments as Map<String, dynamic>);
        return MaterialPageRoute(builder: (_) => SelectPeoplePage(number: params['number']));
      default:
        return MaterialPageRoute(builder: (_) => Scaffold(body: Center(child: Text('No route defined for ${settings.name}'))));
    }
  }
}