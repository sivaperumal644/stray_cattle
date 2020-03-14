import 'dart:io';

import 'package:citizen_watch/components/primary_button.dart';
import 'package:citizen_watch/components/tertiary_button.dart';
import 'package:citizen_watch/screens/report_sending_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ReportScreen extends StatefulWidget {
  final String imagePath;

  const ReportScreen({this.imagePath});
  @override
  _ReportScreenState createState() => _ReportScreenState();
}

class _ReportScreenState extends State<ReportScreen> {
  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
    ]);
  }

  @override
  void dispose() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
      DeviceOrientation.portraitDown,
      DeviceOrientation.portraitUp
    ]);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Scaffold(
        body: Stack(
          children: <Widget>[
            Image.network(
              widget.imagePath,
              width: double.infinity,
              height: double.infinity,
              fit: BoxFit.fill,
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 32.0),
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.7),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      TertiaryButton(
                        buttonText: "DISCARD",
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                      Container(width: 30, height: 0),
                      PrimaryButton(
                        buttonText: "Continue",
                        onPressed: () {
                          SystemChrome.setPreferredOrientations([
                            DeviceOrientation.landscapeLeft,
                            DeviceOrientation.landscapeRight,
                            DeviceOrientation.portraitDown,
                            DeviceOrientation.portraitUp
                          ]);
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ReportSendingScreen(),
                            ),
                          );
                        },
                        width: 120,
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
