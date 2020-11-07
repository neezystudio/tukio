import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:tukio/screens/homescreen.dart';

class SplashScreen extends StatefulWidget {
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    navigateUser();
  }

  navigateUser() {
    // checking whether user already loggedIn or not
    FirebaseAuth.instance.currentUser().then((currentUser) {
      if (currentUser == null) {
        Timer(Duration(seconds: 7),
            () => Navigator.pushReplacementNamed(context, "/auth"));
      } else {
        Timer(
          Duration(seconds: 7),
          () => Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(
                  builder: (context) =>
                      HomeScreen(username: currentUser.displayName)),
              (Route<dynamic> route) => false),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
//Lottie animation is added a child widget
              child: Lottie.network(
                  "https://assets7.lottiefiles.com/packages/lf20_5Vz7xX.json"),
            ),
          ),
        ),
      ),
    );
  }
}
