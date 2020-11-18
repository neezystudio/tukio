import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tukio/widgets/event_guest_list_card.dart';

class EventGuestPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new EventGuestPageState();

  final String _eventID;
  EventGuestPage(this._eventID);
}

class EventGuestPageState extends State<EventGuestPage> {
  DocumentReference userRef;
  @override
  initState() {
    super.initState();
    _getUserDoc();
  }

  //Call this method from initState()
  Future<void> _getUserDoc() async {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    final FirebaseFirestore _firestore = FirebaseFirestore.instance;

    User user = _auth.currentUser;
    setState(() {
      userRef = _firestore.collection('attendees').doc(user.uid);
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Padding(
        padding: const EdgeInsets.only(left: 8.0, right: 8.0, top: 15.0),
        child: new Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              new Expanded(
                child: new StreamBuilder<QuerySnapshot>(
                  // Gets all attendees in the current event
                  stream: userRef.collection('attendees').snapshots(),
                  builder: (BuildContext context,
                      AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (!snapshot.hasData) return new Text("Loading...");
                    return new ListView(
                      children:
                          snapshot.data.docs.map((DocumentSnapshot document) {
                        return new EventGuestListCard(
                            document.id, document.data()["Going"]);
                      }).toList(),
                    );
                  },
                ),
              )
            ]));
  }
}
