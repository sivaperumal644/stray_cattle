import 'package:citizen_watch/components/report_sending_container.dart';
import 'package:flutter/material.dart';

class ReportSendingScreen extends StatefulWidget {
  @override
  _ReportSendingScreenState createState() => _ReportSendingScreenState();
}

class _ReportSendingScreenState extends State<ReportSendingScreen> {
  bool isReported = false;
  String headerText = "We’re sending your report, please wait...";
  String contentText = "This may take a moment";

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 5), () {
      setState(() {
        isReported = true;
        headerText = "Your report has been submitted.";
        contentText = "We are working on it. Thank you for helping!";
      });
    });
  }

  @override
  Widget build(BuildContext context) {
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
