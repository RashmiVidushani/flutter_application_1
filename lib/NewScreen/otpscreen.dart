import 'package:flutter/material.dart';
import 'package:otp_text_field/otp_text_field.dart';
import 'package:otp_text_field/style.dart';

class OtpScreen extends StatefulWidget {
  const OtpScreen({Key? key, required this.number, required this.countrycode})
      : super(key: key);

  final String number;
  final String countrycode;

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          title: Center(
            child: Text("Verify ${widget.countrycode} ${widget.number}",
                style: TextStyle(color: Colors.teal[800], fontSize: 16.5)),
          ),
          actions: [
            IconButton(
              onPressed: () {},
              icon: Icon(Icons.more_vert, color: Colors.black),
            )
          ]),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.symmetric(horizontal: 35),
        child: Column(children: [
          SizedBox(
            height: 10,
          ),
          RichText(
              text: TextSpan(children: [
            TextSpan(
                text: "Check ",
                style: TextStyle(color: Colors.black, fontSize: 14.5)),
            TextSpan(
                text: widget.countrycode + widget.number,
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 14.5,
                    fontWeight: FontWeight.bold)),
            TextSpan(
                text: " for the OTP code.",
                style: TextStyle(color: Colors.black, fontSize: 14.5)),
            TextSpan(
                text: " Wrong number?",
                style: TextStyle(color: Colors.teal[800], fontSize: 14.5)),
          ])),
          SizedBox(
            height: 10,
          ),
          OTPTextField(
            length: 6,
            width: MediaQuery.of(context).size.width,
            fieldWidth: 30,
            style: TextStyle(fontSize: 17),
            textFieldAlignment: MainAxisAlignment.spaceAround,
            fieldStyle: FieldStyle.underline,
            onCompleted: (pin) {
              print("Completed: " + pin);
            },
          ),
          SizedBox(
            height: 15,
          ),
          Text("Enter the 6 digit code recieved",
              style: TextStyle(color: Colors.grey[500], fontSize: 13.5)),
          SizedBox(
            height: 20,
          ),
          bottomButton("Resend message", Icons.message),
          SizedBox(
            height: 12,
          ),
          Divider(
            thickness: 1,
          ),
          bottomButton("Call again", Icons.call),
        ]),
      ),
    );
  }

  Widget bottomButton(String text, IconData icon) {
    return Row(
      children: [
        Icon(
          icon,
          color: Colors.teal,
          size: 24,
        ),
        SizedBox(
          width: 20,
        ),
        Text(
          text,
          style: TextStyle(fontSize: 14.5, color: Colors.teal),
        )
      ],
    );
  }
}
//Flutter - Let's work on the OTP Screen of WhatsApp Clone || Speed Coding || WhatsApp Clone #29
//4
