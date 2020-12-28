import 'package:flutter/material.dart';
//import 'package:tukio/pages/menu_dashboard_layout/menu_dashboard_layout.dart';

class Dashboard extends StatelessWidget {
  final bool isCollapsed;
  final double screenWidth;
  final Duration duration;
  final Function onMenuTap;
  final Animation<double> scaleAnimation;
  final Widget child;

  const Dashboard(
      {Key key,
      this.isCollapsed,
      this.screenWidth,
      this.duration,
      this.onMenuTap,
      this.scaleAnimation,
      this.child})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedPositioned(
      duration: duration,
      top: 0,
      bottom: 0,
      left: isCollapsed ? 0 : 0.6 * screenWidth,
      right: isCollapsed ? 0 : -0.2 * screenWidth,
      child: ScaleTransition(
        scale: scaleAnimation,
        child: Material(
          animationDuration: duration,
          borderRadius: BorderRadius.all(Radius.circular(40)),
          elevation: 8,
          color: Colors.white,
          child: child,
        ),
      ),
    );
  }
}
