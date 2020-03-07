import 'package:citizen_watch/components/content_text.dart';
import 'package:citizen_watch/components/custom_text_field.dart';
import 'package:citizen_watch/components/header_text.dart';
import 'package:citizen_watch/components/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class AuthScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: ListView(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(top: 36.0),
            child: SvgPicture.asset('assets/images/app_name.svg'),
          ),
          Container(height: 50),
          Center(
            child: Text(
              'An initiative to save stray cows',
              style:
                  TextStyle(color: Colors.white.withOpacity(0.5), fontSize: 14),
            ),
          ),
          Container(height: 24),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              margin: EdgeInsets.fromLTRB(16, 35, 16, 32),
              padding: EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: Colors.white.withOpacity(0.4),
                ),
              ),
              child: Column(
                children: <Widget>[
                  Container(height: 32),
                  HeaderText(
                    text: "Let's get started",
                  ),
                  Container(height: 64),
                  ContentText(text: 'Please enter your phone number to login.'),
                  Container(height: 16),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: ContentText(
                      text:
                          'If you don’t have an account, it will be created for you.',
                    ),
                  ),
                  Container(height: 125),
                  CustomTextField(hintText: "Phone Number"),
                  Container(height: 20),
                  PrimaryButton(
                    buttonText: "Continue",
                    onPressed: () {},
                  ),
                  Container(height: 45)
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
