import 'package:citizen_watch/constants/web.dart';
import 'package:citizen_watch/models/report.dart';
import 'package:flutter/material.dart';

class LocationScreen extends StatefulWidget {
  final ReportObject report;

  LocationScreen({this.report});

  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  String image;

  @override
  Widget build(BuildContext context) {
    var params = {
      'key': '3039b1865ac919',
      'center': '${widget.report.latitude},${widget.report.longitude}',
      'zoom': '11',
      'size': '300x300',
      'format': 'png',
      'maptype': 'roadmap',
      'markers': [
        'icon:small-red-cutout|${widget.report.latitude},${widget.report.longitude}',
        'icon:small-blue-cutout|${widget.report.latitude},${widget.report.longitude}',
      ],
    };
    var query = params.entries.map((p) => '${p.key}=${p.value}').join('&');
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(backgroundColor: Colors.black),
      body: Center(
        child: Image.network(
          'https://maps.locationiq.com/v2/staticmap?$query',
          width: MediaQuery.of(context).size.width - 60,
          height: MediaQuery.of(context).size.height - 60,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
