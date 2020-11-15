import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_signin_button/button_view.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:tukio/pages/menu_dashboard_layout/menu_dashboard_layout.dart';
//import 'package:tukio/screens/homescreen.dart';

String name;
String email;
String imageUrl;
final FirebaseAuth auth = FirebaseAuth.instance;
final GoogleSignIn googleSignIn = GoogleSignIn();

class AuthScreen extends StatefulWidget {
  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  bool isVisible = false;
  Future<User> _signIn() async {
    final GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn();
    final GoogleSignInAuthentication gsa =
        await googleSignInAccount.authentication;

    final AuthCredential credential = GoogleAuthProvider.credential(
      idToken: gsa.idToken,
      accessToken: gsa.accessToken,
    );
    final UserCredential authResult =
        await auth.signInWithCredential(credential);
    final User firebaseUser = authResult.user;
    name = firebaseUser.displayName;
    email = firebaseUser.email;
    imageUrl = firebaseUser.photoURL;
    final User currentUser = auth.currentUser;
    assert(firebaseUser.uid == currentUser.uid);
    return firebaseUser;
  }

  @override
  Widget build(BuildContext context) {
    var swidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("assets/images/bg.png"),
                    fit: BoxFit.cover)),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Visibility(
                child: new Center(
                  child: CircularProgressIndicator(
                    valueColor:
                        AlwaysStoppedAnimation<Color>(Color(0xFFB2F2D52)),
                  ),
                ),
                visible: isVisible,
              )
            ],
          ),
          Container(
            margin: const EdgeInsets.only(
              bottom: 60.0,
            ),
            child: Align(
              alignment: Alignment.bottomCenter,
              child: SizedBox(
                  height: 54.0,
                  width: swidth / 1.45,
                  child: SignInButton(
                    Buttons.Google,
                    text: "Sign up with Google",
                    onPressed: () {
                      setState(() {
                        this.isVisible = true;
                      });
                      _signIn().whenComplete(() {
                        Navigator.of(context).pushAndRemoveUntil(
                            MaterialPageRoute(
                                builder: (context) =>
                                    //HomeScreen(username: name)
                                    MenuDashboardLayout()),
                            (Route<dynamic> route) => false);
                      }).catchError((onError) {
                        Navigator.pushReplacementNamed(context, "/auth");
                      });
                    },
                    shape: RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(30.0),
                    ),
                    elevation: 5,
                  )),
            ),
          ),
        ],
      ),
    );
  }
}
