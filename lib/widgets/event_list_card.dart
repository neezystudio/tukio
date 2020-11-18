import 'package:flutter/material.dart';
import 'package:tukio/utils/colors.dart';

class EventCard extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new EventCardController();

  String _name;
  String _description;
  String _documentID;

  onTap(BuildContext context) {
    //Navigator.of(context).push(new MaterialPageRoute(builder: (BuildContext context) => new EventPage(_documentID)));
  }

  EventCard(this._name, this._description, this._documentID);
}

class EventCardController extends State<EventCard> {
  @override
  Widget build(BuildContext context) {
    return new InkWell(
        onTap: () => widget.onTap(context),
        child: new Card(
            child: new Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            new ListTile(
              leading: const Icon(
                Icons.check,
                color: AppColours.tick,
              ),
              title: new Text(widget._name),
              subtitle: new Text(widget._description.length < 35
                  ? widget._description
                  : widget._description.substring(0, 30) + "..."),
            ),
          ],
        )));
  }
}
