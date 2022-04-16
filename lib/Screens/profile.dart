import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

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
  @override
  Widget build(BuildContext context) {
    _updateUser() {
      FirebaseFirestore.instance.collection("users").doc(user!.uid).update({
        "username": _username.text,
        "uid": _uid.text,
        "bio": _bio.text
      }).then((_) {
        print("update sucessful");
      });
    }

    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
            backgroundColor: Colors.white,
            elevation: 0,
            title: Center(
              child: Text("User Profile",
                  style: TextStyle(color: Colors.teal[800], fontSize: 16.5)),
            ),
            actions: [
              IconButton(
                onPressed: () {},
                icon: Icon(Icons.more_vert, color: Colors.black),
              )
            ]),
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
                              _updateUser();
                              /*
                              String? username = _username.text;
                              String? uid = _uid.text;
                              String? bio = _bio.text;

                              await _users.doc(uid).update({
                                "username": username,
                                "uid": uid,
                                "bio": bio,
                              });*/
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
                      hintText: user!.uid,
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
      height: 50,
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
                  maxLines: 5,
                  minLines: 3,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
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
}
