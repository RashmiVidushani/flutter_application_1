import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/Model/chatmodel.dart';
import 'package:flutter_application_1/Model/usermodel.dart';
import 'package:flutter_application_1/Screens/homescreen.dart';
import 'package:flutter_application_1/rest/restapi.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;

class EditProfile extends StatefulWidget {
  const EditProfile({
    Key? key,
    this.sourceChat,
  }) : super(key: key);
  final ChatModel? sourceChat;

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final CollectionReference _users =
      FirebaseFirestore.instance.collection('users');
  late String username;
  late String email;
  late String phone;

  User? user = FirebaseAuth.instance.currentUser;
  TextEditingController _username = TextEditingController();
  TextEditingController _email = TextEditingController();
  int popTime = 0;

  getUser() {
    User? user = FirebaseAuth.instance.currentUser;
    FirebaseFirestore.instance.collection('users').doc(user!.uid).update(
        {"username": _username.text, "email": _email.text}).then((value) {});
  }

  updateUser(user) {
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
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          title: Text(
            "Set your Profile...",
            style: TextStyle(
                color: Colors.teal,
                fontWeight: FontWeight.w700,
                wordSpacing: 1,
                fontSize: 18),
          ),
          centerTitle: true,
        ),
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
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  usernameU(),
                  SizedBox(
                    height: 15,
                  ),
                  emailU(),
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
                              _username.text.isNotEmpty &&
                                      _email.text.isNotEmpty
                                  ? updateUser(user)
                                  : Fluttertoast.showToast(
                                      msg: 'all feilds are required',
                                      textColor: Colors.red);
                              /* ? doUpdateUser(
                                       _username.text, _email.text)
                                  : Fluttertoast.showToast(
                                      msg: 'all feilds are required',
                                      textColor: Colors.red);*/
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

/*
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
*/
  Widget usernameU() {
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
                labelText: username,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                hintText: "Enter username ",
              ),
            ))
      ]),
    );
  }

  Widget emailU() {
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
              controller: _email,
              maxLines: 3,
              minLines: 1,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                isDense: true,
                labelText: email,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                hintText: "Enter Email ",
              ),
            ))
      ],
    ));
  }

  void _clearAll() {
    _username.text = "";
    _email.text = "";
  }

  void _MoveToHome() {
    Navigator.push(
        this.context, MaterialPageRoute(builder: (context) => HomeScreen()));
  }
}
