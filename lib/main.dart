import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_application/routes.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'auth_check.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await initHiveForFlutter();
  final HttpLink _httpLink = HttpLink("http://10.0.2.2:3000/");
  final AuthLink _authLink = AuthLink(getToken: () async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.getString("token");
  });

  final Link link = _authLink.concat(_httpLink);

  var graphQLClient = GraphQLClient(
    link: link,
    cache: GraphQLCache(
      store: InMemoryStore(),
      partialDataPolicy: PartialDataCachePolicy.accept,
    ),
  );

  ValueNotifier<GraphQLClient> client = ValueNotifier(graphQLClient);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // final ValueNotifier<GraphQLClient> client;

  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // 가로 모드로 고정
    SystemChrome.setPreferredOrientations([DeviceOrientation.landscapeLeft]);
    // return GraphQLProvider(
    //     client: client,
    //     child: MaterialApp(
    //       debugShowCheckedModeBanner: false,
    //       theme: _buildTheme(Brightness.light),
    //       home: AuthCheck(),
    //       initialRoute: '/',
    //       routes: routes,
    //     ));
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: _buildTheme(Brightness.light),
      home: AuthCheck(),
      initialRoute: '/',
      routes: routes,
    );
  }

  ThemeData _buildTheme(brightness) {
    var baseTheme = ThemeData(brightness: brightness);

    return baseTheme.copyWith(
      textTheme: GoogleFonts.oswaldTextTheme(baseTheme.textTheme),
    );
  }
}
