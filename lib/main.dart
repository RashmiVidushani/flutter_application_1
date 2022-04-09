import 'package:camera/camera.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/NewScreen/landingscreen.dart';
import 'package:flutter_application_1/NewScreen/login.dart';
import 'package:flutter_application_1/Screens/camarascreen.dart';
import 'package:flutter_application_1/Screens/homescreen.dart';
import 'package:flutter_application_1/Screens/loginscreen.dart';

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
        primarySwatch: Colors.orange,
      ),
      home: const Login(),
    );
  }
}
//Flutter Chat App- Dynamic Widget Rendering with Help of ListView Builder 🔥 || #6