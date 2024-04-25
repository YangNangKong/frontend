import 'package:flutter/material.dart';
import 'package:flutter_application/auth_check.dart';
import 'package:flutter_application/page/register_page.dart';
import 'package:flutter_application/page/login_page.dart';
import 'package:flutter_application/page/select_people_page.dart';
import 'package:flutter_application/page/tabling_list_page.dart';
import 'package:go_router/go_router.dart';

final GoRouter router = GoRouter(
  debugLogDiagnostics: true,
  initialLocation: '/',
  routes: <RouteBase>[
    GoRoute(
      path: '/',
      builder: (BuildContext context, GoRouterState state) {
        return AuthCheck();
      },
    ),
    GoRoute(
      path: '/login',
      builder: (BuildContext context, GoRouterState state) {
        return LoginPage();
      },
    ),
    GoRoute(
      path: '/register',
      builder: (BuildContext context, GoRouterState state) {
        return RegisterPage();
      },
    ),
    GoRoute(
      path: '/select',
      builder: (BuildContext context, GoRouterState state) {
        return SelectPeoplePage(
            number: (state.extra as Map<String, dynamic>)["number"]);
      },
    ),
    GoRoute(
      path: '/waiting_list',
      builder: (BuildContext context, GoRouterState state) {
        return TablingListPage();
      },
    ),
  ],
);