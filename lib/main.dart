import 'package:camera/camera.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/Loginwithemail/home.dart';
import 'package:flutter_application_1/Loginwithemail/login.dart';
import 'package:flutter_application_1/Screens/creategroup.dart';
import 'package:flutter_application_1/Screens/homescreen.dart';
import 'package:flutter_application_1/Screens/selectcontact.dart';
import 'package:flutter_application_1/no/loginscreen.dart';
import 'package:flutter_application_1/no/loginuser.dart';
import 'package:flutter_application_1/Entrance/phonenumber.dart';
import 'package:flutter_application_1/Entrance/splashscreen.dart';
import 'package:flutter_application_1/Screens/camarascreen.dart';
import 'package:flutter_application_1/Screens/profile.dart';
import 'package:flutter_application_1/screenemp/home.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  cameras = await availableCameras();
  await Firebase.initializeApp();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Edu_Master ',
      theme: ThemeData(
        primarySwatch: Colors.teal,
      ),
      home: SplashScreen(),
      routes: {'/profile': (context) => Profile()},
    );
  }
}
