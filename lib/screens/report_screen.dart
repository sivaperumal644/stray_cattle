import 'package:android_intent/android_intent.dart';
import 'package:camera/camera.dart';
import 'package:citizen_watch/components/primary_button.dart';
import 'package:citizen_watch/components/tertiary_button.dart';
import 'package:citizen_watch/constants/app_state.dart';
import 'package:citizen_watch/models/report.dart';
import 'package:citizen_watch/screens/capture_image_screen.dart';
import 'package:citizen_watch/screens/report_sending_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';

class ReportScreen extends StatefulWidget {
  final String imagePath;
  final CameraDescription camera;

  const ReportScreen({
    this.imagePath,
    this.camera,
  });
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
    final appState = Provider.of<AppState>(context);
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
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  CaptureImageScreen(camera: widget.camera),
                            ),
                          );
                        },
                      ),
                      Container(width: 30, height: 0),
                      PrimaryButton(
                        buttonText: "Continue",
                        onPressed: () async {
                          appState.setIsRequestRunning(true);
                          ServiceStatus serviceStatus =
                              await PermissionHandler()
                                  .checkServiceStatus(PermissionGroup.location);
                          bool enabled =
                              (serviceStatus == ServiceStatus.enabled);
                          if (!enabled) openLocationSetting();

                          Position position =
                              await Geolocator().getCurrentPosition(
                            desiredAccuracy: LocationAccuracy.high,
                          );

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
                          appState.setIsRequestRunning(false);
                          Navigator.pushReplacement(
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

  void openLocationSetting() async {
    final AndroidIntent intent = new AndroidIntent(
      action: 'android.settings.LOCATION_SOURCE_SETTINGS',
    );
    await intent.launch();
  }
}
