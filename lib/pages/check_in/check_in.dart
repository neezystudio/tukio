import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tukio/bloc/navigation_bloc/navigation_bloc.dart';
import 'package:tukio/utils/colors.dart';

import 'package:tukio/widgets/event_list_card.dart';
import 'package:tukio/pages/event_tabs/add_event/add_event.dart';
import 'package:tukio/pages/event_tabs/add_event/event_page_tabs/event_main_tab.dart';

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

  navigateToDetail(DocumentSnapshot event) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => DetailsPage(
                  event: event,
                )));
  }

  Future getEvents() async {
    var firestore = FirebaseFirestore.instance;

    QuerySnapshot qn = await firestore.collection("events").getDocuments();

    return qn.docs;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: InkWell(
          child: Icon(Icons.menu, color: Colors.black),
          onTap: widget.onMenuTap,
        ),
        title: Text("Check In",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 24,
              color: Colors.black,
            )),
      ),
      body: new Material(
        color: AppColours.primaryCharcoalDark,

        // Get all events ordered by start time
        child: FutureBuilder(
            future: getEvents(),
            builder: (_, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CupertinoActivityIndicator(),
                );
              } else {
                return ListView.builder(
                    itemCount: snapshot.data.length,
                    itemBuilder: (_, index) {
                      return ListTile(
                        title: Text(
                          snapshot.data[index].data()["name"],
                          style: TextStyle(
                              color: Colors.white.withOpacity(0.8),
                              fontSize: 20.0,
                              height: 1.4,
                              fontWeight: FontWeight.bold),
                          textAlign: TextAlign.center,
                        ),
                        onTap: () => navigateToDetail(snapshot.data[index]),
                      );
                    });
              }
            }),
      ),
    );
  }
}
