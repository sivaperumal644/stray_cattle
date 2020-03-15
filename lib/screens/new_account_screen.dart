import 'package:camera/camera.dart';
import 'package:citizen_watch/components/login_container.dart';
import 'package:citizen_watch/constants/app_state.dart';
import 'package:citizen_watch/constants/web.dart';
import 'package:citizen_watch/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NewAccountScreen extends StatefulWidget {
  final String phone;
  final CameraDescription camera;

  const NewAccountScreen({
    this.phone,
    this.camera,
  });

  @override
  _NewAccountScreenState createState() => _NewAccountScreenState();
}

class _NewAccountScreenState extends State<NewAccountScreen> {
  String password;
  String confirmPassword;
  String jwtToken;

  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<AppState>(context);
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(backgroundColor: Colors.black),
      body: ListView(
        children: <Widget>[
          Container(height: 50),
          LoginContainer(
            headerText: "New Account",
            contentTextOne: "It looks like you are a new user. ",
            contentTextTwo:
                "Set a password for your account, and you’re good to go!",
            isNewAccount: true,
            hintTextOne: "Password",
            hintTextTwo: "Confirm Password",
            onChangedOne: (val) {
              password = val;
            },
            onChangedTwo: (val) {
              confirmPassword = val;
            },
            onPressed: () async {
              final prefs = await SharedPreferences.getInstance();
              if (password == confirmPassword) {
                appState.setIsRequestRunning(true);
                jwtToken = await runRegisterRequest(
                  phone: widget.phone,
                  password: password,
                );
                appState.setIsRequestRunning(false);
              }
              if (jwtToken != null) {
                await prefs.setString('token', jwtToken);
                appState.setJwtToken(jwtToken);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => HomeScreen(camera: widget.camera),
                  ),
                );
              }
            },
          )
        ],
      ),
    );
  }
}
