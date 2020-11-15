import 'package:flutter/material.dart';
import 'package:tukio/bloc/navigation_bloc/navigation_bloc.dart';
import 'package:tukio/pages/event_tabs/create.dart';
import 'package:tukio/pages/event_tabs/portfolio_tutorials_sub_page.dart';
import 'package:tukio/pages/event_tabs/share_event.dart';
import 'package:tuple/tuple.dart';

class OptionsPage extends StatefulWidget with NavigationStates {
  final Function onMenuTap;
  const OptionsPage({
    Key key,
    this.onMenuTap,
  }) : super(key: key);

  @override
  _OptionsPageState createState() => _OptionsPageState();
}

class _OptionsPageState extends State<OptionsPage>
    with SingleTickerProviderStateMixin {
  final List<Tuple2> _pages = [
    Tuple2('NewEvent', CreatePage()),
    Tuple2('ShareEvent', ShareEvent()),
  ];

  TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: _pages.length, vsync: this);
    _tabController.addListener(() => setState(() {}));
  }

  //release the animation controller that was actually disposes one the UI IS REBULD
  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /*appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: InkWell(
          onTap: widget.onMenuTap,
          child: Icon(Icons.menu, color: Colors.black),
        ),
        title: Text(_pages[_tabController.index].item1),
        bottom: TabBar(
          controller: _tabController,
          tabs:
              _pages.map<Tab>((Tuple2 page) => Tab(text: page.item1)).toList(),
        ),
      ),*/
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxisScrolled) {
          return <Widget>[
            OptionsSliverAppBar(
                _tabController, _pages[_tabController.index].item1),
          ];
        },
        body: TabBarView(
          controller: _tabController,
          children: _pages.map<Widget>((Tuple2 page) => page.item2).toList(),
        ),
      ),
    );
  }
}
