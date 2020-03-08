import 'package:flutter/material.dart';

class ReportSendingContainer extends StatelessWidget {
  final bool isReported;
  final String headerText;
  final String contextText;

  const ReportSendingContainer({
    this.isReported = false,
    this.headerText,
    this.contextText,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(24, 80, 24, 16),
      padding: EdgeInsets.symmetric(horizontal: 48),
      width: double.infinity,
      height: MediaQuery.of(context).size.height / 1.2,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          width: 2,
          color: Colors.white.withOpacity(0.5),
        ),
      ),
      child: Column(
        children: <Widget>[
          Container(height: 72),
          isReported
              ? Icon(
                  Icons.check,
                  color: Colors.white,
                  size: 100,
                )
              : Container(height: 100),
          Container(height: 64),
          Text(
            headerText,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          Container(height: 16),
          Text(
            contextText,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white.withOpacity(0.5),
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }
}
