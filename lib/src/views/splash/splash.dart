import 'dart:async';
import 'package:flutter/material.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

import '../../services/session.dart';

class SplashScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => InitState();
}

class InitState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    startTimer();
  }

  startTimer() async {
    var durtion = Duration(seconds: 5);
    return new Timer(durtion, loginRoute);
  }

  loginRoute() async {
    if (await SessionManager.hasToken()) {
      Map<String, dynamic>? session = await SessionManager.getData();
      if (session != null) {
        Map<String, dynamic> tokenData = JwtDecoder.decode(session['token']);
        if (tokenData['role'] == 'admin') {
          Navigator.pushReplacementNamed(context, '/admin');
        } else {
          Navigator.pushReplacementNamed(context, '/user');
        }
      } else {
        print("Error: Data is not available");
        Navigator.pushReplacementNamed(context, '/login');
      }
    } else {
      Navigator.pushReplacementNamed(context, '/login');
    }
  }

  @override
  Widget build(BuildContext context) {
    return initWidget();
  }

  Widget initWidget() {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Container(
            child: Image.asset(
          "assets/images/MyLogo.png",
          scale: 4,
        )),
      ),
    );
  }
}
