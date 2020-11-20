import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tukio/bloc/navigation_bloc/navigation_bloc.dart';

class Menu extends StatelessWidget {
  final Animation<Offset> slideAnimation;
  final Animation<double> menuAnimation;
  final int selectedIndex;
  final Function onMenuItemClicked;

  const Menu(
      {Key key,
      this.slideAnimation,
      this.menuAnimation,
      this.selectedIndex,
      this.onMenuItemClicked})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: slideAnimation,
      child: ScaleTransition(
        scale: menuAnimation,
        child: Padding(
          padding: const EdgeInsets.only(left: 16.0),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                GestureDetector(
                  onTap: () {
                    BlocProvider.of<NavigationBloc>(context)
                        .add(NavigationEvents.DashboardClickedEvent);
                    onMenuItemClicked();
                  },
                  child: Row(
                    children: <Widget>[
                      Icon(
                        Icons.dashboard_rounded,
                        color: Colors.deepPurple[900],
                        size: 30.0,
                      ),
                      Text("Dashboard",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                            fontWeight: selectedIndex == 0
                                ? FontWeight.w900
                                : FontWeight.normal,
                          )),
                    ],
                  ),
                ),
                SizedBox(height: 30),
                GestureDetector(
                  onTap: () {
                    BlocProvider.of<NavigationBloc>(context)
                        .add(NavigationEvents.OptionsClickedEvent);
                    onMenuItemClicked();
                  },
                  child: Row(
                    children: <Widget>[
                      Icon(
                        Icons.create_rounded,
                        color: Colors.purple[600],
                        size: 30.0,
                      ),
                      Text("Options",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                            fontWeight: selectedIndex == 1
                                ? FontWeight.w900
                                : FontWeight.normal,
                          )),
                    ],
                  ),
                ),
                SizedBox(height: 30),
                GestureDetector(
                  onTap: () {
                    BlocProvider.of<NavigationBloc>(context)
                        .add(NavigationEvents.CheckInClickedEvent);
                    onMenuItemClicked();
                  },
                  child: Row(
                    children: <Widget>[
                      Icon(
                        Icons.check_box_rounded,
                        color: Colors.deepOrange,
                        size: 30.0,
                      ),
                      Text("Check In",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                            fontWeight: selectedIndex == 2
                                ? FontWeight.w900
                                : FontWeight.normal,
                          )),
                    ],
                  ),
                ),
                SizedBox(height: 30),
                GestureDetector(
                  onTap: () {
                    BlocProvider.of<NavigationBloc>(context)
                        .add(NavigationEvents.CheckOutClickedEvent);
                    onMenuItemClicked();
                  },
                  child: Row(
                    children: <Widget>[
                      Icon(
                        Icons.check_box_outline_blank_outlined,
                        color: Colors.pink[700],
                        size: 30.0,
                      ),
                      Text("Check Out",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                            fontWeight: selectedIndex == 3
                                ? FontWeight.w900
                                : FontWeight.normal,
                          )),
                    ],
                  ),
                ),
                SizedBox(height: 30),
                GestureDetector(
                  onTap: () {
                    BlocProvider.of<NavigationBloc>(context)
                        .add(NavigationEvents.SettingsClickedEvent);
                    onMenuItemClicked();
                  },
                  child: Row(children: <Widget>[
                    Icon(
                      Icons.settings_outlined,
                      color: Colors.pink[400],
                      size: 30.0,
                    ),
                    Text("Settings",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: selectedIndex == 4
                              ? FontWeight.w900
                              : FontWeight.normal,
                        )),
                  ]),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
