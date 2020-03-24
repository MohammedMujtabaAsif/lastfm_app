import 'dart:async';
import 'package:last_fm/result.dart';

import 'package:flutter/material.dart';
import 'package:last_fm/api.dart';

class StatsPage extends StatefulWidget {
  final String username;

  const StatsPage({Key key, this.username}) : super(key: key);

  @override
  _StatsPageState createState() => _StatsPageState();
}

class _StatsPageState extends State<StatsPage> {
  var _lastfmApi = new LastFMAPI();

  StreamController<List<Result>> _results;

  @override
  void initState() {
    super.initState();

    _results = StreamController<List<Result>>();
    // _results.add("1");
    _getTopSongs();
  }

  _getTopSongs() async {
    var results = await _lastfmApi.getTopSongsAsList("AssassinOnAcid");
    // _results.add(results);
    // print(results + "end of results");
    print("type:");
    print(results.runtimeType);
    setState(() {
      _results.add(results);
    });
    print("Complete?");
  }

  @override
  void dispose() {
    super.dispose();
    _results.close();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: Text(widget.username),
      ),
      body: StreamBuilder(
          stream: _results.stream,
          builder: (context, snapshot) {
            if (snapshot.hasData == true && snapshot.data.length > 0) {
              return new RefreshIndicator(
                  child: Column(
                    children: <Widget>[
                      Expanded(
                          child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: snapshot.data.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Container(
                              padding: EdgeInsets.fromLTRB(5.0, 10.0, 5.0, 0),
                              child: Text(snapshot.data[index].parent));
                        },
                      ))
                    ],
                  ),
                  onRefresh: () => _getTopSongs());
            } else {
              return new Container(
                  color: Colors.grey,
                  child: Center(
                      child: Text(
                          snapshot.hasData == true && snapshot.data.length == 0
                              ? "No Data"
                              : "Loading")));
            }
          }),
    );
  }
}
