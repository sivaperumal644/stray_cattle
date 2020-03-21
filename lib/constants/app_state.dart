import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppState with ChangeNotifier {
  AppState(){
    getFromMemory();
  }

  bool isRequestRunning = false;
  String jwtToken;

  Future getFromMemory() async{
    final pref = await SharedPreferences.getInstance();
    final token = pref.getString("token") ?? "";
    jwtToken = token;
  }

  void setIsRequestRunning(bool newValue) {
    isRequestRunning = newValue;
    notifyListeners();
  }

  void setJwtToken(String token) {
    jwtToken = token;
    notifyListeners();
  }

  get getJwtToken => jwtToken;
  get getIsRequestRunning => isRequestRunning; 
}
