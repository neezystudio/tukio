import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tukio/utils/colors.dart';
import 'package:tukio/pages/event_tabs/add_event/add_event.dart';
import 'package:tukio/widgets/event_list_card.dart';
import 'package:tukio/pages/event_tabs/add_event/event_page_tabs/event_main_tab.dart';

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
