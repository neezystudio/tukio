import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:tukio/utils/colors.dart';

class FakeList extends StatefulWidget {
  FakeList({Key key}) : super(key: key);

  @override
  _FakeListState createState() => _FakeListState();

    String _guestUserID;
  bool _going;

}

class _FakeListState extends State<FakeList> {
   String _fName;
  String _lName;

  
  @override
  void initState() {
    super.initState();
    getGuestUserData();
  }

  ///Gets a list of guests from the database
  void getGuestUserData() {
    FirebaseFirestore.instance
        .collection('attendees')
        .doc(widget._guestUserID)
        .get()
        .then((DocumentSnapshot userDocument) {
      this.setState(() {
        _fName = userDocument['FirstName'];
        _lName = userDocument['LastName'];
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return _fName == null || _lName == null
        ? new Card(
            child: new ListTile(
              leading: const CircularProgressIndicator(),
              title: new Text("Loading Data..."),
            ),
          )
        : new Card(
            child: new ListTile(
              leading: widget._going
                  ? const Icon(
                      Icons.check,
                      color: AppColours.tick,
                    )
                  : const Icon(
                      Icons.clear,
                      color: AppColours.error,
                    ),
              title: new Text(_fName),
              subtitle: new Text(_lName),
            ),
          );
  }
}