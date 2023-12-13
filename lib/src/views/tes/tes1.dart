import 'package:flutter/material.dart';

class Tes1 extends StatefulWidget {
  const Tes1({super.key});

  @override
  State<Tes1> createState() => _Tes1State();
}

class _Tes1State extends State<Tes1> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Text("user"),
      ),
    );
  }
}
