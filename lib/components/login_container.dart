import 'package:citizen_watch/components/primary_button.dart';
import 'package:flutter/material.dart';
import 'content_text.dart';
import 'custom_text_field.dart';
import 'header_text.dart';

class LoginContainer extends StatelessWidget {
  final String headerText;
  final String contentTextOne;
  final String contentTextTwo;
  final String hintTextOne;
  final String hintTextTwo;
  final bool isNewAccount;
  final Function onPressed;

  const LoginContainer({
    this.headerText,
    this.contentTextOne,
    this.contentTextTwo,
    this.onPressed,
    this.hintTextOne,
    this.hintTextTwo,
    this.isNewAccount = false,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
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
              text: headerText,
            ),
            Container(height: 64),
            ContentText(text: contentTextOne),
            Container(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: ContentText(text: contentTextTwo),
            ),
            Container(height: 125),
            CustomTextField(hintText: hintTextOne),
            Container(height: 20),
            isNewAccount ? CustomTextField(hintText: hintTextTwo) : Container(),
            isNewAccount ? Container(height: 20) : Container(),
            PrimaryButton(
              buttonText: "Continue",
              onPressed: onPressed,
            ),
            Container(height: 45)
          ],
        ),
      ),
    );
  }
}
