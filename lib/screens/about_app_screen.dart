import 'package:citizen_watch/components/about_app_container.dart';
import 'package:flutter/material.dart';

class AboutAppScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.black),
      backgroundColor: Colors.black,
      body: ListView(
        physics: BouncingScrollPhysics(),
        children: <Widget>[
          Container(height: 36),
          AboutAppContainer(),
        ],
      ),
    );
  }
}
