import 'package:last_fm/result.dart';
import 'package:xml/xml.dart' as xml;

// import 'dart:async';
import 'package:http/http.dart' as http;

class LastFMAPI {
  final String apiKey = "3bf64a1c33bd2ae277221e01cfb33d00";
  String username;
  String apiURL =
      "http://ws.audioscrobbler.com/2.0/?method=user.gettopalbums&user=";
  // "http://ws.audioscrobbler.com/2.0/?method=user.gettopalbums&user=rj&api_key=3bf64a1c33bd2ae277221e01cfb33d00"

  getTopSongsAsList(username) async {
    List<Result> _results = new List<Result>();
    var url = apiURL + username + "&api_key=" + apiKey;
    var res = await http.get(url);
    if (res != null) {
      var decoded = xml.parse(res.body);
      // print(decoded);
      var _names =
          decoded.findAllElements("name").map((node) => node.text).toList();
      var _playCounts = decoded
          .findAllElements("playcount")
          .map((node) => node.text)
          .toList();
      var _imageLinks =
          decoded.findAllElements('image').map((node) => node.text).toList();
      var _urls =
          decoded.findAllElements('url').map((node) => node.text).toList();

      // print(_imageLinks);
      Result r;
      int _namesCounter = 0;
      int _playCountCounter = 0;
      int _imageLinksCounter = 2;
      int _urlCounter = 0;
      while (_namesCounter < _names.length) {
        r = new Result(
            _names[_namesCounter + 1],
            _names[_namesCounter],
            _urls[_urlCounter + 1],
            _urls[_urlCounter],
            _playCounts[_playCountCounter],
            _imageLinks[_imageLinksCounter]);

        _results.add(r);

        _imageLinksCounter += 4;
        _namesCounter += 2;
        _playCountCounter++;
        _urlCounter += 2;
      }
      List<Result> _resultsAsList = _results.toList();
      // print(_resultsAsList.elementAt(3).parent);
      return _resultsAsList;
      // var results = decoded.findAllElements("name");
      // print(results);
      // Result r;
      // for (var element in results) {
      //   r = new Result(name, url, val, image)
      // }
    }
  }
}
