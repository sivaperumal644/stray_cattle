import 'package:citizen_watch/constants/web.dart';
import 'package:citizen_watch/models/address.dart';
import 'package:citizen_watch/models/report.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ReportListDetailsScreen extends StatefulWidget {
  final ReportObject report;
  final int index;

  const ReportListDetailsScreen({this.report, this.index});

  @override
  _ReportListDetailsScreenState createState() =>
      _ReportListDetailsScreenState();
}

class _ReportListDetailsScreenState extends State<ReportListDetailsScreen> {
  AddressObject address;
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
    getAddressInfo();
    return Scaffold(
      backgroundColor: Colors.black,
      floatingActionButton: FloatingActionButton.extended(
        label: Text(
          'Open Map',
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        onPressed: openMap,
        backgroundColor: Colors.white,
        icon: Icon(
          Icons.location_on,
          size: 24,
          color: Colors.black,
        ),
      ),
      body: Stack(
        children: <Widget>[
          address == null
              ? Center(child: CircularProgressIndicator())
              : ListView(
                  children: <Widget>[
                    ClipRRect(
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(20),
                        bottomRight: Radius.circular(20),
                      ),
                      child: Image.network(
                        widget.report.images[0],
                        height: 300,
                        fit: BoxFit.cover,
                      ),
                    ),
                    SizedBox(height: 24),
                    Text(
                      'Report ' + (widget.index + 1).toString(),
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 30),
                    buildInfoItem('Place id : ', address.placeId),
                    SizedBox(height: 16),
                    Container(
                      padding: EdgeInsets.only(left: 24),
                      child: Text(
                        'Address : ',
                        style: TextStyle(
                          color: Colors.white.withOpacity(0.5),
                          fontSize: 16,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                    ),
                    SizedBox(height: 8),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 24),
                      child: Text(
                        address.address,
                        style: TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                            fontWeight: FontWeight.w300),
                      ),
                    ),
                    SizedBox(height: 16),
                    buildInfoItem(
                        'Longitude : ', widget.report.longitude.toString()),
                    SizedBox(height: 16),
                    buildInfoItem(
                        'Latitude : ', widget.report.latitude.toString()),
                    SizedBox(height: 16),
                    buildInfoItem('Status : ', widget.report.status),
                    SizedBox(height: 16),
                    Container(
                      padding: EdgeInsets.only(left: 24),
                      child: Text(
                        'Geo Location : ',
                        style: TextStyle(
                          color: Colors.white.withOpacity(0.5),
                          fontSize: 16,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                    ),
                    SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Image.network(
                          'https://maps.locationiq.com/v2/staticmap?$query',
                          width: 300,
                          height: 300,
                          fit: BoxFit.cover,
                        ),
                      ],
                    ),
                    SizedBox(height: 80),
                  ],
                ),
          InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 16),
              margin: EdgeInsets.symmetric(vertical: 16, horizontal: 24),
              child: Icon(
                Icons.arrow_back,
                size: 24,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildInfoItem(String titleHeader, String value) {
    return Row(
      children: <Widget>[
        Container(
          padding: EdgeInsets.only(left: 24),
          child: Text(
            titleHeader,
            style: TextStyle(
              color: Colors.white.withOpacity(0.5),
              fontSize: 16,
              fontStyle: FontStyle.italic,
            ),
          ),
        ),
        Text(
          value,
          style: TextStyle(
              fontSize: 20, color: Colors.white, fontWeight: FontWeight.w300),
        ),
      ],
    );
  }

  Future<void> getAddressInfo() async {
    address = await getAddress(widget.report.longitude, widget.report.latitude);
    setState(() {});
  }

  Future<void> openMap() async {
    String googleUrl =
        'https://www.google.com/maps/search/?api=1&query=${widget.report.latitude},${widget.report.longitude}';
    if (await canLaunch(googleUrl)) {
      await launch(googleUrl);
    } else {
      throw 'Could not open the map.';
    }
  }
}
