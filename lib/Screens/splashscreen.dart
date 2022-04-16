import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/Screens/termscond.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    startTime();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: initScreen(context));
  }

  startTime() async {
    var duration = const Duration(seconds: 4);
    return Timer(duration, route);
  }

  route() {
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => const Termscond()));
  }

  initScreen(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const <Widget>[
            Padding(padding: EdgeInsets.only(top: 20.0)),
            Text(
              "Edu-master",
              style: TextStyle(
                  fontSize: 38,
                  color: Colors.purple,
                  fontWeight: FontWeight.w700),
            ),
            Text(
              "Your digital School",
              style: TextStyle(
                  fontSize: 15,
                  color: Color.fromARGB(255, 1, 26, 13),
                  fontWeight: FontWeight.w700),
            ),
            Padding(padding: EdgeInsets.only(top: 20.0)),
            CircularProgressIndicator(
              backgroundColor: Colors.white,
              strokeWidth: 1,
            )
          ],
        ),
      ),
    );
  }
}
