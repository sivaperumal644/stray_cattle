import 'package:flutter/material.dart';

class TertiaryButton extends StatelessWidget {
  final String buttonText;
  final Function onPressed;

  const TertiaryButton({
    this.buttonText,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      padding: EdgeInsets.symmetric(vertical: 16, horizontal: 24),
      highlightColor: Colors.white.withOpacity(0.3),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      onPressed: onPressed,
      child: Text(
        buttonText,
        style: TextStyle(
          color: Colors.white,
        ),
      ),
    );
  }
}