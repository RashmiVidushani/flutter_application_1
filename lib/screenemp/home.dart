import 'package:flutter/material.dart';
import 'package:flutter_application_1/Loginwithemail/authentication.dart';
import 'package:flutter_application_1/Loginwithemail/login.dart';
import 'package:flutter_application_1/Main%20Screen/special_links.dart';
import 'package:flutter_application_1/no/loginuser.dart';
import 'package:flutter_application_1/test.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Container(
              child: GridView.extent(
        primary: false,
        padding: const EdgeInsets.symmetric(vertical: 75.0, horizontal: 5.0),
        crossAxisSpacing: 1,
        mainAxisSpacing: 1,
        maxCrossAxisExtent: 200.0,
        children: <Widget>[
          Image.asset('assets/convo.png', height: 300, width: 300),
          GestureDetector(
            onTap: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => Test()));
            },
            child: Container(
                color: Colors.teal[800],
                padding: const EdgeInsets.all(8),
                child: Center(
                  child: Column(children: const [
                    SizedBox(
                      height: 25,
                    ),
                    Icon(Icons.forum, size: 60),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      "Forums",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    )
                  ]),
                )),
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => SpecialLinks()));
            },
            child: Container(
                color: Colors.teal[600],
                padding: const EdgeInsets.all(8),
                child: Center(
                  child: Column(children: const [
                    SizedBox(
                      height: 25,
                    ),
                    Icon(Icons.link, size: 60),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      "Special Links",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    )
                  ]),
                )),
          ),
          GestureDetector(
            onTap: () {
              AuthenticationHelper()
                  .signOut()
                  .then((_) => Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (contex) => LoginUser()),
                      ));
            },
            child: Container(
                color: Colors.teal[200],
                padding: const EdgeInsets.all(8),
                child: Center(
                  child: Column(children: const [
                    SizedBox(
                      height: 25,
                    ),
                    Icon(Icons.logout_sharp, size: 60),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      "Logout",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    )
                  ]),
                )),
          ),
        ],
      ))),
    );
  }
}
