import 'package:citizen_watch/components/login_container.dart';
import 'package:flutter/material.dart';

class NewAccountScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
      ),
      body: ListView(
        children: <Widget>[
          Container(height: 50),
          LoginContainer(
            headerText: "New Account",
            contentTextOne: "It looks like you are a new user. ",
            contentTextTwo:
                "Set a password for your account, and you’re good to go!",
            isNewAccount: true,
            hintTextOne: "Password",
            hintTextTwo: "ConfirmPassword",
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => NewAccountScreen(),
                ),
              );
            },
          )
        ],
      ),
    );
  }
}
