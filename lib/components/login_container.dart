import 'package:citizen_watch/components/primary_button.dart';
import 'package:flutter/material.dart';
import 'content_text.dart';
import 'custom_text_field.dart';
import 'header_text.dart';

class LoginContainer extends StatefulWidget {
  final String headerText;
  final String contentTextOne;
  final String contentTextTwo;
  final String hintTextOne;
  final String hintTextTwo;
  final TextInputType keyboardTypeOne;
  final TextInputType keyboardTypeTwo;
  final bool isNewAccount;
  final Function onPressed;
  final ValueChanged<String> onChangedOne;
  final ValueChanged<String> onChangedTwo;
  final bool obscureTextOne;
  final bool obscureTextTwo;

  const LoginContainer({
    this.headerText,
    this.contentTextOne,
    this.contentTextTwo,
    this.onPressed,
    this.hintTextOne,
    this.hintTextTwo,
    this.isNewAccount = false,
    this.onChangedOne,
    this.onChangedTwo,
    this.keyboardTypeOne,
    this.keyboardTypeTwo,
    this.obscureTextOne = false,
    this.obscureTextTwo = false,
  });

  @override
  _LoginContainerState createState() => _LoginContainerState();
}

class _LoginContainerState extends State<LoginContainer> {
  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    super.dispose();
  }

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
              text: widget.headerText,
            ),
            Container(height: 64),
            ContentText(text: widget.contentTextOne),
            Container(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: ContentText(text: widget.contentTextTwo),
            ),
            Container(height: 125),
            CustomTextField(
              hintText: widget.hintTextOne,
              onChanged: widget.onChangedOne,
              keyboardType: widget.keyboardTypeOne,
              obscureText: widget.obscureTextOne,
            ),
            Container(height: 20),
            widget.isNewAccount
                ? CustomTextField(
                    hintText: widget.hintTextTwo,
                    onChanged: widget.onChangedTwo,
                    keyboardType: widget.keyboardTypeTwo,
                    obscureText: widget.obscureTextTwo,
                  )
                : Container(),
            widget.isNewAccount ? Container(height: 20) : Container(),
            PrimaryButton(
              buttonText: "Continue",
              onPressed: widget.onPressed,
              width: MediaQuery.of(context).size.width,
            ),
            Container(height: 45)
          ],
        ),
      ),
    );
  }
}
