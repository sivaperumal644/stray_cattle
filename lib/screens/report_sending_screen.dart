import 'package:citizen_watch/components/report_sending_container.dart';
import 'package:flutter/material.dart';

class ReportSendingScreen extends StatefulWidget {
  @override
  _ReportSendingScreenState createState() => _ReportSendingScreenState();
}

class _ReportSendingScreenState extends State<ReportSendingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: ReportSendingContainer(
        headerText: "We’re sending your report, please wait...",
        contextText: "This may take a moment",
        isReported: true,
      ),
    );
  }
}
