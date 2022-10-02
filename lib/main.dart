import 'package:flutter/material.dart';
import 'package:flutter_study/slivers/listview_page.dart';

import 'future/stream_page.dart';
import 'key/dismissible_page.dart';
import 'key/localkey_page.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: SafeArea(child: ListViewPage()),
      ),
    );
  }
}
