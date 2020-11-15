import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:tukio/pages/menu_dashboard_layout/menu_dashboard_layout.dart';
//import 'package:tukio/screens/homescreen.dart';

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
    User currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser == null) {
      Timer(Duration(seconds: 6),
          () => Navigator.pushReplacementNamed(context, "/auth"));
    } else {
      Timer(
        Duration(seconds: 6),
        () => Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(
                builder: (context) =>
                    //HomeScreen(username: currentUser.displayName)
                    MenuDashboardLayout()),
            (Route<dynamic> route) => false),
      );
    }
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
