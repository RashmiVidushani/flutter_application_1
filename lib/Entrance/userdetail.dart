import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/Screens/homescreen.dart';
import 'package:flutter_application_1/widget/country.dart';
import 'package:flutter_application_1/no/registration.dart';
import 'package:flutter_application_1/Model/countrymodel.dart';
import 'package:flutter_application_1/rest/restapi.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../no/loginuser.dart';

class UserDetails extends StatefulWidget {
  const UserDetails({Key? key}) : super(key: key);

  @override
  State<UserDetails> createState() => _UserDetailsState();
}

class _UserDetailsState extends State<UserDetails> {
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  late SharedPreferences _sharedPreferences;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: Text(
          "Fill up your details...",
          style: TextStyle(
              color: Colors.teal,
              fontWeight: FontWeight.w700,
              wordSpacing: 1,
              fontSize: 18),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
          child: Container(
        height: MediaQuery.of(context).size.height / 1.2,
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(top: 25.0),
              child: Center(),
            ),
            SizedBox(
              height: 25,
            ),
            username(),
            SizedBox(
              height: 10,
            ),
            email(),
            SizedBox(
              height: 10,
            ),
            Expanded(
              child: Container(),
            ),
            InkWell(
              onTap: () {
                /* if (_phone.text.length != 9) {
                  InvalidNumber();
                } else {
                  ShowtheDialog();
                }*/
              },
              child: Container(
                color: Colors.tealAccent[400],
                height: 40,
                width: MediaQuery.of(context).size.width / 4,
                child: ElevatedButton(
                    onPressed: () {
                      _usernameController.text.isEmpty &&
                              _emailController.text.isEmpty
                          ? Fluttertoast.showToast(
                              msg: 'Please enter username or email',
                              textColor: Colors.red)
                          : addUserdetails();
                      Fluttertoast.showToast(
                          msg: 'User Profile Updated',
                          textColor: Color.fromARGB(255, 86, 244, 54));
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => HomeScreen()));
                    },
                    child: Text(
                      "Update User Profile",
                      style:
                          TextStyle(fontWeight: FontWeight.w700, fontSize: 18),
                    )),
              ),
            ),
          ],
        ),
      )),
    );
  }

  void addUserdetails() async {
    User? user = FirebaseAuth.instance.currentUser;
    FirebaseFirestore.instance.collection('users').doc(user!.uid).set(
        {"username": _usernameController.text, "email": _emailController.text});
/*
 Firestore.instance.collection("users").document(firebaseUser.uid).setData(
  {
    "age" : 38,
  }).then((_){
    print("success!");
  });*/
  }
/*
  doLogin(String username, String password, String phone) async {
    _sharedPreferences = await SharedPreferences.getInstance();
    var res = await userLogin(username.trim(), password.trim(), phone.trim());
    print(res.toString());
    print(username);
    print(password);
    print(phone);
    if (res['sucess']) {
      String useruserName = res['users'][0]['username'];
      String userEmail = res['users'][0]['email'];
      _sharedPreferences.setString('usersemail', userEmail);
      _sharedPreferences.setString('usersusername', useruserName);
      Fluttertoast.showToast(msg: 'Login successful');
      _sharedPreferences = await SharedPreferences.getInstance();
      Timer(Duration(seconds: 3), () async {
        if (_sharedPreferences.getString("usersemail") == null &&
            _sharedPreferences.getString("usersusername") == null) {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => LoginUser()));
        } else {
          /*Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context) => PhoneNumber(
                        countrycode: countrycode,
                        number: _phoneController.text,
                        username: _usernameController.text,
                      )));*/
        }
      });
    } else {
      Fluttertoast.showToast(
          msg: 'Invalid email or password', textColor: Colors.red);
    }
  }*/

  Widget username() {
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
                    controller: _usernameController,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      isDense: true,
                      border: InputBorder.none,
                      hintText: "Enter a username ",
                    ),
                  ))
            ],
          ),
        )
      ]),
    );
  }

  Widget email() {
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
                    controller: _emailController,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      isDense: true,
                      border: InputBorder.none,
                      hintText: "Enter a Email Address ",
                    ),
                  ))
            ],
          ),
        )
      ]),
    );
  }
}
