import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/Entrance/loginuser.dart';
import 'package:flutter_application_1/no/login.dart';
import 'package:flutter_application_1/widget/color.dart';

class Terms extends StatelessWidget {
  const Terms({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: SafeArea(
              child: Column(children: [
                SizedBox(
                  height: 20,
                ),
                Text(
                  "Edu-Master",
                  style: TextStyle(
                      color: Colors.teal,
                      fontSize: 29,
                      fontWeight: FontWeight.w600),
                ),
                SizedBox(
                  height: 5,
                ),
                Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  Text(
                    "Terms and conditions",
                    style: TextStyle(
                        fontSize: 15,
                        color: Appcolor.black,
                        fontWeight: FontWeight.w500),
                  ),
                ]),
                SizedBox(
                  height: MediaQuery.of(context).size.height / 30,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                ),
                SingleChildScrollView(
                    child: Container(
                  height: MediaQuery.of(context).size.height - 400,
                  width: MediaQuery.of(context).size.width / 1.2,
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                          colors: [
                            Appcolor.green.withOpacity(0.9),
                            Appcolor.hometi.withOpacity(0.9),
                          ],
                          begin: Alignment.bottomLeft,
                          end: Alignment.centerRight),
                      borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(20),
                          bottomLeft: Radius.circular(20),
                          bottomRight: Radius.circular(20),
                          topRight: Radius.circular(20)),
                      boxShadow: [
                        BoxShadow(
                            offset: const Offset(5, 10),
                            blurRadius: 10,
                            color: Appcolor.hometit.withOpacity(0.2))
                      ]),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Text(
                          "•  You should be aware that there are certain things that Edu-master will not take responsibility for.",
                          style:
                              TextStyle(fontSize: 16, color: Appcolor.black)),
                      Text(
                        "•  Certain functions of the app will require the app to have an active internet connection.",
                        style: TextStyle(fontSize: 16, color: Appcolor.black),
                      ),
                      Text(
                        "•  The connection can be Wi-Fi, or provided by your mobile network provider, but Agiletelescope cannot take responsibility for the app not working at full functionality if you don’t have access to Wi-Fi, and you don’t have any of your data allowance left.",
                        style: TextStyle(fontSize: 16, color: Appcolor.black),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                    ],
                  ),
                )),
                SizedBox(
                  height: 40,
                ),
                InkWell(
                    onTap: () {
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(builder: (builder) => LoginUser()),
                          (route) => false);
                    },
                    child: Container(
                        width: MediaQuery.of(context).size.width - 100,
                        height: 50,
                        child: Card(
                            margin: EdgeInsets.all(0),
                            elevation: 8,
                            color: Colors.greenAccent[700],
                            child: Center(
                                child: Text(
                              "Accept terms and conditions",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 18),
                            ))))),
                SizedBox(
                  height: 20,
                ),
                InkWell(
                    onTap: () {
                      exit(0);
                    },
                    child: Container(
                        width: MediaQuery.of(context).size.width - 100,
                        height: 50,
                        child: Card(
                            margin: EdgeInsets.all(0),
                            elevation: 8,
                            color: Colors.greenAccent[700],
                            child: Center(
                                child: Text(
                              "Cancel",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 18),
                            )))))
              ]),
            )));
  }
}
