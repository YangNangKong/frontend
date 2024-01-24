import 'package:flutter/material.dart';
import 'package:flutter_application/register_page.dart';
import 'package:flutter_application/select_people_page.dart';
import 'login_page.dart';

final routes = {
  '/login': (BuildContext context) => LoginPage(),
  '/register': (BuildContext context) => RegisterPage(),
  '/selectPeople': (BuildContext context) => SelectPeoplePage(),
};
