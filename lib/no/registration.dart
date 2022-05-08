import 'package:flutter/material.dart';
import 'package:flutter_application_1/no/loginuser.dart';
import 'package:flutter_application_1/rest/restapi.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Registration extends StatefulWidget {
  const Registration({Key? key}) : super(key: key);

  @override
  State<Registration> createState() => _RegistrationState();
}

class _RegistrationState extends State<Registration> {
  TextEditingController _username = TextEditingController();
  TextEditingController _password = TextEditingController();
  TextEditingController _email = TextEditingController();
  TextEditingController _phone = TextEditingController();
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
        height: MediaQuery.of(context).size.height / 1.6,
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(top: 25.0),
              child: Center(
                child: Text(
                  "Get started!",
                  style: TextStyle(fontSize: 25.0),
                ),
              ),
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
            phone(),
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
                width: MediaQuery.of(context).size.width / 3,
                child: ElevatedButton(
                    onPressed: () {
                      _username.text.isNotEmpty &&
                              _password.text.isNotEmpty &&
                              _email.text.isNotEmpty &&
                              _phone.text.isNotEmpty
                          ? doRegister(_username.text, _password.text,
                              _email.text, _phone.text)
                          : Fluttertoast.showToast(
                              msg: 'all feilds are required',
                              textColor: Colors.red);
                    },
                    child: Text(
                      "Register",
                      style:
                          TextStyle(fontWeight: FontWeight.w700, fontSize: 18),
                    )),
              ),
            ),
            SizedBox(
              height: 40,
            ),
            RichText(
                text: TextSpan(
                    text: "Already have an account? ",
                    style: TextStyle(
                        color: Color.fromARGB(255, 10, 10, 10),
                        fontSize: 14.5))),
            InkWell(
              onTap: () => Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => LoginUser())),
              child: RichText(
                  text: TextSpan(
                      text: "Login",
                      style: TextStyle(
                          color: Color.fromARGB(255, 39, 57, 161),
                          fontSize: 14.5))),
            ),
          ],
        ),
      )),
    );
  }

  doRegister(
      String username, String password, String email, String phone) async {
    var res = await userRegister(username, password, phone, email);
    print(res.toString());
    if (res['sucess']) {
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => LoginUser()));
    } else {
      Fluttertoast.showToast(msg: 'please try again', textColor: Colors.red);
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
                    controller: _email,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      isDense: true,
                      border: InputBorder.none,
                      hintText: "Enter a email ",
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
