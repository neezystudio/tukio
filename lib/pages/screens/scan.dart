import 'package:barcode_scan_fix/barcode_scan.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tukio/utils/ticket_status_enum.dart';
import 'package:tukio/widgets/scanned_ticket_card.dart';

class ScanPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new ScanPageState();
  String _eventId;
  ScanPage(this._eventId);
}

class ScanPageState extends State<ScanPage> {
  // TODO: make scanned tickets collection in firestore, but only show messages from current device when scanning (i.e. it will appear the same to the user but there will be a log of all scans)
  List<Map<String, dynamic>> scannedTickets = []; //[Name, Status, Pass]

  ///Validates the ticket with [qrContent] against the database
  ///
  /// The ticket is first checked to verify that it is for the correct event.
  /// It is then confirmed that the user can is registered to attend the current event.
  /// Finally, the program checks that the entry code is valid and that the
  /// guest has not already entered. If not all conditions are satisfied then
  /// an appropriate error message is given.
  void checkTicket(String qrContent) async {
    List<String> qrContentArray = qrContent.split(",");
    if (qrContentArray[0] != widget._eventId) {
      this.setState(() {
        scannedTickets.add({"TicketStatus": TicketStatus.DifferentEvent});
      });
      return;
    }
    FirebaseFirestore.instance
        .doc("events/" + qrContentArray[0] + "/attendees/" + qrContentArray[1])
        .get()
        .then((DocumentSnapshot attendeeSnapshot) {
      if (attendeeSnapshot.data == null) {
        this.setState(() {
          scannedTickets.add({"TicketStatus": TicketStatus.UnknownUser});
        });
        return;
      }
      FirebaseFirestore.instance
          .doc("users/" + qrContentArray[1])
          .get()
          .then((DocumentSnapshot userSnapshot) {
        String name = userSnapshot.data()["FirstName"] +
            " " +
            userSnapshot.data()["LastName"];
        this.setState(() {
          if (qrContentArray[2] == attendeeSnapshot.data()["EntryCode"] &&
              attendeeSnapshot.data()["Entered"] == false) {
            scannedTickets
                .add({"Name": name, "TicketStatus": TicketStatus.Verified});
            FirebaseFirestore.instance
                .doc("events/" +
                    qrContentArray[0] +
                    "/attendees/" +
                    qrContentArray[1])
                .update({"Entered": true});
            // ignore: todo
            // TODO: set Entered to true
          } else if (qrContentArray[2] ==
                  attendeeSnapshot.data()["EntryCode"] &&
              attendeeSnapshot.data()["Entered"] == true) {
            scannedTickets.add(
                {"Name": name, "TicketStatus": TicketStatus.AlreadyScanned});
          } else {
            scannedTickets.add(
                {"Name": name, "TicketStatus": TicketStatus.InvalidEntryCode});
          }
        });
      }).catchError((Error error) {
        this.setState(() {
          scannedTickets.add({"TicketStatus": TicketStatus.UnknownUser});
        });
        print(error);
      });
    }).catchError((Error error) {
      print("Catching error...");
      this.setState(() {
        scannedTickets.add({"TicketStatus": TicketStatus.UnknownUser});
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(40)),
        color: Colors.white70,
      ),
      padding: const EdgeInsets.only(left: 16, right: 16, top: 48),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            mainAxisSize: MainAxisSize.max,
            children: [
              InkWell(
                child: Icon(Icons.menu, color: Colors.white),
                //onTap: widget.onMenuTap,
              ),
              Text("Check In",
                  style: TextStyle(fontSize: 24, color: Colors.white)),
              Icon(Icons.settings, color: Colors.white),
            ],
          ),
          new MaterialButton(
            onPressed: scan,
            child: new Text(
              "Scan Ticket",
              style: new TextStyle(fontSize: 30.0),
            ),
            padding: const EdgeInsets.all(9.0),
          ),
          new Expanded(
            child: new ListView.builder(
                itemCount: scannedTickets.length,
                itemBuilder: (BuildContext context, int index) {
                  index = scannedTickets.length - index - 1;
                  return new ScannedTicketCard(scannedTickets[index]);
                }),
          )
        ],
      ),
    );
  }

  Future scan() async {
    try {
      String barcode = await BarcodeScanner.scan();
      checkTicket(barcode);
    } on PlatformException catch (e) {
      if (e.code == BarcodeScanner.CameraAccessDenied) {
        setState(() {
          this
              .scannedTickets
              .add({"TicketStatus": TicketStatus.UnableToAccessCamera});
        });
      } else {
        setState(() => this
            .scannedTickets
            .add({"TicketStatus": TicketStatus.ScanFailed, "ErrorMessage": e}));
      }
    } on FormatException {
      setState(() =>
          this.scannedTickets.add({"TicketStatus": TicketStatus.ExitedScan}));
    } catch (e) {
      setState(() => this
          .scannedTickets
          .add({"TicketStatus": TicketStatus.ScanFailed, "ErrorMessage": e}));
    }
  }
}
