import 'package:flutter/material.dart';
import 'package:jarlist/widgets/list_screen_builder.dart';
import 'package:jarlist/widgets/list_screen_header.dart';

class ListScreen extends StatelessWidget {
  static const String routeName = '/entry';


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //TODO: preloading pages to improve performance
      body: Column(children: [ListScreenHeader(), ListScreenWidget()]),
    );
  }
}
