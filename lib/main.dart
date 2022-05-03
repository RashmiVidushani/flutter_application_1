import 'package:camera/camera.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/Entrance/loginuser.dart';
import 'package:flutter_application_1/Entrance/registration.dart';
import 'package:flutter_application_1/Entrance/splashscreen.dart';
import 'package:flutter_application_1/Entrance/terms.dart';
import 'package:flutter_application_1/Main%20Screen/mainui.dart';
import 'package:flutter_application_1/Pages/chatpage.dart';
import 'package:flutter_application_1/Screens/camarascreen.dart';
import 'package:flutter_application_1/Screens/homescreen.dart';
import 'package:flutter_application_1/Screens/profile.dart';
import 'package:flutter_application_1/Screens/selectcontact.dart';
import 'package:flutter_application_1/no/loginscreen.dart';

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
      home: Profile(),
      routes: {'/profile': (context) => Profile()},
    );
  }
}
