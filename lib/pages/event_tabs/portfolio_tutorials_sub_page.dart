import 'package:flutter/material.dart';
import 'package:tukio/pages/menu_dashboard_layout/menu_dashboard_layout.dart';

class OptionsSliverAppBar extends StatelessWidget {
  final String _title;
  final TabController _tabController;

  const OptionsSliverAppBar(
    this._tabController,
    this._title, {
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      iconTheme: IconThemeData(
        color: Colors.black,
      ),
      backgroundColor: Colors.red,
      expandedHeight: 200,
      pinned: true,
      floating: true,
      automaticallyImplyLeading: false,
      title: Row(
        children: [
          IconButton(
            icon: Icon(
              Icons.arrow_back_ios,
            ),
            tooltip: 'Go back to Menu',
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => MenuDashboardLayout()),
              );
            },
          ),
          Text(
            _title,
            style: TextStyle(color: Colors.black),
          ),
        ],
      ),
      flexibleSpace: FlexibleSpaceBar(
        background: Image.network(
          'https://himdeve.eu/wp-content/uploads/2015/05/himdeve_labrador_with_cute_woman_model.jpg',
          fit: BoxFit.cover,
        ),
      ),
      bottom: TabBar(
        labelColor: Colors.black,
        indicatorColor: Colors.black,
        controller: _tabController,
        tabs: <Widget>[
          Tab(
            text: 'NewEvent',
          ),
          Tab(text: 'ShareEvent')
        ],
      ),
    );
  }
}
