import 'dart:ffi';

import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
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
              countryCard()
            ],
          )),
    );
  }

  Widget countryCard() {
    return Container(
      width: MediaQuery.of(context).size.width / 1.5,
      padding: EdgeInsets.symmetric(vertical: 5),
      decoration: BoxDecoration(
          border: Border(bottom: BorderSide(color: Colors.teal, width: 1.8))),
      child: Row(
        children: [
          Expanded(
            child: Container(
                child: Center(
              child: Text("India", style: TextStyle(fontSize: 16)),
            )),
          ),
          Icon(
            Icons.arrow_drop_down,
            color: Colors.teal,
            size: 28,
          )
        ],
      ),
    );
  }
}
//Flutter Chat App - Let's work on the Login page and Country Page of WhatsApp Clone (pt-1) || #27
//12