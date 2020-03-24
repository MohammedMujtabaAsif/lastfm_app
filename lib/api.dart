import 'package:last_fm/result.dart';
import 'package:xml/xml.dart' as xml;

// import 'dart:async';
import 'package:http/http.dart' as http;

class LastFMAPI {
  final String apiKey = "3bf64a1c33bd2ae277221e01cfb33d00";
  String username;
  String apiURL = "http://ws.audioscrobbler.com/2.0/?method=user.";
  // "http://ws.audioscrobbler.com/2.0/?method=user.gettopalbums&user=rj&api_key=3bf64a1c33bd2ae277221e01cfb33d00"

  getTopAlbumsAsList(username) async {
    List<Result> _results = new List<Result>();
    var method = "gettopalbums&user=";
    var url = apiURL + method + username + "&api_key=" + apiKey;
    var res = await http.get(url);
    // print("Albums: " + url);
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
      return _resultsAsList;
    } else {
      print("Albums: null");
    }
  }

  getTopSongsAsList(username) async {
    List<Result> _results = new List<Result>();
    var method = "gettoptracks&user=";
    var url = apiURL + method + username + "&api_key=" + apiKey;
    var res = await http.get(url);
    print("Songs: " + url);
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
      return _resultsAsList;
    } else {
      print("Songs: null");
    }
  }

  getTopArtistsAsList(username) async {
    List<Result> _results = new List<Result>();
    var method = "gettopartists&user=";
    var url = apiURL + method + username + "&api_key=" + apiKey;
    var res = await http.get(url);
    print("Artists: " + url);
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
            _names[_namesCounter],
            _names[_namesCounter],
            _urls[_urlCounter],
            _urls[_urlCounter],
            _playCounts[_playCountCounter],
            _imageLinks[_imageLinksCounter]);

        _results.add(r);

        _imageLinksCounter += 4;
        _namesCounter++;
        _playCountCounter++;
        _urlCounter++;
      }
      List<Result> _resultsAsList = _results.toList();
      return _resultsAsList;
    } else {
      print("Artists: null");
    }
  }
}
