import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'package:tukio/bloc/navigation_bloc/navigation_bloc.dart';
import 'package:tukio/pages/event_tabs/share_event.dart';
import 'package:tukio/pages/settings.dart';
import 'package:tukio/widgets/event_list_card.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:tukio/widgets/locator.dart';
import 'package:tukio/widgets/user_controller.dart';
import 'package:tukio/widgets/user_model.dart';

class HomePage extends StatefulWidget with NavigationStates {
  static String route = "home";
  final Function onMenuTap;
  final User user;

  const HomePage({Key key, this.onMenuTap, this.user}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  UserModel _currentUser = locator.get<UserController>().currentUser;
  _top(BuildContext context, String home) {
    return;
  }

  _gridItem(icon) {
    return Column(
      children: <Widget>[
        CircleAvatar(
          child: Icon(
            icon,
            size: 25.0,
            color: Colors.white,
          ),
          backgroundColor: Colors.deepOrange.withOpacity(0.9),
        ),
        SizedBox(height: 10.0),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(16.0),
            decoration: BoxDecoration(
                color: Colors.grey[50],
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(30.0),
                  bottomRight: Radius.circular(30.0),
                )),
            child: Column(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        InkWell(
                            child: Icon(Icons.menu, color: Colors.black),
                            onTap: widget.onMenuTap),
                        Image.asset("assets/images/tukio_splash.png",
                            scale: 15),
                        /* CircleAvatar(
                    radius: 18.0,
                    child: Image(image: NetworkImage(user.photoUrl.toString())),
                  ),*/

                        SizedBox(
                          width: 200.0,
                        ),
                        Text(
                          "Hi ${_currentUser.displayName ?? 'nice to see you here.'}!\nWelcome  ",
                          style: TextStyle(
                            color: Colors.black,
                          ),
                        )
                      ],
                    ),
                    IconButton(
                        icon: Icon(FontAwesome5.user),
                        onPressed: () {
                          //Navigator.pushNamed(context, "/settings");
                          //Navigator.of(context).pushNamed('/settings');
                          Navigator.push(
                            context,
                            new MaterialPageRoute(
                              builder: (context) => ProfileView(),
                            ),
                          );
                        }),
                  ],
                ),
                SizedBox(
                  height: 30.0,
                ),
                TextField(
                  decoration: InputDecoration(
                      hintText: "Search",
                      fillColor: Colors.white,
                      filled: true,
                      suffixIcon: Icon(Icons.filter_list),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0),
                        borderSide: BorderSide(color: Colors.transparent),
                      ),
                      contentPadding: EdgeInsets.symmetric(
                          horizontal: 16.0, vertical: 16.0)),
                )
              ],
            ),
          ),
          SizedBox(
            height: 20.0,
          ),
          Padding(
            padding: EdgeInsets.all(16.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  "Categories",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 22.0,
                      fontStyle: FontStyle.italic),
                ),
                Text(
                  "View All",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12.0),
                )
              ],
            ),
          ),
          SizedBox(
            height: 20.0,
          ),
          Container(
            height: 200.0,
            child: PageView(
              controller: PageController(viewportFraction: 0.8),
              scrollDirection: Axis.horizontal,
              pageSnapping: true,
              children: <Widget>[
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 8),
                  width: 100,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(40)),
                      image: DecorationImage(
                          image: AssetImage("assets/images/attendance.jpg"),
                          fit: BoxFit.cover)),
                  padding: EdgeInsets.only(top: 50.0),
                  child: Text(
                    "Attendance",
                    style: TextStyle(
                        color: Colors.white.withOpacity(0.8),
                        fontSize: 20.0,
                        height: 1.4,
                        fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                ),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 8),
                  width: 100,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(40)),
                      image: DecorationImage(
                          image: AssetImage("assets/images/locations.jpg"),
                          fit: BoxFit.cover)),
                  padding: EdgeInsets.only(top: 50.0),
                  child: Text(
                    "Locations",
                    style: TextStyle(
                        color: Colors.white.withOpacity(0.8),
                        fontSize: 20.0,
                        height: 1.4,
                        fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                ),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 8),
                  width: 100,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(40)),
                      image: DecorationImage(
                          image: AssetImage("assets/images/tasks.jpg"),
                          fit: BoxFit.cover)),
                  padding: EdgeInsets.only(top: 50.0),
                  child: Text(
                    "Tasks\nand\nReminders",
                    style: TextStyle(
                        color: Colors.white.withOpacity(0.8),
                        fontSize: 20.0,
                        height: 1.4,
                        fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => ShareEvent()));
                  },
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 8),
                    width: 100,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(40)),
                        image: DecorationImage(
                            image: AssetImage("assets/images/event.jpg"),
                            fit: BoxFit.cover)),
                    padding: EdgeInsets.only(top: 50.0),
                    child: Text(
                      "My\nEvents",
                      style: TextStyle(
                          color: Colors.white.withOpacity(0.8),
                          fontSize: 20.0,
                          height: 1.4,
                          fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.all(16.0),
            child: Row(
              children: <Widget>[
                Text("My Events",
                    style: TextStyle(
                        fontSize: 22.0,
                        fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.italic))
              ],
            ),
          ),
          new StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .collection('events')
                .orderBy("start-time")
                .snapshots(),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (!snapshot.hasData) return new Text("Loading...");
              return new ListView(
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                children: snapshot.data.docs.map((DocumentSnapshot document) {
                  return new EventCard(
                      document['name'], document['description'], document.id);
                }).toList(),
              );
            },
          ),

          /*_cardItem(1),
          _cardItem(2),
          _cardItem(3),
          _cardItem(4),*/
        ],
      ),
    );

    // ignore: dead_code
  }

  _cardItem(image) {
    return Padding(
      padding: EdgeInsets.all(16.0),
      child: Row(
        children: <Widget>[
          Container(
            width: 100.0,
            height: 100.0,
            decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/images/location.jpg"),
                  fit: BoxFit.cover,
                ),
                borderRadius: BorderRadius.circular(20)),
          ),
          SizedBox(height: 20.0),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                "Give Me my Mountain",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18.0,
                ),
              ),
              SizedBox(height: 10.0),
              Text(
                "Karura Forest",
                style: TextStyle(
                  color: Colors.red,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10.0),
              Text(
                "16 Entries",
                style: TextStyle(
                  color: Colors.red,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
