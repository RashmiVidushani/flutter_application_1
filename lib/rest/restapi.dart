import 'dart:convert';

import 'package:flutter_application_1/utils/utils.dart';
import 'package:http/http.dart' as http;

Future userLogin(String username, String password) async {
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
