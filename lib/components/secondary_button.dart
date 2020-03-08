import 'package:flutter/material.dart';

class SecondaryButton extends StatelessWidget {
  final String buttonText;
  final Function onPressed;
  const SecondaryButton({
    this.buttonText,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return OutlineButton(
      padding: EdgeInsets.symmetric(vertical: 12, horizontal: 20),
      child: Text(
        buttonText,
        style: TextStyle(color: Colors.white, fontSize: 16),
      ),
      borderSide: BorderSide(
        color: Colors.white.withOpacity(0.5),
        width: 1,
      ),
      highlightedBorderColor: Colors.white,
      onPressed: onPressed,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
    );
  }
}
