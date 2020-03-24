import 'dart:async';
import 'package:last_fm/result.dart';

import 'package:flutter/material.dart';
import 'package:last_fm/api.dart';

class StatsPage extends StatefulWidget {
  final String username;
  final String mode;

  const StatsPage({Key key, this.username, this.mode}) : super(key: key);

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
    var results;

    if (widget.mode.contains("albums")) {
      results = await _lastfmApi.getTopAlbumsAsList(widget.username.toString());
    } else if (widget.mode.contains("songs")) {
      results = await _lastfmApi.getTopSongsAsList(widget.username.toString());
    } else if (widget.mode.contains("artists")) {
      results =
          await _lastfmApi.getTopArtistsAsList(widget.username.toString());
    }
    // results = await _lastfmApi.getTopAlbumsAsList(widget.username.toString());
    setState(() {
      _results.add(results);
    });
  }

  @override
  void dispose() {
    super.dispose();
    _results.close();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
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
                                child: Text(snapshot.data[index].child),
                              );
                            }),
                      )
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
                          : "Loading"),
                ),
              );
            }
          }),
    );
  }
}
