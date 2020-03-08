import 'package:citizen_watch/components/login_container.dart';
import 'package:citizen_watch/screens/home_screen.dart';
import 'package:flutter/material.dart';

class WelcomeBackScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(backgroundColor: Colors.black),
      body: ListView(
        children: <Widget>[
          Container(height: 50),
          LoginContainer(
            headerText: "Welcome Back",
            contentTextOne: "Please enter your password to continue",
            contentTextTwo: "",
            hintTextOne: "Password",
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => HomeScreen(),
                ),
              );
            },
          )
        ],
      ),
    );
  }
}
