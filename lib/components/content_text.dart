import 'package:flutter/material.dart';

class ContentText extends StatelessWidget {
  final String text;
  const ContentText({
    this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: TextAlign.center,
      style: TextStyle(
        color: Colors.white,
        fontSize: 16,
      ),
    );
  }
}
