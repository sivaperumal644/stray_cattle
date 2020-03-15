import 'package:citizen_watch/components/report_sending_container.dart';
import 'package:citizen_watch/constants/web.dart';
import 'package:citizen_watch/models/report.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ReportSendingScreen extends StatefulWidget {
  final ReportObject report;

  const ReportSendingScreen({this.report});
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
    ]);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    bool isAddReportSuccess = false;
    print(widget.report.longitude);
    runAddReportRequest(report: widget.report, context: context)
        .then((isSuccess) {
      isAddReportSuccess = isSuccess;
    });
    if (isAddReportSuccess) {
      setState(() {
        isReported = true;
        headerText = "Your report has been submitted.";
        contentText = "We are working on it. Thank you for helping!";
      });
    }
    return Scaffold(
      backgroundColor: Colors.black,
      body: ReportSendingContainer(
        headerText: headerText,
        contextText: contentText,
        isReported: isReported,
      ),
    );
  }
}
