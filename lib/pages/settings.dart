/*import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tukio/bloc/navigation_bloc/navigation_bloc.dart';
import 'package:tukio/pages/authscreen.dart';

class SettingsPage extends StatefulWidget with NavigationStates {
  final Function onMenuTap;
  final String username;

  const SettingsPage({Key key, this.onMenuTap, this.username})
      : super(key: key);

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  Function onMenuTap;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
          //onTap: onMenuTap,
          child: Icon(Icons.menu, color: Colors.black),
          onTap: onMenuTap,
        ),
        title: Text("Hello " + widget.username),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.exit_to_app),
            onPressed: () async {
              await FirebaseAuth.instance.signOut();
              await googleSignIn.disconnect();
              await googleSignIn.signOut();
              Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (context) => AuthScreen()),
                  (Route<dynamic> route) => false);
            },
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            RaisedButton(
              onPressed: () async {
                await FirebaseAuth.instance.signOut();
                await googleSignIn.disconnect();
                await googleSignIn.signOut();
                Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (context) => AuthScreen()),
                    (Route<dynamic> route) => false);
              },
              child: Text("Log Out"),
              color: Colors.redAccent,
            ),
            SizedBox(
              height: 10.0,
            ),
          ],
        ),
      ),
    );
  }
}
*/
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import 'package:tukio/bloc/navigation_bloc/navigation_bloc.dart';
import 'package:tukio/notifiers/dark_theme_provider.dart';

class SettingsPage extends StatelessWidget with NavigationStates {
  final Function onMenuTap;
  final String username;

  const SettingsPage({Key key, this.onMenuTap, this.username})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeChange = Provider.of<DarkThemeProvider>(context);
    return Scaffold(
      body: Stack(
        children: <Widget>[
          CustomScrollView(
            slivers: <Widget>[
              SliverAppBar(
                automaticallyImplyLeading: false,
                leading: InkWell(
                  onTap: onMenuTap,
                  child: Icon(Icons.menu, color: Colors.black),
                ),
                iconTheme: new IconThemeData(color: Colors.blue),
                floating: true,
                snap: true,
                //seethrough
                backgroundColor: Colors.transparent,

                //shadow
                elevation: 0.0,
                flexibleSpace: FlexibleSpaceBar(
                  title: Text(
                    "Hello + widget.username",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 26.0,
                        fontWeight: FontWeight.bold),
                  ),
                  centerTitle: true,
                ),
              ),
              Checkbox(
                  value: themeChange.darkTheme,
                  onChanged: (bool value) {
                    themeChange.darkTheme = value;
                  })
            ],
          ),
        ],
      ),
    );
  }
}
