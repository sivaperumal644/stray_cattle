import 'package:citizen_watch/components/custom_text_field.dart';
import 'package:citizen_watch/components/header_text.dart';
import 'package:citizen_watch/components/primary_button.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          CustomTextField(hintText: 'Phone Number'),
          HeaderText(text: "Let's get Started"),
          PrimaryButton(buttonText: "Continue", onPressed: (){})
        ],
      ),
    );
  }
}

