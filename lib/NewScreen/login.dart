import 'package:flutter/material.dart';
import 'package:flutter_application_1/NewScreen/country.dart';
import 'package:flutter_application_1/NewScreen/countrymodel.dart';
import 'package:flutter_application_1/NewScreen/otpscreen.dart';
import 'package:flutter_application_1/Screens/homescreen.dart';
import 'package:flutter_application_1/rest/restapi.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  String countryname = "Sri Lanka";
  String countrycode = "+94";
  TextEditingController _phone = TextEditingController();

  late SharedPreferences _sharedPreferences;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            elevation: 0,
            backgroundColor: Colors.white,
            title: Text(
              "Setting user profile ",
              style: TextStyle(
                  color: Colors.teal,
                  fontWeight: FontWeight.w700,
                  wordSpacing: 1,
                  fontSize: 18),
            ),
            centerTitle: true,
            actions: [
              Icon(
                Icons.more_vert,
                color: Colors.black,
              ),
            ]),
        body: SingleChildScrollView(
          child: Container(
              height: MediaQuery.of(context).size.height / 3,
              width: MediaQuery.of(context).size.width,
              child: Column(
                children: [
                  SizedBox(
                    height: 5,
                  ),
                  Text("Register now!",
                      style:
                          TextStyle(fontSize: 14, fontWeight: FontWeight.w700)),
                  countryCard(),
                  SizedBox(
                    height: 10,
                  ),
                  number(),
                  Expanded(
                    child: Container(),
                  ),
                  InkWell(
                    onTap: () {
                      if (_phone.text.length != 9) {
                        InvalidNumber();
                      } else {
                        ShowtheDialog();
                      }
                    },
                    child: Container(
                      color: Colors.tealAccent[400],
                      height: 40,
                      width: 70,
                      child: ElevatedButton(
                          onPressed: () {
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => OtpScreen(
                                          countrycode: countrycode,
                                          number: _phone.text,
                                        )));
                          },
                          child: Text(
                            "Next",
                            style: TextStyle(
                                fontWeight: FontWeight.w700, fontSize: 18),
                          )),
                    ),
                  ),
                ],
              )),
        ));
  }

/*
  doLogin(String username, String password) async {
    _sharedPreferences = await SharedPreferences.getInstance();
    var res = await userLogin(username.trim(), password.trim());
    if (_sharedPreferences.getString('uid') == null &&
        _sharedPreferences.getString('uname') == null) {
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => OtpScreen(
                    number: _phone.text,
                    countrycode: countrycode,
                  )));
    } else {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => HomeScreen()));
    }
    if (res['sucess']) {
      String uname = res['user'][0]['username'];
      String uid = res['user'][0]['id'];
      _sharedPreferences.setString('uId', uid);
      _sharedPreferences.setString('userName', username);
    } else {
      Fluttertoast.showToast(msg: 'Email or the password is not valid');
    }
  }
*/
  Widget countryCard() {
    return InkWell(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (builder) =>
                      Country(setCountryData: setCountryData)));
        },
        child: Container(
          width: MediaQuery.of(context).size.width / 1.5,
          padding: EdgeInsets.symmetric(vertical: 5),
          decoration: BoxDecoration(
              border:
                  Border(bottom: BorderSide(color: Colors.teal, width: 1.8))),
          child: Row(
            children: [
              Expanded(
                child: Container(
                    child: Center(
                  child: Text(countryname, style: TextStyle(fontSize: 16)),
                )),
              ),
              Icon(
                Icons.arrow_drop_down,
                color: Colors.teal,
                size: 28,
              )
            ],
          ),
        ));
  }

  Widget number() {
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
                    controller: _phone,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      isDense: true,
                      border: InputBorder.none,
                      hintText: "Enter phone number ",
                      prefix: Text(countrycode),
                    ),
                  ))
            ],
          ),
        )
      ]),
    );
  }

  void setCountryData(CountryModel countryModel) {
    setState(() {
      countryname = countryModel.name;
      countrycode = countryModel.code;
    });
    Navigator.pop(context);
  }

  Future<void> ShowtheDialog() {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            content: SingleChildScrollView(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Confirm your phone number.",
                        style: TextStyle(fontSize: 14)),
                    SizedBox(
                      height: 10,
                    ),
                    Text(_phone.text,
                        style: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.w600))
                  ]),
            ),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text(
                    "Edit",
                  )),
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (builder) => OtpScreen(
                                  number: _phone.text,
                                  countrycode: countrycode,
                                )));
                    _phone.clear();
                  },
                  child: Text(
                    "Confirm",
                  ))
            ],
          );
        });
  }

  Future<void> InvalidNumber() {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            content: SingleChildScrollView(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Please enter a valid number",
                        style: TextStyle(fontSize: 14)),
                  ]),
            ),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text(
                    "Okay",
                  )),
            ],
          );
        });
  }
}
//how to fetch login email and password from database using node js and flutter http
//32