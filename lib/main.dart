import 'package:citizen_watch/screens/auth_screen.dart';
import 'package:citizen_watch/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'constants/app_state.dart';

main() => runApp(
      ChangeNotifierProvider<AppState>(
        create: (context) => AppState(),
        child: MyApp(),
      ),
    );

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
    return MaterialApp(home: isAuthenticated ? HomeScreen() : AuthScreen());
  }

  getPref() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    setState(() {
      isAuthenticated = token != null;
    });
  }
}
