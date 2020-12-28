import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:tukio/bloc/navigation_bloc/navigation_bloc.dart';

import 'package:tukio/widgets/event_list_card.dart';

class CheckInPage extends StatefulWidget with NavigationStates {
  final Function onMenuTap;

  const CheckInPage({Key key, this.onMenuTap}) : super(key: key);

  @override
  _CheckInPageState createState() => _CheckInPageState();
}

class _CheckInPageState extends State<CheckInPage> {
  //List<RSVP> nameItems = List<RSVP>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
          child: Icon(Icons.menu, color: Colors.white),
          onTap: widget.onMenuTap,
        ),
        title: Text("Check In",
            style: TextStyle(fontSize: 24, color: Colors.white)),
      ),
      body: new StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('attendees')
            .orderBy("start-time")
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) return new Text("Loading...");
          return new ListView(
            shrinkWrap: true,
            scrollDirection: Axis.vertical,
            children: snapshot.data.docs.map((DocumentSnapshot document) {
              return new EventCard(
                  document['name'], document['title'], document.id);
            }).toList(),
          );
        },
      ),
    );
  }
}
