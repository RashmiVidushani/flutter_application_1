import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/NewScreen/landingscreen.dart';
import 'package:flutter_application_1/Screens/camarascreen.dart';
import 'package:flutter_application_1/Screens/homescreen.dart';
import 'package:flutter_application_1/Screens/loginscreen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  cameras = await availableCameras();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const LandingScreen(),
    );
  }
}
//Flutter Chat App- Dynamic Widget Rendering with Help of ListView Builder 🔥 || #6