import 'package:citizen_watch/constants/colors.dart';
import 'package:flutter/material.dart';

class ReportButton extends StatelessWidget {
  final String buttonText;
  final Function onPressed;

  const ReportButton({
    this.buttonText,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      color: BLUEBERRY_COLOR,
      child: Text(
        buttonText,
        textAlign: TextAlign.center,
        style: TextStyle(
          color: Colors.white,
          fontSize: 24,
        ),
      ),
      padding: EdgeInsets.symmetric(vertical: 16, horizontal: 62),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(90)),
      onPressed: onPressed,
    );
  }
}
