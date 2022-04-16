import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/NewScreen/userdetails.dart';
import 'package:flutter_application_1/Screens/homescreen.dart';
import 'package:flutter_application_1/Screens/profile.dart';
import 'package:otp_text_field/otp_text_field.dart';
import 'package:otp_text_field/style.dart';
import 'package:path/path.dart';
import 'package:pinput/pin_put/pin_put.dart';

class OtpScreen extends StatefulWidget {
  const OtpScreen({Key? key, required this.number, required this.countrycode})
      : super(key: key);

  final String number;
  final String countrycode;

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  final GlobalKey<ScaffoldState> _scaffoldkey = GlobalKey<ScaffoldState>();

  late String _verificationCode;
  final TextEditingController _pinPutController = TextEditingController();
  final FocusNode _pinPutFocusNode = FocusNode();
  final BoxDecoration pinPutDecoration = BoxDecoration(
      color: const Color.fromRGBO(43, 46, 66, 1),
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(
        color: const Color.fromRGBO(126, 203, 224, 1),
      ));
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          title: Center(
            child: Text("Verify ${widget.countrycode + widget.number}",
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
          Padding(
            padding: const EdgeInsets.all(30.0),
            child: PinPut(
              fieldsCount: 6,
              textStyle: const TextStyle(fontSize: 25.0, color: Colors.white),
              eachFieldWidth: 40.0,
              eachFieldHeight: 55.0,
              //onSubmit: (String pin) => _showSnackBar(pin),
              focusNode: _pinPutFocusNode,
              controller: _pinPutController,
              submittedFieldDecoration: pinPutDecoration,
              selectedFieldDecoration: pinPutDecoration,
              followingFieldDecoration: pinPutDecoration,
              pinAnimationType: PinAnimationType.fade,
              onSubmit: (pin) async {
                /* */
                try {
                  await FirebaseAuth.instance
                      .signInWithCredential(PhoneAuthProvider.credential(
                          verificationId: _verificationCode, smsCode: pin))
                      .then((value) async {
                    FirebaseAuth auth = FirebaseAuth.instance;
                    String uid = auth.currentUser!.uid.toString();

                    if (value.user != null) {
                      await FirebaseFirestore.instance
                          .collection('users')
                          .add({'uid': uid, 'username': null, 'bio': null});

                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                              builder: (context) => UserDetails()),
                          (route) => false);
                    } else {
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                              builder: (context) => UserDetails()),
                          (route) => false);
                    }
                  });
                } catch (e) {
                  FocusScope.of(context).unfocus();
                  _scaffoldkey.currentState!
                      .showSnackBar(SnackBar(content: Text("invalid")));
                }
              },
            ),
          ),
          SizedBox(
            height: 15,
          ),
          Text("Enter the 6 digit code recieved",
              style: TextStyle(color: Colors.grey[500], fontSize: 13.5)),
          SizedBox(
            height: 20,
          ),
          GestureDetector(
            onTap: () async {
              _verifyPhone();
            },
            child: bottomButton(
              "Resend code",
              Icons.message,
            ),
          ),
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

  _verifyPhone() async {
    await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: widget.countrycode + widget.number,
        verificationCompleted: (PhoneAuthCredential credential) async {
          await FirebaseAuth.instance
              .signInWithCredential(credential)
              .then((value) async {
            Navigator.push(this.context,
                MaterialPageRoute(builder: (context) => UserDetails()));
          });
        },
        verificationFailed: (FirebaseAuthException e) {
          print(e.message);
        },
        codeSent: (String verificationID, int? resendToken) async {
          setState(() {
            _verificationCode = verificationID;
          });
        },
        codeAutoRetrievalTimeout: (String verificationID) {
          setState(() {
            _verificationCode = verificationID;
          });
        },
        timeout: Duration(seconds: 60));
  }

  createUserInfirestore() async {
    final usersRef = FirebaseFirestore.instance.collection('users');

    User? user = FirebaseAuth.instance.currentUser;
    DocumentSnapshot doc = await usersRef.doc(user!.uid).get();

    if (!doc.exists) {
      Navigator.push(
          this.context, MaterialPageRoute(builder: (context) => Profile()));
      usersRef.doc(user.uid).set({
        "uid": user.uid,
      });
      doc = await usersRef.doc(user.uid).get();
    }
  }

  @override
  void initState() {
    super.initState();
    _verifyPhone();
  }
}
//Flutter - Let's work on the OTP Screen of WhatsApp Clone || Speed Coding || WhatsApp Clone #29
//4
