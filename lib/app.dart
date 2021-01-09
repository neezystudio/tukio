import 'package:animated_splash/animated_splash.dart';
import 'package:flutter/material.dart';
import 'package:tukio/pages/authscreen.dart';
import 'package:tukio/pages/menu_dashboard_layout/menu_dashboard_layout.dart';
import 'package:tukio/pages/settings.dart';
import 'package:tukio/pages/splashscreen.dart';
import 'package:provider/provider.dart';
import 'package:tukio/utils/ThemeData.dart';
import 'package:tukio/utils/sharedpreferences.dart';

class MyApp extends StatefulWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  DarkThemeProvider themeChangeProvider = new DarkThemeProvider();

  @override
  void initState() {
    super.initState();
    getCurrentAppTheme();
  }

  void getCurrentAppTheme() async {
    themeChangeProvider.darkTheme =
        await themeChangeProvider.darkThemePreference.getTheme();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(
            // ignore: deprecated_member_use
            create: (_) {
              return themeChangeProvider;
            },
          )
        ],
        child: Consumer<DarkThemeProvider>(
            builder: (BuildContext context, value, Widget child) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Google SignIn Auth',
            theme: Styles.themeData(themeChangeProvider.darkTheme, context),
            routes: routes,
// Showing SplashScreen as the first screen when user launches the app.
            home: AnimatedSplash(
              imagePath: 'assets/images/color-logo (1).png',
              home: SplashScreen(),
              duration: 2500,
              type: AnimatedSplashType.StaticDuration,
            ),
          );
        }));
    /* child: Consumer<DarkThemeProvider>(
        builder: (BuildContext context, value, Widget child) {
      return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Google SignIn Auth',
        theme: Styles.themeData(themeChangeProvider.darkTheme, context),
        routes: routes,
// Showing SplashScreen as the first screen when user launches the app.
        home: AnimatedSplash(
          imagePath: 'assets/images/color-logo (1).png',
          home: SplashScreen(),
          duration: 2500,
          type: AnimatedSplashType.StaticDuration,
        ),
      );
    })*/
  }
}

var routes = <String, WidgetBuilder>{
  "/auth": (BuildContext context) => AuthScreen(),
  "/home": (BuildContext context) => MenuDashboardLayout(),
  "/settngs": (BuildContext context) => ProfileView(),
};
