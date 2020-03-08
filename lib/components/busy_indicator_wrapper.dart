import 'dart:ui';

import 'package:citizen_watch/constants/app_state.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BusyIndicatorWidget extends StatelessWidget {
  final Widget child;

  BusyIndicatorWidget({Key key, this.child}) : super(key: key);
  final noPadding = EdgeInsets.all(0);
  final somePadding = EdgeInsets.all(16);
  final Duration animationDuration = Duration(milliseconds: 100);
  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<AppState>(context);
    return MaterialApp(
      theme: ThemeData.dark(),
      home: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.black,
        body: Stack(alignment: Alignment.center, children: [
          AnimatedContainer(
              padding: appState.isRequestRunning ? somePadding : noPadding,
              duration: Duration(seconds: 1),
              child: child),
          IgnorePointer(
            ignoring: !appState.isRequestRunning,
            child: Container(
              color: appState.isRequestRunning
                  ? Colors.black.withOpacity(0.7)
                  : Colors.transparent,
            ),
          ),
          AnimatedContainer(
            curve: Curves.easeInOut,
            duration: animationDuration,
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                AnimatedContainer(
                  curve: Curves.easeInOut,
                  duration: animationDuration,
                  height: appState.isRequestRunning ? 0 : 850,
                ),
                Container(
                  margin: EdgeInsets.only(bottom: 36, left: 16, right: 16),
                  decoration: BoxDecoration(
                      color: Colors.grey.shade900,
                      borderRadius: BorderRadius.circular(16)),
                  padding:
                      EdgeInsets.only(left: 24, right: 24, top: 36, bottom: 36),
                  child: Row(
                    children: <Widget>[
                      Container(
                        height: 24,
                        width: 24,
                        margin: EdgeInsets.only(left: 16, right: 24),
                        child: CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation(Colors.white)),
                      ),
                      Text(
                        'Please wait...',
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                    ],
                  ),
                )
              ],
            ),
          )
        ]),
      ),
    );
  }
}
