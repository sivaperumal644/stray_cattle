import 'package:camera/camera.dart';
import 'package:citizen_watch/screens/auth_screen.dart';
import 'package:citizen_watch/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'components/busy_indicator_wrapper.dart';
import 'constants/app_state.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final cameras = await availableCameras();
  final firstCamera = cameras.first;
  runApp(
    ChangeNotifierProvider<AppState>(
      create: (context) => AppState(),
      child: MyApp(
        camera: firstCamera,
      ),
    ),
  );
}

class MyApp extends StatefulWidget {
  final CameraDescription camera;

  const MyApp({this.camera});
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
    return BusyIndicatorWidget(
      child: MaterialApp(
          home: isAuthenticated
              ? HomeScreen(camera: widget.camera)
              : AuthScreen()),
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
