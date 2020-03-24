import 'package:flutter/material.dart';
import 'package:last_fm/tabview.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Last.FM Stats',
      theme: ThemeData(

        primarySwatch: Colors.red,
      ),
      home: TabViewPage(),
    );
  }
}