import 'package:camera/camera.dart';
import 'package:citizen_watch/components/login_container.dart';
import 'package:citizen_watch/constants/app_state.dart';
import 'package:citizen_watch/constants/web.dart';
import 'package:citizen_watch/flavor.dart';
import 'package:citizen_watch/screens/new_account_screen.dart';
import 'package:citizen_watch/screens/welcome_back_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

class AuthScreen extends StatefulWidget {
  final CameraDescription camera;

  const AuthScreen({this.camera});

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
            keyboardTypeOne: TextInputType.phone,
            onChangedOne: (val) {
              setState(() {
                phoneNumber = val;
              });
            },
            onPressed: () async {
              if (phoneNumber.length != 10) {
                final snackBar = SnackBar(
                  content: Text('Enter a valid 10 digit mobile number'),
                  backgroundColor: Colors.grey,
                );
                Scaffold.of(context).showSnackBar(snackBar);
              } else {
                if (env.flavor == BuildFlavor.citizen) {
                  appState.setIsRequestRunning(true);
                  jwt = await runLoginRequest(
                    phone: phoneNumber,
                    password: " ",
                    onUserNotExist: () {
                      appState.setIsRequestRunning(false);

                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => NewAccountScreen(
                            phone: phoneNumber,
                            camera: widget.camera,
                          ),
                        ),
                      );
                    },
                  );
                  appState.setIsRequestRunning(false);

                  if (jwt == "INVALID_PASSWORD") {
                    appState.setIsRequestRunning(false);

                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => WelcomeBackScreen(
                          phone: phoneNumber,
                          camera: widget.camera,
                        ),
                      ),
                    );
                  }
                }

                if (env.flavor == BuildFlavor.staff) {
                  if (phoneNumber == "1234567890") {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => WelcomeBackScreen(
                          phone: phoneNumber,
                        ),
                      ),
                    );
                  } else {
                    final snackBar = SnackBar(
                      content: Text('Enter a valid admin phone number'),
                      backgroundColor: Colors.grey,
                    );
                    Scaffold.of(context).showSnackBar(snackBar);
                  }
                }
              }
            },
          )
        ],
      ),
    );
  }
}
