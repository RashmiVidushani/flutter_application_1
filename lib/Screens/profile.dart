import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/Model/chatmodel.dart';
import 'package:flutter_application_1/Screens/homescreen.dart';
import 'package:flutter_svg/flutter_svg.dart';
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
  TextEditingController _uid = TextEditingController();
  int popTime = 0;
  @override
  Widget build(BuildContext context) {
    /*
    Future setUser() async {
      setState(() {});
      var url = "http://192.168.8.228:5000/api/setusers";
      var response = await http.post(Uri.parse(url), body: {
        "idsignup": user!.uid,
        "signupusername": _username.text.toString(),
        "signupbio": _bio.text.toString(),
      });
      var message = jsonDecode(response.body);
      if (message == "true") {
        print("Successful " + message);
      } else {
        print("Error: " + message);
      }
    }*/

    /*
   String uid= widget.sourceChat!.id!.toString();
    setUsers(String uid, String username, String bio) {
      ChatModel chatModel = ChatModel(
         ,
      );
    }

    void setUser(String username, String uid, String bio) async {
      for (int i = 0; i < popTime; i++) {
        Navigator.pop(context);
      }

      var request = http.MultipartRequest(
          "POST", Uri.parse("http://192.168.8.228:5000/api/setusers"));
      // request.files.add(await http.MultipartFile.fromPath("img", path));
      request.headers.addAll({
        "Content-type": "multipart/form-data",
      });
      http.StreamedResponse response = await request.send();
      var httpResponse = await http.Response.fromStream(response);
      var data = json.decode(httpResponse.body);
      //print(data['path']);
    }
*/
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
                  userid(),
                  SizedBox(
                    height: 5,
                  ),
                  username(),
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
                              //setUser();
                              //  _updateUser();
                              _MoveToHome();
                              _clearAll();
                            },
                            child: Text("Save")),
                      ),
                      Container(
                        color: Colors.tealAccent[400],
                        height: 40,
                        width: 80,
                        child: ElevatedButton(
                            onPressed: () {
                              _clearAll();
                            },
                            child: Text("Cancel")),
                      ),
                    ],
                  )
                ],
              )),
        ));
  }

  Widget userid() {
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
                    controller: _uid,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: widget.sourceChat?.id.toString(),
                      hintStyle: TextStyle(color: Colors.black26),
                    ),
                  ))
            ],
          ),
        )
      ]),
    );
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
    _uid.text = "";
  }

  void _MoveToHome() {
    Navigator.push(
        this.context, MaterialPageRoute(builder: (context) => HomeScreen()));
  }
}
