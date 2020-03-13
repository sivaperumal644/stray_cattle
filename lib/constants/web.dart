import 'dart:convert';

import 'package:citizen_watch/models/report.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

import 'app_state.dart';

const BASE_URL = 'http://djangoproject-straycattle.herokuapp.com';

Future<bool> runAddReportRequest(
    {ReportObject report, BuildContext context}) async {
  final appState = Provider.of<AppState>(context);
  final jwtToken = appState.jwtToken;
  print('=== Sending ADD REPORT REQUEST ===');
  http.Response response = await http.post('$BASE_URL/reports/add', body: {
    'longitude': report.longitude,
    'latitude': report.latitude,
    'images': report.images
  }, headers: {
    'authorization': 'Bearer $jwtToken'
  });
  print('Response status: ${response.statusCode}');
  print('Response body: ${response.body}');
  var responseData = jsonDecode(response.body);
  if (responseData['error'] == null &&
      responseData['data']['success'] == true) {
    return true;
  }
  return false;
}

Future<String> runLoginRequest(
    {String phone, String password, Function onUserNotExist}) async {
  print('=== Sending LOGIN REQUEST ===');
  http.Response response = await http.post('$BASE_URL/auth/login',
      body: {'phone': phone, 'password': password});
  print('Response status: ${response.statusCode}');
  print('Response body: ${response.body}');
  var responseData = jsonDecode(response.body);
  if (responseData['error'] == null) {
    return responseData['data']['jwt'];
  } else {
    if (responseData['error']['code'] == 'USER_DOES_NOT_EXIST') {
      onUserNotExist();
      return responseData['error']['code'];
    }
  }
  return null;
}

Future<String> runRegisterRequest(
    {String phone, String password}) async {
  print('=== Sending REGISTER REQUEST ===');
  http.Response response = await http.post('$BASE_URL/auth/register',
      body: {'phone': phone, 'password': password});
  print('Response status: ${response.statusCode}');
  print('Response body: ${response.body}');
  var responseData = jsonDecode(response.body);
  if (responseData['error'] == null) {
    return responseData['data']['jwt'];
  }
  return null;
}
