import 'package:flutter/material.dart';
import 'package:flutter_application_1/NewScreen/login.dart';

class LandingScreen extends StatelessWidget {
  const LandingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: SafeArea(
              child: Column(children: [
                SizedBox(
                  height: 40,
                ),
                Text(
                  "Welcome",
                  style: TextStyle(
                      color: Colors.teal,
                      fontSize: 29,
                      fontWeight: FontWeight.w600),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height / 12,
                ),
                Image.asset(
                  "assets/bg.png",
                  color: Colors.greenAccent[700],
                  height: 300,
                  width: 300,
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height / 9,
                ),
                Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(
                            style: TextStyle(color: Colors.black, fontSize: 17),
                            children: [
                              TextSpan(
                                  text: "Agree and continue to accept the",
                                  style: TextStyle(
                                      color:
                                          Color.fromARGB(255, 18, 175, 196))),
                              TextSpan(
                                  text: "whatsapp Terms and Conditions",
                                  style: TextStyle(color: Colors.cyan)),
                            ]))),
                SizedBox(
                  height: 10,
                ),
                InkWell(
                    onTap: () {
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(builder: (builder) => Login()),
                          (route) => false);
                    },
                    child: Container(
                        width: MediaQuery.of(context).size.width - 110,
                        height: 50,
                        child: Card(
                            margin: EdgeInsets.all(0),
                            elevation: 8,
                            color: Colors.greenAccent[700],
                            child: Center(
                                child: Text(
                              "Agree and continoue",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 18),
                            )))))
              ]),
            )));
  }
}
