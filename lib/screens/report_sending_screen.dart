import 'package:camera/camera.dart';
import 'package:citizen_watch/components/report_sending_container.dart';
import 'package:citizen_watch/constants/web.dart';
import 'package:citizen_watch/models/report.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ReportSendingScreen extends StatefulWidget {
  final ReportObject report;
  final CameraDescription camera;

  const ReportSendingScreen({
    this.report,
    this.camera,
  });
  @override
  _ReportSendingScreenState createState() => _ReportSendingScreenState();
}

class _ReportSendingScreenState extends State<ReportSendingScreen> {
  bool isReported = false;
  String headerText = "We’re sending your report, please wait...";
  String contentText = "This may take a moment";

  @override
  void dispose() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      child: Scaffold(
        backgroundColor: Colors.black,
        body: FutureBuilder<bool>(
          future: runAddReportRequest(report: widget.report, context: context),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              if (snapshot.data) {
                return ReportSendingContainer(
                  camera: widget.camera,
                  headerText: "Your report has been submitted.",
                  contextText: "We are working on it. Thank you for helping!",
                  isReported: true,
                );
              } else {
                return ReportSendingContainer(
                  camera: widget.camera,
                  headerText: "Could not send report",
                  contextText:
                      "We could not receive your report due to some error. Try sending it again.",
                  isReported: false,
                );
              }
            } else {
              return ReportSendingContainer(
                camera: widget.camera,
                headerText: "We’re sending your report, please wait...",
                contextText: "This may take a moment",
                isReported: false,
                onComplete: false,
              );
            }
          },
        ),
      ),
      onWillPop: () {
        final snackBar = SnackBar(
          content: Text('Cannot go back right now.'),
          backgroundColor: Colors.grey,
        );
        Scaffold.of(context).showSnackBar(snackBar);
        return new Future(() => false);
      },
    );
  }
}
