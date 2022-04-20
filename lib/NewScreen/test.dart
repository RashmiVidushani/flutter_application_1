//flutter run --no-sound-null-safety

//Flutter Phone Authentication | Implementing Phone Auth Using Flutter & Firebase + Source Code

/*import 'dart:async';
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
  TextEditingController _username = TextEditingController();
  TextEditingController _password = TextEditingController();
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
                      _username.text.isNotEmpty && _password.text.isNotEmpty
                          ? doLogin(_username.text, _password.text)
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

  doLogin(String _username, String _password) async {
    _sharedPreferences = await SharedPreferences.getInstance();
    var res = await userLogin(_username.trim(), _password.trim());
    print(_password);
    print(_username);

    if (_sharedPreferences.getString('username') == null &&
        _sharedPreferences.getString('password') == null) {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => UserDetails()));
    } else {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => Login()));
    }
    if (res['sucess']) {
      String _username = res['users'][0]['username'];
      String _password = res['users'][0]['password'];
      _sharedPreferences.setString('password', _password);
      _sharedPreferences.setString('username', _username);
    } else {
      Fluttertoast.showToast(msg: 'Email or the password is not valid');
    }
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
                    controller: _username,
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
                    controller: _password,
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
 */


















/*router.route('/login').post((req,res)=>{

    const username=req.body.username;
    const password=req.body.password;
    
    var sql ="Select * from users where username=? and  password=?";
    console.log(username);
    console.log(password);
    db.query(sql,[username,password], function(err,data,fields){
       if(err){
           res.send(JSON.stringify({sucess:false,message:err}));
       }else{
           if(data.length>0){
               res.send(JSON.stringify({sucess:true,message:data}));
           }else{
               res.send(JSON.stringify({sucess:false,message:'no user'}));
           }
          
       }
    });
}); */