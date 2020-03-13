import 'package:citizen_watch/components/login_container.dart';
import 'package:citizen_watch/constants/app_state.dart';
import 'package:citizen_watch/constants/web.dart';
import 'package:citizen_watch/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class WelcomeBackScreen extends StatefulWidget {
  final String phone;

  const WelcomeBackScreen({this.phone});
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
        children: <Widget>[
          Container(height: 50),
          LoginContainer(
            headerText: "Welcome Back",
            contentTextOne: "Please enter your password to continue",
            contentTextTwo: "",
            hintTextOne: "Password",
            onChangedOne: (val) {
              password = val;
            },
            onPressed: () async {
              jwtToken = await runLoginRequest(
                phone: widget.phone,
                password: password,
              );
              print(jwtToken);
              if (jwtToken != null) {
                appState.setJwtToken(jwtToken);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => HomeScreen(),
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
