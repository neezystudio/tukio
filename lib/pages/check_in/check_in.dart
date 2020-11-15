import 'package:flutter/material.dart';
import 'package:tukio/bloc/navigation_bloc/navigation_bloc.dart';
import 'package:tukio/pages/screens/scan.dart';

class CheckInPage extends StatelessWidget with NavigationStates {
  final Function onMenuTap;

  const CheckInPage({Key key, this.onMenuTap}) : super(key: key);

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
                onTap: onMenuTap,
              ),
              Text("Check In",
                  style: TextStyle(fontSize: 24, color: Colors.white)),
              Icon(Icons.settings, color: Colors.white),
            ],
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                RaisedButton.icon(
                  color: Colors.red,
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => ScanPage()));
                  },
                  icon: Icon(Icons.select_all),
                  label: Text("Scan"),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
