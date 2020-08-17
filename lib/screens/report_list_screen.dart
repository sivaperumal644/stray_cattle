import 'package:citizen_watch/constants/web.dart';
import 'package:citizen_watch/models/report.dart';
import 'package:citizen_watch/screens/auth_screen.dart';
import 'package:citizen_watch/screens/report_list_detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ReportListScreen extends StatefulWidget {
  @override
  _ReportListScreenState createState() => _ReportListScreenState();
}

class _ReportListScreenState extends State<ReportListScreen> {
  List<ReportObject> reports;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<String> choices = ['Log Out'];

    getReportList();

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: Text('Stray Cattle Reports'),
        actions: <Widget>[
          PopupMenuButton<String>(
            onSelected: onLogOutPressed,
            itemBuilder: (BuildContext context) {
              return choices.map((String e) {
                return PopupMenuItem<String>(
                  child: Text(e),
                  value: e,
                );
              }).toList();
            },
          ),
        ],
      ),
      body: Stack(
        children: <Widget>[
          reports == null
              ? Center(
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                  ),
                )
              : reports.length > 0
                  ? ListView.builder(
                      reverse: true,
                      itemCount: reports.length,
                      padding: EdgeInsets.symmetric(vertical: 16),
                      itemBuilder: (BuildContext context, int index) {
                        return reportListItem(reports[index], index);
                      })
                  : Center(
                      child: Text(
                        'No reports found',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    )
        ],
      ),
    );
  }

  Widget reportListItem(ReportObject report, int index) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 24),
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ReportListDetailsScreen(
                report: report,
                index: index,
              ),
            ),
          );
        },
        borderRadius: BorderRadius.circular(12),
        child: Container(
          padding: EdgeInsets.all(8),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: Colors.white.withOpacity(0.3),
              width: 1,
            ),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.network(
                  report.images[0],
                  height: 140,
                  width: 140,
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(width: 16),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  reportItem(
                      'Report     : ', 'Report ' + (index + 1).toString()),
                  reportItem('Citizen id : ', report.citizenId.toString()),
                  reportItem('latitude   : ', report.latitude.toString()),
                  reportItem('longitude  : ', report.longitude.toString()),
                  reportItem('status     : ', report.status),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget reportItem(String title, String value) {
    return Row(
      children: <Widget>[
        Text(
          title,
          style: TextStyle(
            fontSize: 16,
            fontStyle: FontStyle.italic,
            color: Colors.white.withOpacity(0.5),
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: 16,
            color: Colors.white,
          ),
        )
      ],
    );
  }

  Future<void> getReportList() async {
    reports = await runGetReportList();
    setState(() {});
  }

  onLogOutPressed(String e) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.clear();
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => AuthScreen(),
      ),
    );
  }
}
