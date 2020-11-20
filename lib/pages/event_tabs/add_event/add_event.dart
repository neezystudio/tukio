import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:tukio/widgets/edit_event_form.dart';

class AddEventPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new AddEventPageState();
}

class AddEventPageState extends State<AddEventPage> {
  ///Submits the form
  ///
  /// The form fields are first validated, and then the event is added to the
  /// database. The current user is then added to the Administrator collection
  /// of the event with all privileges enabled.
  void submitForm(Map data) async {
    DocumentReference event =
        await FirebaseFirestore.instance.collection("events").add(data);

    User user = FirebaseAuth.instance.currentUser;

    FirebaseFirestore.instance
        .doc("events/" + event.id + "/administrators/" + user.uid)
        .set({
      "can-scan": true,
      "can-edit-event": true,
      "can-add-attendees": true
    });

    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(
          title: new Text("Create New Event"),
          backgroundColor: Colors.deepOrange,
        ),
        body: EditEventForm(submitForm, null));
  }
}
