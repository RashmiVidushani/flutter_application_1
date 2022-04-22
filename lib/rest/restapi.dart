import 'dart:convert';

import 'package:flutter_application_1/utils/utils.dart';
import 'package:http/http.dart' as http;

Future userLogin(String username, String password, String trim) async {
  final response = await http.post(Uri.parse('${Utils.baseUrl}/user/login'),
      headers: {"Accept": "Application/json"},
      body: {'username': username, 'password': password});
  var decodedData = jsonDecode(response.body);
  return decodedData;
}

Future userRegister(
    String username, String password, String phone, String email) async {
  final response = await http.post(Uri.parse('${Utils.baseUrl}/user/register'),
      headers: {
        "Accept": "Application/json"
      },
      body: {
        'username': username,
        'password': password,
        'email': email,
        'phone': phone
      });
  var decodedData = jsonDecode(response.body);
  return decodedData;
}

Future userIDRegister(String username, String uid) async {
  final response = await http.put(Uri.parse('${Utils.baseUrl}/user/reguid'),
      headers: {"Accept": "Application/json"},
      body: {'username': username, 'uid': uid});
  print(username);
  print(uid);
  var decodedData = jsonDecode(response.body);
  return decodedData;
}
//0785083963