import 'package:catatan_harian_bps/src/providers/auth_providers.dart';
import 'package:catatan_harian_bps/src/views/login_page/login_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'src/views/home_page/home_page.dart';
import 'src/views/tes/tes.dart';
import 'src/views/tes/tes1.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => AuthProvider(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Catatan Harian BPS',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          scaffoldBackgroundColor: Colors.white,
          textTheme: TextTheme(
            headline6: TextStyle(color: Colors.blue),
            bodyText2: TextStyle(color: Colors.black87),
          ),
          inputDecorationTheme: InputDecorationTheme(
            border: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.blue),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.blue),
            ),
            labelStyle: TextStyle(color: Colors.blue),
          ),
          buttonTheme: ButtonThemeData(
            buttonColor: Colors.blue,
            textTheme: ButtonTextTheme.primary,
          ),
        ),
        initialRoute: '/login',
        routes: {
          '/': (context) => LoginPage(),
          '/login': (context) => LoginPage(),
          '/home': (context) => HomePage(),
          '/admin': (context) => Tes(),
          '/user': (context) => Tes1(),
        },
      ),
    );
  }
}
