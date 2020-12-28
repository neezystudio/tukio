import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:tukio/bloc/navigation_bloc/navigation_bloc.dart';
import 'package:tukio/pages/event_tabs/share_event.dart';
import 'package:tukio/widgets/event_list_card.dart';

class HomePage extends StatelessWidget with NavigationStates {
  final Function onMenuTap;

  const HomePage({Key key, this.onMenuTap}) : super(key: key);

  _top() {
    return Container(
      padding: EdgeInsets.all(16.0),
      decoration: BoxDecoration(
          color: Colors.purple[800],
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
                      onTap: onMenuTap),
                  SizedBox(
                    width: 20.0,
                  ),
                  CircleAvatar(
                    radius: 18.0,
                    backgroundImage:
                        AssetImage('assets/images/profileavatar.jpg'),
                  ),
                  SizedBox(
                    width: 10.0,
                  ),
                  Text(
                    'Hi! Welcome',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  )
                ],
              ),
              IconButton(
                icon: Icon(
                  Icons.share_outlined,
                  color: Colors.white,
                ),
                onPressed: () => ShareEvent(),
              ),
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
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0)),
          )
        ],
      ),
    );
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
          _top(),
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
                  "Category",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22.0),
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
                    style:
                        TextStyle(fontSize: 22.0, fontWeight: FontWeight.bold))
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
