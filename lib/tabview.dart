import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:last_fm/stats.dart';

class TabViewPage extends StatefulWidget {
  _TabViewPageState createState() => _TabViewPageState();
}

class _TabViewPageState extends State<TabViewPage>
    with SingleTickerProviderStateMixin {
  String username = "aqibasif";
  TabController _tabController;
  TextEditingController _textEditingController;

  @override
  void initState() {
    super.initState();
    _tabController = new TabController(length: 3, vsync: this);
    _textEditingController = new TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
        child: SafeArea(
            top: true,
            child: new Scaffold(
              appBar: AppBar(
                elevation: 1,
                title: Text(username),
                bottom: new TabBar(
                  controller: _tabController,
                  tabs: [
                    Tab(icon: Text("Albums")),
                    Tab(icon: Text("Songs")),
                    Tab(icon: Text("Artists")),
                  ],
                ),
              ),
              drawer: Drawer(
                  child: Container(
                      padding: EdgeInsets.only(top: 100),
                      child: Column(
                        children: <Widget>[
                          Text("Enter Your Last.fm Username"),
                          TextFormField(
                            controller: _textEditingController,
                            onChanged: (String value) {
                              username = value;
                            },
                          )
                        ],
                      ))),
              body: TabBarView(controller: _tabController, children: [
                StatsPage(
                  username: this.username,
                  mode: "albums",
                ),
                StatsPage(
                  username: this.username,
                  mode: "songs",
                ),
                StatsPage(
                  username: this.username,
                  mode: "artists",
                )
              ]),
            )));
  }
}
