import 'dart:convert';

import 'package:citizen_watch/models/address.dart';
import 'package:citizen_watch/models/report.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

import 'app_state.dart';

const BASE_URL = 'https://stray-cattle-sp.herokuapp.com';

Future<bool> runAddReportRequest(
    {ReportObject report, BuildContext context}) async {
  final appState = Provider.of<AppState>(context);
  final jwtToken = appState.getJwtToken;
  print(report.longitude.toString());
  print(report.latitude.toString());
  print(jsonEncode(report.images));
  print(jwtToken);
  print('=== Sending ADD REPORT REQUEST ===');
  http.Response response = await http.post('$BASE_URL/reports/add', body: {
    'longitude': report.longitude.toString(),
    'latitude': report.latitude.toString(),
    'images': jsonEncode(report.images)
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

Future<List<ReportObject>> runGetReportList() async {
  http.Response response = await http.get('$BASE_URL/reports/list');
  var responseData = jsonDecode(response.body);
  List<ReportObject> reportsList = [];
  if (responseData['error'] == null && responseData['data']['count'] != 0) {
    var count = responseData['data']['count'];
    var reports = responseData['data']['values'];
    for (int i = 0; i < count; i++) {
      List<String> images = List<String>.from(jsonDecode(reports[i]['images']));
      reportsList.add(ReportObject(
        citizenId: reports[i]['citizen_id'],
        images: images,
        latitude: double.parse(reports[i]['latitude']),
        longitude: double.parse(reports[i]['longitude']),
        status: reports[i]['status'],
      ));
    }
  }
  return reportsList;
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
  return responseData['error']['code'];
}

Future<String> runRegisterRequest({String phone, String password}) async {
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

Future<AddressObject> getAddress(double longitude, double latitude) async {
  var params = {
    'key': '3039b1865ac919',
    'lat': latitude,
    'lon': longitude,
    'format': 'json',
  };
  var query = params.entries.map((p) => '${p.key}=${p.value}').join('&');

  var res = await http.get('https://us1.locationiq.com/v1/reverse.php?$query');
  if (res.statusCode != 200)
    throw Exception('http.get error: statusCode= ${res.statusCode}');
  var response = jsonDecode(res.body);
  return AddressObject(
    placeId: response['place_id'],
    address: response['display_name'],
    countryCode: response['address']['country_code'],
  );
}
