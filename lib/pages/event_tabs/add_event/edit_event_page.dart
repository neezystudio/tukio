import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tukio/widgets/edit_event_form.dart';

class EventEditPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new EventEditPageState();

  String _eventID;
  EventEditPage(this._eventID);
}

class EventEditPageState extends State<EventEditPage> {
  Map<String, dynamic> initalData = null;

  ///Submit form callback
  ///
  /// The form fields are first validated, and then the event is added to the
  /// database. The current user is then added to the Administrator collection
  /// of the event with all privileges enabled.
  void submitForm(Map data) async {
    FirebaseFirestore.instance
        .collection("events")
        .doc(widget._eventID)
        .update(data);

    Navigator.of(context).pop();
  }

  @override
  void initState() {
    getData();
    super.initState();
  }

  void getData() {
    FirebaseFirestore.instance
        .doc("events/" + widget._eventID)
        .snapshots()
        .listen((DocumentSnapshot snapshot) {
      this.setState(() {
        initalData = snapshot.data as Map<String, dynamic>;
        print(initalData);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(
          title: new Text("Add Event"),
        ),
        body: initalData == null
            ? new Text("Loading...")
            : new EditEventForm(submitForm, initalData));
  }
}
