import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/NewScreen/login.dart';
import 'package:flutter_application_1/NewScreen/registration.dart';
import 'package:flutter_application_1/Screens/homescreen.dart';
import 'package:flutter_application_1/rest/restapi.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserDetails extends StatefulWidget {
  UserDetails({Key? key}) : super(key: key);

  @override
  State<UserDetails> createState() => _UserDetailsState();
}

class _UserDetailsState extends State<UserDetails> {
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  late SharedPreferences _sharedPreferences;

  @override
  Widget build(BuildContext parentContext) {
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
        height: MediaQuery.of(context).size.height / 2,
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(top: 25.0),
              child: Center(
                child: Text(
                  "Welcome!",
                  style: TextStyle(fontSize: 25.0),
                ),
              ),
            ),
            SizedBox(
              height: 25,
            ),
            SizedBox(
              height: 25,
            ),
            username(),
            SizedBox(
              height: 10,
            ),
            password(),
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
                      _usernameController.text.isNotEmpty &&
                              _passwordController.text.isNotEmpty
                          ? doLogin(_usernameController.text,
                              _passwordController.text)
                          : Fluttertoast.showToast(
                              msg: 'All feilds are required',
                              textColor: Colors.red);
                    },
                    child: Text(
                      "Login",
                      style:
                          TextStyle(fontWeight: FontWeight.w700, fontSize: 18),
                    )),
              ),
            ),
            SizedBox(
              height: 50,
            ),
            InkWell(
              onTap: () => Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => Registration())),
              child: RichText(
                  text: TextSpan(
                      text: "Create a new account",
                      style: TextStyle(
                          color: Color.fromARGB(255, 39, 57, 161),
                          fontSize: 14.5))),
            ),
          ],
        ),
      )),
    );
  }

  doLogin(String username, String password) async {
    _sharedPreferences = await SharedPreferences.getInstance();
    var res = await userLogin(username.trim(), password.trim());
    print(res.toString());
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
              .push(MaterialPageRoute(builder: (context) => Login()));
        } else {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => HomeScreen()));
        }
      });
    } else {
      Fluttertoast.showToast(
          msg: 'Invalid email or password', textColor: Colors.red);
    }

    /* _sharedPreferences = await SharedPreferences.getInstance();
    var res = await userLogin(username.trim(), password.trim());
    print(res.toString());
    print(password);
    print(username);
  String useruserName = res['users'][0]['username'];
    String userId = res['users'][0]['id'];
    if (_sharedPreferences.getString('username') == null &&
        _sharedPreferences.getString('password') == null) {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => UserDetails()));
    } else {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => Login()));
    }
    if (res['sucess']) {
      String username = res['users'][0]['username'];
      String password = res['users'][0]['password'];
      _sharedPreferences.setString('password', password);
      _sharedPreferences.setString('username', username);
    } else {
      Fluttertoast.showToast(msg: 'Email or the password is not valid');
    }*/
  }

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

  Widget password() {
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
                    obscureText: true,
                    controller: _passwordController,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      isDense: true,
                      border: InputBorder.none,
                      hintText: "Enter a password ",
                    ),
                  ))
            ],
          ),
        )
      ]),
    );
  }
}
