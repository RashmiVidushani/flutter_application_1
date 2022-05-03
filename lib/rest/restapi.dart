import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_application_1/utils/utils.dart';
import 'package:http/http.dart' as http;

Future userLogin(String username, String password, String phone) async {
  final response = await http.post(Uri.parse('${Utils.baseUrl}/user/login'),
      headers: {"Accept": "Application/json"},
      body: {'username': username, 'password': password, 'phone': phone});
  print(username);
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
Future contactdata(String name, bool isGroup, String currentMessage,
    String time, Blob icon, String uid) async {
  final response =
      await http.post(Uri.parse('${Utils.baseUrl}/user/contactdata'), headers: {
    "Accept": "Application/json"
  }, body: {
    'name': name,
    'isGroup': isGroup,
    'currentMessage': currentMessage,
    'time': time,
    'icon': icon,
    'uid': uid
  });
  var decodedData = jsonDecode(response.body);
  return decodedData;
} //setcontact data

Future assigncontact(String name, String uid) async {
  final response = await http.post(
      Uri.parse('${Utils.baseUrl}/user/assigncontact'),
      headers: {"Accept": "Application/json"},
      body: {'name': name, 'uid': uid});
  var decodedData = jsonDecode(response.body);
  return decodedData;
}

Future updateuser(String phone, String username, String bio) async {
  final response = await http.put(Uri.parse('${Utils.baseUrl}/user/UpdateUser'),
      headers: {"Accept": "Application/json"},
      body: {'phone': phone, 'username': username, 'bio': bio});
  print(username);
  print(bio);

  var decodedData = jsonDecode(response.body);
  return decodedData;
}
