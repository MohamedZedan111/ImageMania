
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:image_mania/Screens/Auth_Screen.dart';
import 'package:image_mania/Screens/HomeScreen.dart';
import 'package:image_mania/Service/auth_Service.dart';

class LandingScreen extends StatelessWidget {
  const new({super.key});

  @override
  Widget build(BuildContext context) {
    AuthService _authService = AuthService();
    return StreamBuilder(
     stream: _authService.authStateChanges, 
     builder:(context, snapshot) {
      if(snapshot.connectionState == ConnectionState.waiting){
        return  Center(child: CircularProgressIndicator());
      } else if(snapshot.hasData){
        return  Homescreen();
      } else if(snapshot.hasError){
        return  Center(child: Text('Something went wrong!'));
      } else {
        return  AuthScreen();
      }
    }, );
  }
}