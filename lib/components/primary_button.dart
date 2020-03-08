import 'package:citizen_watch/constants/colors.dart';
import 'package:flutter/material.dart';

class PrimaryButton extends StatelessWidget {
  final String buttonText;
  final Function onPressed;
  final double width;

  const PrimaryButton({
    this.buttonText,
    this.onPressed, 
    this.width,
    
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: RaisedButton(
        padding: EdgeInsets.only(top: 12, bottom: 12),
        color: BLUEBERRY_COLOR,
        onPressed: onPressed,
        child: Text(
          buttonText,
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
          ),
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }
}
