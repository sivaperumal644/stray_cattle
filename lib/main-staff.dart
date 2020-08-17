import 'package:citizen_watch/components/display_connection_status_widget.dart';
import 'package:citizen_watch/flavor.dart';
import 'package:citizen_watch/screens/auth_screen.dart';
import 'package:citizen_watch/screens/report_list_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'components/busy_indicator_wrapper.dart';
import 'constants/app_state.dart';

Future<void> main() async {
  BuildEnvironment.init(flavor: BuildFlavor.staff);

  runApp(
    ChangeNotifierProvider<AppState>(
      create: (context) => AppState(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool isAuthenticated = false;

  @override
  void initState() {
    getPref();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialDisplayConnectionStatusOverlayWidget(
      child: BusyIndicatorWidget(
        child: MaterialApp(
          home: isAuthenticated ? ReportListScreen() : AuthScreen(),
        ),
      ),
    );
  }

  getPref() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    setState(() {
      isAuthenticated = token != null;
    });
  }
}
