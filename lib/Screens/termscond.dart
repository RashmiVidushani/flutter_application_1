import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/NewScreen/login.dart';
import 'package:flutter_application_1/Screens/loginscreen.dart';
import 'package:flutter_application_1/widget/color.dart';

class Termscond extends StatefulWidget {
  const Termscond({Key? key}) : super(key: key);

  @override
  _TermscondState createState() => _TermscondState();
}

class _TermscondState extends State<Termscond> {
  @override
  Widget build(BuildContext context) {
    //agree button
    final agreeButton = Material(
      elevation: 5,
      borderRadius: BorderRadius.circular(30),
      color: Appcolor.homebg,
      child: MaterialButton(
          padding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
          minWidth: MediaQuery.of(context).size.width,
          onPressed: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => Login()));
          },
          child: const Text(
            "I agree",
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
          )),
    );
    //agree button
    final notagreeButton = Material(
      elevation: 5,
      borderRadius: BorderRadius.circular(30),
      color: Appcolor.hometi,
      child: MaterialButton(
          padding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
          minWidth: MediaQuery.of(context).size.width,
          onPressed: () {
            exit(0);
          },
          child: const Text(
            "I do not agree",
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
          )),
    );
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
            padding: const EdgeInsets.all(8.0),
            child: Center(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Column(
                      children: [
                        Row(
                          children: [
                            Text(
                              "Edu-MASTER",
                              style: TextStyle(
                                  fontSize: 40,
                                  color: Appcolor.home,
                                  backgroundColor: Appcolor.white,
                                  fontWeight: FontWeight.w700),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Row(children: [
                          Text(
                            "Terms and conditions",
                            style: TextStyle(
                                fontSize: 22,
                                color: Appcolor.black,
                                fontWeight: FontWeight.w500),
                          ),
                        ]),
                        const Padding(padding: EdgeInsets.only(top: 20)),
                        Container(
                            width: MediaQuery.of(context).size.width,
                            height: 325,
                            decoration: BoxDecoration(
                                gradient: LinearGradient(
                                    colors: [
                                      Appcolor.homebg.withOpacity(0.9),
                                      Appcolor.hometi.withOpacity(0.9),
                                    ],
                                    begin: Alignment.bottomLeft,
                                    end: Alignment.centerRight),
                                borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(0),
                                    bottomLeft: Radius.circular(0),
                                    bottomRight: Radius.circular(30),
                                    topRight: Radius.circular(10)),
                                boxShadow: [
                                  BoxShadow(
                                      offset: const Offset(5, 10),
                                      blurRadius: 10,
                                      color: Appcolor.hometit.withOpacity(0.2))
                                ]),
                            child: Container(
                              padding: const EdgeInsets.only(
                                  left: 20, top: 25, right: 20),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "term 1.........................................................................................................",
                                    style: TextStyle(
                                        fontSize: 18, color: Appcolor.white),
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    "term 1.........................................................................................................",
                                    style: TextStyle(
                                        fontSize: 18, color: Appcolor.white),
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    "term 1.........................................................................................................",
                                    style: TextStyle(
                                        fontSize: 18, color: Appcolor.white),
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    "term 1.........................................................................................................",
                                    style: TextStyle(
                                        fontSize: 18, color: Appcolor.white),
                                  ),
                                ],
                              ),
                            )),
                        Column(
                          children: <Widget>[
                            const SizedBox(
                              height: 50,
                            ),
                            agreeButton,
                            const SizedBox(
                              height: 20,
                            ),
                            notagreeButton,
                            const SizedBox(
                              height: 20,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ]),
            )),
      ),
    );
  }
}
