import 'dart:convert';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/Model/usermodel.dart';
import 'package:flutter_application_1/Screens/editprofile.dart';
import 'package:flutter_application_1/rest/restapi.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class Profile extends StatefulWidget {
  Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  late final bool isEdit = false;

  User? user = FirebaseAuth.instance.currentUser;
  late SharedPreferences _sharedPreferences;

  late String username;
  late String email;
  getUser() {
    User? user = FirebaseAuth.instance.currentUser;
    FirebaseFirestore.instance
        .collection('users')
        .doc(user!.uid)
        .get()
        .then((value) {
      setState(() {
        username = value.data()!['username'];
        email = value.data()!['email'];
      });
    });
  }

  @override
  void initState() {
    super.initState();
    getUser();
  }

  @override
  Widget build(BuildContext context) {
    final color = Colors.teal;
    return Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
            child: Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.symmetric(horizontal: 35),
                child: Column(children: [
                  SizedBox(
                    height: 20,
                  ),
                  Stack(
                    children: [
                      CircleAvatar(
                        child: SvgPicture.asset(
                          "assets/person_black_24dp.svg",
                          color: Colors.white,
                          height: 55,
                          width: 55,
                        ),
                        radius: 110,
                        backgroundColor: Colors.blueGrey,
                      ),
                      Positioned(
                          bottom: 0,
                          right: 4,
                          child: Ink(
                              decoration: ShapeDecoration(
                                  color: Colors.blue, shape: CircleBorder()),
                              child: IconButton(
                                onPressed: () {
                                  Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => EditProfile()));
                                },
                                icon: Icon(Icons.edit),
                                color: Colors.black,
                                highlightColor: Colors.red,
                                splashColor: Colors.teal,
                              ))),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text("User ID:" + user!.uid,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                          color: Colors.grey)),
                  SizedBox(
                    height: 20,
                  ),
                  Text("Username:" + username,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                          color: Colors.black)),
                  SizedBox(
                    height: 20,
                  ),
                  Text("E-mail Address: " + email,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                          color: Colors.black))
                ]))));
  }

/*
  _savedData() async {
    _sharedPreferences = await SharedPreferences.getInstance();
    setState(() {
      tempName = _sharedPreferences.getString("usersusername").toString();
      tempPhone = _sharedPreferences.getString("usersphone").toString();
    });
  }


   IconButton(onPressed: {

                  }, icon: Icon(Icons.abc)),


*/ /*
  Widget buildEditIcon(Color color) => buildCircle(
        color: Colors.white,
        all: 3,
        child: buildCircle(
          color: color,
          all: 8,
          child: Icon(
            isEdit ? Icons.add_a_photo : Icons.edit,
            color: Colors.white,
            size: 30,
          ),
        ),
      );*/
  Widget buildCircle({
    required Widget child,
    required double all,
    required Color color,
  }) =>
      ClipOval(
        child: Container(
          padding: EdgeInsets.all(all),
          color: color,
          child: child,
        ),
      );
}
