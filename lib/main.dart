import 'package:flutter/material.dart';
import 'package:as_textfield/Form.dart'
;
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      color: Colors.blue,

      //UN-COMMENT BELOW LINE, WANT TO JUMP ON DASHBOARD IF ALREADY LOGGED-IN
      home: UserForm(),
    );
  }
}