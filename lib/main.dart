import 'package:citizen_watch/screens/login_screen.dart';
import 'package:flutter/material.dart';

main() => runApp(MyApp());

class MyApp extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: LoginScreen()
    );
  }

}