import 'package:citizen_watch/components/report_button.dart';
import 'package:citizen_watch/components/secondary_button.dart';
import 'package:citizen_watch/screens/about_app_screen.dart';
import 'package:citizen_watch/screens/report_screen.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        body: ListView(
          children: <Widget>[
            Container(
              height: MediaQuery.of(context).size.height / 1.25,
              width: double.infinity,
              margin: EdgeInsets.fromLTRB(16, 110, 16, 10),
              padding: EdgeInsets.symmetric(horizontal: 64),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: Colors.white.withOpacity(0.4),
                ),
              ),
              child: Column(
                children: <Widget>[
                  Container(height: 40),
                  Text(
                    'Stray cows may disrupt traffic, but they also carry disease.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white.withOpacity(0.5),
                    ),
                  ),
                  Container(height: 20),
                  Text(
                    'We want to save stray cows, give them proper shelter',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white.withOpacity(0.5),
                    ),
                  ),
                  Container(height: 60),
                  Text(
                    'If you spot them in your location,',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Container(height: 20),
                  ReportButton(
                    buttonText: "REPORT IT",
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ReportScreen(),
                        ),
                      );
                    },
                  ),
                  Spacer(),
                  SecondaryButton(
                    buttonText: "ABOUT APP",
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => AboutAppScreen(),
                        ),
                      );
                    },
                  ),
                  Container(height: 20)
                ],
              ),
            ),
          ],
        ));
  }
}
