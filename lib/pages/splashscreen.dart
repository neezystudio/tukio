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
      Timer(Duration(seconds: 20),
          () => Navigator.pushReplacementNamed(context, "/auth"));
    } else {
      Timer(
        Duration(seconds: 20),
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
    return Container(
      height: MediaQuery.of(context).size.height * 0.65,
      width: MediaQuery.of(context).size.width * 0.65,
      child: Scaffold(
        backgroundColor: const Color(0xFFFFFFFF),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            child: Column(
              children: <Widget>[
                Lottie.network(
                    "https://assets1.lottiefiles.com/packages/lf20_dczlcl3u.json"),
                SizedBox(
                  height: 20.0,
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text("POWERED BY"),
                      Image.asset("assets/images/tukio_splash.png", scale: 15)
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
