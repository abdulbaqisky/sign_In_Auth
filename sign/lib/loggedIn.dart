import 'package:flutter/material.dart';

class SignedIn extends StatelessWidget {
  const SignedIn({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Container(
          color: Colors.green,
        ),
      ),
    );
  }
}
