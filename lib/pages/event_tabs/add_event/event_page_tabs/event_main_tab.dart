import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:tukio/widgets/event_list_card.dart';

import 'package:qr_flutter/qr_flutter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:http/http.dart' as http;
//import 'package:firebase_auth/firebase_auth.dart';
import 'package:tukio/utils/colors.dart';

// ignore: must_be_immutable
class EventMainTabPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new EventMainTabPageState();

  var _eventId;
  EventMainTabPage(this._eventId);
  String _address;
}

class EventMainTabPageState extends State<EventMainTabPage>
    with SingleTickerProviderStateMixin {
  bool fullScreenQR = false;
  DocumentSnapshot eventDocumentSnapshot;
  bool _qrReady = false;
  String _qrEntryCode = "null";

  @override
  void initState() {
    super.initState();
    getEventData(widget._eventId);
    //getEntryCode();
  }

  ///Queries OpenStreetMap using the latitude and longitude given in the [location]
  ///The resulting address is then displayed using setState.
  void setAddress(GeoPoint location) async {
    String query =
        "https://nominatim.openstreetmap.org/reverse?format=json&lat=" +
            location.latitude.toString() +
            "&lon=" +
            location.longitude.toString();

    var response = await http.get(
      Uri.encodeFull(query),
    );

    this.setState(
        () => widget._address = json.decode(response.body)["display_name"]);
  }

  ///Gets the document snapshot of the event with [eventID] and updates the address appropriately
  void getEventData(String eventID) async {
    FirebaseFirestore.instance
        .collection("events")
        .doc(eventID)
        .snapshots()
        .listen((DocumentSnapshot eventSnapshot) {
      this.setState(() => eventDocumentSnapshot = eventSnapshot);
      setAddress(eventSnapshot.data()["location"]);
    });
  }

  Future getEvents() async {
    var firestore = FirebaseFirestore.instance;

    QuerySnapshot qn = await firestore.collection("events").getDocuments();

    return qn.docs;
  }

  navigateToDetail(DocumentSnapshot event) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => DetailsPage(
                  event: event,
                )));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
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
                      title: Text(snapshot.data[index].data()["name"]),
                      onTap: () => navigateToDetail(snapshot.data[index]),
                    );
                  });
            }
          }),
    );

    /*Scaffold(
        body: StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('events')
          .orderBy('start-time', descending: true)
          .snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) return Text('Error');
        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
            return Center(
              child: CupertinoActivityIndicator(),
            );
          default:
            return ListView(
              /*children: snapshot.data.docs.map((DocumentSnapshot document) {
              return Card(
                child: InkWell(
                    onTap: () {
                      getEventData(document.id);
                    },
                    child: Text("${document['name']}")),
              );
            }).toList()*/
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              padding: const EdgeInsets.all(20.0),
              children: snapshot.data.docs.map((DocumentSnapshot document) {
                return Center(
                  child: new EventCard(
                    document['name'],
                    document['description'],
                    document.id,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => DetailsPage()),
                      );
                    },
                  ),
                );
              }).toList(),
            );
        }
      },
    ));*/

    // return new Stack(
    //   children: <Widget>[
    //     new Column(
    //       mainAxisAlignment: MainAxisAlignment.start,
    //       crossAxisAlignment: CrossAxisAlignment.start,
    //       children: <Widget>[
    //         new Image.network(
    //           'https://raw.githubusercontent.com/flutter/website/master/_includes/code/layout/lakes/images/lake.jpg',
    //         ),
    //         new Padding(
    //           padding:
    //               const EdgeInsets.only(left: 10.0, right: 10.0, top: 12.0),
    //           child: new Row(
    //             crossAxisAlignment: CrossAxisAlignment.start,
    //             children: <Widget>[
    //               //Column with the event title and address
    //               new Expanded(
    //                 child: new Column(
    //                   mainAxisAlignment: MainAxisAlignment.start,
    //                   crossAxisAlignment: CrossAxisAlignment.start,
    //                   children: <Widget>[
    //                     new Text(
    //                       eventDocumentSnapshot.data()["name"],
    //                       style: new TextStyle(
    //                           fontSize: 30.0, fontWeight: FontWeight.bold),
    //                     ),
    //                     widget._address == null
    //                         ? new Text("Loading address...")
    //                         : new Text(widget._address)
    //                   ],
    //                 ),
    //               ),
    //               //Entry QR Code
    //               fullScreenQR
    //                   ? new Container()
    //                   : new InkWell(
    //                       onTap: () {
    //                         this.setState(() => fullScreenQR = !fullScreenQR);
    //                       },
    //                       child: _qrReady
    //                           ? new QrImage(
    //                               data: _qrEntryCode,
    //                               version: 5,
    //                               foregroundColor: AppColours.primaryCharcoal,
    //                               size: MediaQuery.of(context).size.width / 2.5,
    //                             )
    //                           : new Text("Loading entry QR code..."),
    //                     ),
    //             ],
    //           ),
    //         ),
    //         new Padding(
    //           padding: const EdgeInsets.all(10.0),
    //           child: new Text(
    //             eventDocumentSnapshot.data()["description"],
    //             textAlign: TextAlign.justify,
    //           ),
    //         ),
    //       ],
    //     ),

    //     // If set to display a full screen QR Code, the QR code goes full screen
    //     fullScreenQR
    //         ? new InkWell(
    //             splashColor: AppColours.tick,
    //             onTap: () => this.setState(() => fullScreenQR = !fullScreenQR),
    //             child: new Container(
    //               color: Colors.white.withOpacity(1.0),
    //               alignment: Alignment.center,
    //               child: new QrImage(
    //                 data: _qrEntryCode,
    //                 version: 5,
    //                 foregroundColor: Colors.black,
    //                 size: MediaQuery.of(context).size.width,
    //                 padding: new EdgeInsets.all(30.0),
    //               ),
    //             ),
    //           )
    //         : new Container(),
    //   ],
    // );
  }
}

class DetailsPage extends StatefulWidget {
  const DetailsPage({Key key, this.event, this.address}) : super(key: key);
  final DocumentSnapshot event;

  @override
  _DetailsPageState createState() => _DetailsPageState();
  final String address;
}

class _DetailsPageState extends State<DetailsPage>
    with SingleTickerProviderStateMixin {
  bool fullScreenQR = false;
  bool _qrReady = false;
  String _qrEntryCode = "null";
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: Stack(
        children: <Widget>[
          new Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              new Image.network(
                'https://raw.githubusercontent.com/flutter/website/master/_includes/code/layout/lakes/images/lake.jpg',
              ),
              new Padding(
                padding:
                    const EdgeInsets.only(left: 10.0, right: 10.0, top: 12.0),
                child: new Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    new Expanded(
                      child: new Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          new Text(
                            widget.event.data()['name'],
                            style: new TextStyle(
                                fontSize: 30.0, fontWeight: FontWeight.bold),
                          ),
                          widget.address == null
                              ? new Text("Loading address...")
                              : new Text(widget.address)
                        ],
                      ),
                    ),
                    fullScreenQR
                        ? new Container()
                        : new InkWell(
                            onTap: () {
                              this.setState(() => fullScreenQR = !fullScreenQR);
                            },
                            child: _qrReady
                                ? new QrImage(
                                    data: _qrEntryCode,
                                    version: 5,
                                    foregroundColor: AppColours.primaryCharcoal,
                                    size:
                                        MediaQuery.of(context).size.width / 2.5,
                                  )
                                : new Text("Loading entry QR code..."),
                          ),
                  ],
                ),
              ),
              new Padding(
                padding: const EdgeInsets.all(10.0),
                child: new Text(
                  widget.event.data()['description'],
                  textAlign: TextAlign.justify,
                ),
              ),
            ],
          ),
          fullScreenQR
              ? new InkWell(
                  splashColor: AppColours.tick,
                  onTap: () =>
                      this.setState(() => fullScreenQR = !fullScreenQR),
                  child: new Container(
                    color: Colors.white.withOpacity(1.0),
                    alignment: Alignment.center,
                    child: new QrImage(
                      data: _qrEntryCode,
                      version: 5,
                      foregroundColor: Colors.black,
                      size: MediaQuery.of(context).size.width,
                      padding: new EdgeInsets.all(30.0),
                    ),
                  ),
                )
              : new Container(),
        ],
      ),
    );
  }
}
