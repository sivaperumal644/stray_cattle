import 'dart:io';

import 'package:citizen_watch/components/primary_button.dart';
import 'package:citizen_watch/components/tertiary_button.dart';
import 'package:citizen_watch/models/report.dart';
import 'package:citizen_watch/screens/report_sending_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';

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
    ReportObject report;
    List<String> images = new List<String>();
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
                        onPressed: () async {
                          print("clicked");
                          print(widget.imagePath);
                          Position position =
                              await Geolocator().getCurrentPosition(
                            desiredAccuracy: LocationAccuracy.high,
                          );
                          print("latitude-" +
                              position.latitude.toString() +
                              " / longitude-" +
                              position.longitude.toString());
                          SystemChrome.setPreferredOrientations([
                            DeviceOrientation.landscapeLeft,
                            DeviceOrientation.landscapeRight,
                            DeviceOrientation.portraitDown,
                            DeviceOrientation.portraitUp
                          ]);
                          images.add(widget.imagePath);
                          report = new ReportObject(
                            images: images,
                            latitude: position.latitude,
                            longitude: position.longitude,
                          );
                          print(report.longitude);
                          print(report.latitude);
                          print(report.images);
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  ReportSendingScreen(report: report),
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
