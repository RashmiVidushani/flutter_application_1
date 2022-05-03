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
  late final bool isEdit = false;
  User? user = FirebaseAuth.instance.currentUser;
  TextEditingController _username = TextEditingController();
  TextEditingController _bio = TextEditingController();
  TextEditingController _phone = TextEditingController();
  int popTime = 0;
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
              child: Column(
                children: [
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
                        child: buildEditIcon(color),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  username(),
                  SizedBox(
                    height: 15,
                  ),
                  phone(),
                  SizedBox(
                    height: 15,
                  ),
                  bio(),
                  SizedBox(
                    height: 20,
                  ),
                  Column(
                    children: [
                      Container(
                        color: Colors.tealAccent[400],
                        height: 40,
                        width: MediaQuery.of(context).size.width,
                        child: ElevatedButton(
                            onPressed: () {
                              _phone.text.isNotEmpty &&
                                      _username.text.isNotEmpty &&
                                      _bio.text.isNotEmpty
                                  ? doUpdateUser(
                                      _phone.text, _username.text, _bio.text)
                                  : Fluttertoast.showToast(
                                      msg: 'all feilds are required',
                                      textColor: Colors.red);
                            },
                            child: Text("Save")),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        color: Colors.tealAccent[400],
                        height: 40,
                        width: MediaQuery.of(context).size.width,
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

  doUpdateUser(String phone, String username, String bio) async {
    var res = await updateuser(phone, username, bio);
    print(username);

    print(bio);
    print(res.toString());
    if (res['sucess']) {
      Fluttertoast.showToast(
          msg: 'Updated', textColor: Color.fromARGB(255, 54, 244, 54));
    } else {
      Fluttertoast.showToast(msg: 'please try again', textColor: Colors.red);
    }
  }

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
      );
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

  Widget username() {
    return Container(
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
        Container(
            height: 60,
            width: MediaQuery.of(context).size.width / 1.3,
            padding: EdgeInsets.symmetric(vertical: 5),
            child: TextFormField(
              textAlign: TextAlign.center,
              controller: _username,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                hintText: "Enter username ",
              ),
            ))
      ]),
    );
  }

  Widget phone() {
    return Container(
        child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Container(
            height: 60,
            width: MediaQuery.of(context).size.width / 1.3,
            padding: EdgeInsets.symmetric(vertical: 5),
            child: TextFormField(
              textAlign: TextAlign.center,
              controller: _phone,
              keyboardType: TextInputType.phone,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                hintText: "Enter your mobile number ",
              ),
            ))
      ],
    ));
  }

  Widget bio() {
    return Container(
        child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Container(
            height: 60,
            width: MediaQuery.of(context).size.width / 1.3,
            padding: EdgeInsets.symmetric(vertical: 5),
            child: TextFormField(
              textAlign: TextAlign.center,
              controller: _bio,
              maxLines: 3,
              minLines: 1,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                isDense: true,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                hintText: "Say something about you! ",
              ),
            ))
      ],
    ));
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
