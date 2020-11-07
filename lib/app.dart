import 'package:animated_splash/animated_splash.dart';
import 'package:flutter/material.dart';
import 'package:tukio/screens/authscreen.dart';
import 'package:tukio/screens/homescreen.dart';
import 'package:tukio/screens/splashscreen.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Google SignIn Auth',
      routes: routes,
// Showing SplashScreen as the first screen when user launches the app.
      home: AnimatedSplash(
        imagePath: 'assets/images/color-logo (1).png',
        home: SplashScreen(),
        duration: 2500,
        type: AnimatedSplashType.StaticDuration,
      ),
    );
  }
}

var routes = <String, WidgetBuilder>{
  "/auth": (BuildContext context) => AuthScreen(),
  "/home": (BuildContext context) => HomeScreen(
        username: 'gy',
      ),
};
