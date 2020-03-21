import 'package:camera/camera.dart';
import 'package:citizen_watch/components/primary_button.dart';
import 'package:citizen_watch/components/report_button.dart';
import 'package:citizen_watch/components/secondary_button.dart';
import 'package:citizen_watch/screens/about_app_screen.dart';
import 'package:citizen_watch/screens/capture_image_screen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'auth_screen.dart';

class HomeScreen extends StatefulWidget {
  final CameraDescription camera;

  const HomeScreen({this.camera});
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: ListView(
        physics: BouncingScrollPhysics(),
        children: <Widget>[
          Container(
            height: MediaQuery.of(context).size.height / 1.25,
            width: double.infinity,
            margin: EdgeInsets.fromLTRB(16, 110, 16, 10),
            padding: EdgeInsets.symmetric(horizontal: 30),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: Colors.white.withOpacity(0.4),
              ),
            ),
            child: Column(
              children: <Widget>[
                Container(height: 40),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: Text(
                    'Stray cows may disrupt traffic, but they also carry disease.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white.withOpacity(0.5),
                    ),
                  ),
                ),
                Container(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: Text(
                    'We want to save stray cows, give them proper shelter',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white.withOpacity(0.5),
                    ),
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
                    displayAlertDialog(context);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CaptureImageScreen(
                          camera: widget.camera,
                        ),
                      ),
                    );
                  },
                ),
                Spacer(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
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
                    SecondaryButton(
                      buttonText: "  LOG OUT  ",
                      onPressed: () async {
                        final prefs = await SharedPreferences.getInstance();
                        await prefs.clear();
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                AuthScreen(camera: widget.camera),
                          ),
                        );
                      },
                    ),
                  ],
                ),
                Container(height: 30)
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future displayAlertDialog(BuildContext context) {
    return showDialog(
      barrierDismissible: false,
      context: context,
      builder: (_) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        backgroundColor: Colors.white,
        title: Text(
          'Capture in landscape mode',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.orange,
          ),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text(
              'Please capture the image keeping your device in landscape to send a nice image. Image taken by keeping the phone in portrait will not be visible clear and we might not accept the report.',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.black),
            ),
            Container(height: 24),
            PrimaryButton(
              buttonText: 'OK',
              onPressed: () {
                Navigator.of(context, rootNavigator: true).pop('dialog');
              },
            )
          ],
        ),
      ),
    );
  }
}
