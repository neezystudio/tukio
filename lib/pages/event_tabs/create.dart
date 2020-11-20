import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:tukio/utils/colors.dart';
import 'package:tukio/pages/event_tabs/add_event/add_event.dart';
import 'package:tukio/widgets/event_list_card.dart';

class CreatePage extends StatefulWidget {
  CreatePage({Key key}) : super(key: key);

  @override
  _CreatePageState createState() => _CreatePageState();
}

class _CreatePageState extends State<CreatePage> with TickerProviderStateMixin {
  void addEvent() {
    Navigator.of(context)
        .push(new MaterialPageRoute(builder: (context) => new AddEventPage()));
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      floatingActionButton: new FloatingActionButton(
        backgroundColor: Colors.deepOrange,
        hoverColor: Colors.deepOrangeAccent,
        onPressed: () => addEvent(),
        //backgroundColor: Colors.amberAccent,
        child: new Icon(Icons.add),
      ),
      body: new Material(
        color: AppColours.primaryCharcoalDark,

        // Get all events ordered by start time
        child: new StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection('events')
              .orderBy("start-time")
              .snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) return new Text("Loading...");
            return new ListView(
              children: snapshot.data.docs.map((DocumentSnapshot document) {
                return new EventCard(
                    document['name'], document['description'], document.id);
              }).toList(),
            );
          },
        ),
      ),
    );
  }
}
