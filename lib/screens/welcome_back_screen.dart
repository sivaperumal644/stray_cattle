import 'package:camera/camera.dart';
import 'package:citizen_watch/components/login_container.dart';
import 'package:citizen_watch/constants/app_state.dart';
import 'package:citizen_watch/constants/web.dart';
import 'package:citizen_watch/flavor.dart';
import 'package:citizen_watch/screens/home_screen.dart';
import 'package:citizen_watch/screens/report_list_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class WelcomeBackScreen extends StatefulWidget {
  final String phone;
  final CameraDescription camera;

  const WelcomeBackScreen({
    this.phone,
    this.camera,
  });
  @override
  _WelcomeBackScreenState createState() => _WelcomeBackScreenState();
}

class _WelcomeBackScreenState extends State<WelcomeBackScreen> {
  String password = "";
  String jwtToken;
  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<AppState>(context);
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(backgroundColor: Colors.black),
      body: ListView(
        physics: BouncingScrollPhysics(),
        children: <Widget>[
          Container(height: 50),
          LoginContainer(
            headerText: "Welcome Back",
            contentTextOne: "Please enter your password to continue",
            contentTextTwo: "",
            obscureTextOne: true,
            hintTextOne: "Password",
            onChangedOne: (val) {
              password = val;
            },
            onPressed: () async {
              final snackBar = SnackBar(
                content: Text(
                    'Invalid password, Check your password and try again.'),
                backgroundColor: Colors.grey,
              );
              final prefs = await SharedPreferences.getInstance();
              if (env.flavor == BuildFlavor.citizen) {
                appState.setIsRequestRunning(true);
                jwtToken = await runLoginRequest(
                  phone: widget.phone,
                  password: password,
                );
                appState.setIsRequestRunning(false);
                print("inside the welcome screen : " + jwtToken.toString());
                if (jwtToken != "INVALID_PASSWORD") {
                  await prefs.setString('token', jwtToken);
                  appState.setJwtToken(jwtToken);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => HomeScreen(camera: widget.camera),
                    ),
                  );
                } else {
                  Scaffold.of(context).showSnackBar(snackBar);
                }
              } else if (env.flavor == BuildFlavor.staff) {
                if (password == "password") {
                  appState.setIsRequestRunning(true);
                  await prefs.setString('token', "adminJwtToken");
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ReportListScreen(),
                    ),
                  );
                  appState.setIsRequestRunning(false);
                } else {
                  Scaffold.of(context).showSnackBar(snackBar);
                }
              }
            },
          )
        ],
      ),
    );
  }
}
