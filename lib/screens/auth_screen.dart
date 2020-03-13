import 'package:citizen_watch/components/login_container.dart';
import 'package:citizen_watch/constants/app_state.dart';
import 'package:citizen_watch/constants/web.dart';
import 'package:citizen_watch/screens/new_account_screen.dart';
import 'package:citizen_watch/screens/welcome_back_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

class AuthScreen extends StatefulWidget {
  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  String phoneNumber = "";
  String jwt;

  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<AppState>(context);

    return Scaffold(
      backgroundColor: Colors.black,
      body: ListView(
        physics: BouncingScrollPhysics(),
        shrinkWrap: true,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(top: 36.0),
            child: SvgPicture.asset('assets/images/app_name.svg'),
          ),
          Container(height: 50),
          Center(
            child: Text(
              'An initiative to save stray cows',
              style:
                  TextStyle(color: Colors.white.withOpacity(0.5), fontSize: 14),
            ),
          ),
          Container(height: 24),
          LoginContainer(
            headerText: "Let’s get started",
            contentTextOne: "Please enter your phone number to login. ",
            contentTextTwo:
                "If you don’t have an account, it will be created for you.",
            hintTextOne: "Phone Number",
            onChangedOne: (val) {
              setState(() {
                phoneNumber = val;
              });
            },
            onPressed: () async {
              jwt = await runLoginRequest(
                phone: phoneNumber,
                password: " ",
                onUserNotExist: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          NewAccountScreen(phone: phoneNumber),
                    ),
                  );
                },
              );
              print(jwt);
              if (jwt == null) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => WelcomeBackScreen(phone: phoneNumber),
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
