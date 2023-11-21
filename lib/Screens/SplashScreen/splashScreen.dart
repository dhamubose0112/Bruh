import 'package:bruh_yaash/Screens/DashBoard/dashBoardScreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'dart:async';
import 'package:flutter/material.dart';

import '../Login/login.dart';




class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 3), () {
      navigateToNextScreen();
    });
  }

  void navigateToNextScreen() {
    bool isLoggedIn = checkLoginStatus();
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) => isLoggedIn ? DashBoardScreen() : LoginScreen(),
      ),
    );
  }

  bool checkLoginStatus() {
    return FirebaseAuth.instance.currentUser != null;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                "assets/logo.png",
                width: 90,
                height: 90,
              ),
              const SizedBox(
                height: 20,
              ),
              CircularProgressIndicator(
                strokeWidth: 3,
                color: Colors.black,
              )
            ],
          ),
        ),
      ),
    );
  }
}
