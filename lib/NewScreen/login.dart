import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/NewScreen/country.dart';
import 'package:flutter_application_1/NewScreen/countrymodel.dart';
import 'package:flutter_application_1/NewScreen/otpscreen.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  String countryname = "Sri Lanka";
  String countrycode = "+94";
  TextEditingController _phone = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          title: Text(
            "Enter your phone number",
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
      body: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Column(
            children: [
              Text("Whatsapp will send an sms message to verify your number",
                  style: TextStyle(fontSize: 13.5)),
              SizedBox(
                height: 5,
              ),
              Text(
                "Whats my number?",
                style: TextStyle(color: Colors.cyan[800], fontSize: 12.8),
              ),
              SizedBox(
                height: 5,
              ),
              countryCard(),
              SizedBox(
                height: 5,
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
                                      number: _phone.text,
                                      countrycode: countrycode,
                                    )));
                      },
                      child: Text(
                        "Next",
                        style: TextStyle(
                            fontWeight: FontWeight.w700, fontSize: 18),
                      )),
                ),
              ),
              SizedBox(
                height: 40,
              ),
            ],
          )),
    );
  }

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
//Flutter Chat App - Let's work on the Login page and Country Page of WhatsApp Clone (pt-1) || #27
//12