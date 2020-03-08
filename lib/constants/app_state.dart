import 'package:flutter/material.dart';

class AppState with ChangeNotifier {
  bool isRequestRunning = false;
  String jwtToken;

  void setIsRequestRunning(bool newValue) {
    isRequestRunning = newValue;
    notifyListeners();
  }

  void setJwtToken(String token) {
    jwtToken = token;
    notifyListeners();
  }
}
