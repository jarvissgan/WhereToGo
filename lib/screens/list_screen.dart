
import 'package:flutter/material.dart';
import 'package:jarlist/selectedIndex.dart';
import 'package:jarlist/widgets/bottom_navbar.dart';
import 'package:jarlist/widgets/home_widget.dart';

class ListScreen extends StatefulWidget {
  static const String routeName = '/entry';

  @override
  State<ListScreen> createState() => _ListScreenState();
}

class _ListScreenState extends State<ListScreen> {
  int selectedIndex = 0;

  // note: entry = list view but its misleading to call it list_view
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Help'),
      ),
      body: Center(
        child: Text('you fucked up'),
      ),
    );
  }
}
