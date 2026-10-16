import 'package:flutter/material.dart';
import 'package:image_mania/Screens/HomeScreen.dart';
import 'package:image_mania/Screens/Auth_Screen.dart';
import 'package:image_mania/Screens/Landing_Screen.dart';
import 'package:image_mania/Screens/Profile_Screen.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: AuthScreen());
  }
}
