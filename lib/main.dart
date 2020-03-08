import 'package:citizen_watch/screens/auth_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'components/busy_indicator_wrapper.dart';
import 'constants/app_state.dart';

main() => runApp(ChangeNotifierProvider<AppState>(
    create: (context) => AppState(), child: MyApp()));

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BusyIndicatorWidget(child: MaterialApp(home: AuthScreen()));
  }
}
