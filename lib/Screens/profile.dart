import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/Model/chatmodel.dart';
import 'package:flutter_application_1/Screens/homescreen.dart';
import 'package:flutter_application_1/rest/restapi.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;

class Profile extends StatefulWidget {
  const Profile({
    Key? key,
    this.sourceChat,
  }) : super(key: key);
  final ChatModel? sourceChat;

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final CollectionReference _users =
      FirebaseFirestore.instance.collection('users');

  User? user = FirebaseAuth.instance.currentUser;
  TextEditingController _username = TextEditingController();
  TextEditingController _bio = TextEditingController();
  TextEditingController _phone = TextEditingController();
  int popTime = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.white,
          elevation: 0,
          title: Center(
            child: Text("User Profile",
                style: TextStyle(color: Colors.teal[800], fontSize: 16.5)),
          ),
        ),
        body: SingleChildScrollView(
          child: Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.symmetric(horizontal: 35),
              child: Column(
                children: [
                  SizedBox(
                    height: 10,
                  ),
                  CircleAvatar(
                    child: SvgPicture.asset(
                      "assets/person_black_24dp.svg",
                      color: Colors.white,
                      height: 55,
                      width: 55,
                    ),
                    radius: 60,
                    backgroundColor: Colors.blueGrey,
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  username(),
                  SizedBox(
                    height: 5,
                  ),
                  phone(),
                  SizedBox(
                    height: 5,
                  ),
                  bio(),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        color: Colors.tealAccent[400],
                        height: 40,
                        width: 70,
                        child: ElevatedButton(
                            onPressed: () {
                              _username.text.isNotEmpty &&
                                      _phone.text.isNotEmpty &&
                                      _bio.text.isNotEmpty
                                  ? doUserDetails(
                                      _username.text, _phone.text, _bio.text)
                                  : Fluttertoast.showToast(
                                      msg: 'all feilds are required',
                                      textColor: Colors.red);
                            },
                            child: Text("Save")),
                      ),
                      Container(
                        color: Colors.tealAccent[400],
                        height: 40,
                        width: 80,
                        child: ElevatedButton(
                            onPressed: () {
                              _MoveToHome();
                            },
                            child: Text("Cancel")),
                      ),
                    ],
                  )
                ],
              )),
        ));
  }

  doUserDetails(String username, String phone, String bio) async {
    var res = await userDetails(username, phone, bio);
    print(username);
    print(phone);
    print(bio);
    print(res.toString());
    if (res['sucess']) {
      Fluttertoast.showToast(msg: 'Updated', textColor: Colors.red);
    } else {
      Fluttertoast.showToast(msg: 'please try again', textColor: Colors.red);
    }
  }

  Widget username() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 5),
      width: MediaQuery.of(context).size.width / 1,
      height: 50,
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
        Container(
          child: Row(
            children: [
              Container(
                  width: MediaQuery.of(context).size.width / 1.5,
                  padding: EdgeInsets.symmetric(vertical: 5),
                  decoration: BoxDecoration(
                      border: Border(
                          bottom: BorderSide(color: Colors.teal, width: 1.8))),
                  child: TextFormField(
                    textAlign: TextAlign.center,
                    controller: _username,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: "Enter username ",
                    ),
                  ))
            ],
          ),
        )
      ]),
    );
  }

  Widget phone() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 5),
      width: MediaQuery.of(context).size.width / 1,
      height: 40,
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
        Container(
          child: Row(
            children: [
              Container(
                  width: MediaQuery.of(context).size.width / 1.5,
                  padding: EdgeInsets.symmetric(vertical: 5),
                  decoration: BoxDecoration(
                      border: Border(
                          bottom: BorderSide(color: Colors.teal, width: 1.8))),
                  child: TextFormField(
                    textAlign: TextAlign.center,
                    controller: _phone,
                    keyboardType: TextInputType.phone,
                    decoration: InputDecoration(
                      isDense: true,
                      border: InputBorder.none,
                      hintText: "Enter your mobile number ",
                    ),
                  ))
            ],
          ),
        )
      ]),
    );
  }

  Widget bio() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 5),
      width: MediaQuery.of(context).size.width / 1,
      height: 90,
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
        Row(
          children: [
            Container(
                width: MediaQuery.of(context).size.width / 1.5,
                padding: EdgeInsets.symmetric(vertical: 5),
                decoration: BoxDecoration(
                    border: Border(
                        bottom: BorderSide(color: Colors.teal, width: 1.8))),
                child: TextFormField(
                  textAlign: TextAlign.center,
                  controller: _bio,
                  maxLines: 3,
                  minLines: 1,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    isDense: true,
                    border: InputBorder.none,
                    hintText: "Say something about you! ",
                  ),
                ))
          ],
        )
      ]),
    );
  }

  void _clearAll() {
    _username.text = "";
    _bio.text = "";
  }

  void _MoveToHome() {
    Navigator.push(
        this.context, MaterialPageRoute(builder: (context) => HomeScreen()));
  }
}
