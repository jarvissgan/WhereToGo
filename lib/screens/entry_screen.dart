import 'package:flutter/material.dart';

class EntryScreen extends StatelessWidget {
  static String routeName = '/entry';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Entry Screen'),
      ),
      body: Center(
        child: Text('Entry Screen'),
      ),
    );
  }
}
