import 'package:flutter/material.dart';
import 'package:flutter_application/auth_check.dart';
import 'package:flutter_application/page/home_page.dart';
import 'package:flutter_application/page/register_page.dart';
import 'package:flutter_application/page/login_page.dart';
import 'package:flutter_application/page/select_people_page.dart';
import 'package:flutter_application/page/waiting_list_page.dart';
import 'package:go_router/go_router.dart';

final GoRouter router = GoRouter(
  initialLocation: '/auth',
  routes: <RouteBase>[
    GoRoute(
      path: '/',
      builder: (BuildContext context, GoRouterState state) {
        return const HomePage();
      },
      routes: <RouteBase>[
        GoRoute(
          path: 'auth',
          builder: (BuildContext context, GoRouterState state) {
            return AuthCheck();
          },
        ),
        GoRoute(
          path: 'login',
          builder: (BuildContext context, GoRouterState state) {
            return LoginPage();
          },
        ),
        GoRoute(
          path: 'register',
          builder: (BuildContext context, GoRouterState state) {
            return RegisterPage();
          },
        ),
        GoRoute(
          path: 'select',
          builder: (BuildContext context, GoRouterState state) {
            return SelectPeoplePage(number: (state.extra as Map<String, dynamic>)["number"]);
          },
        ),
        GoRoute(
          path: 'waiting_list',
          builder: (BuildContext context, GoRouterState state) {
            return WaitingListPage();
          },
        ),
      ],
    ),
  ],
);


// class Routes {
//   static Route<dynamic> generateRoute(RouteSettings settings) {
//     switch (settings.name) {
//       case '/':
//         return MaterialPageRoute(builder: (_) => HomePage());
//       case '/auth':
//         return MaterialPageRoute(builder: (_) => AuthCheck());
//       case '/login':
//         return MaterialPageRoute(builder: (_) => LoginPage());
//       case '/register':
//         return MaterialPageRoute(builder: (_) => RegisterPage());
//       case '/select':
//         var params = (settings.arguments as Map<String, dynamic>);
//         return MaterialPageRoute(builder: (_) => SelectPeoplePage(number: params['number']));
//       case '/waiting_list':
//         return MaterialPageRoute(builder: (_) => WaitingListPage());
//       default:
//         return MaterialPageRoute(builder: (_) => Scaffold(body: Center(child: Text('No route defined for ${settings.name}'))));
//     }
//   }
// }