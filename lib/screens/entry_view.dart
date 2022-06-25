import 'package:flutter/material.dart';
import 'package:jarlist/alll_entry.dart';
import 'package:provider/provider.dart';

class EntryView extends StatefulWidget {
  static const String routeName = '/entryView';

  @override
  State<EntryView> createState() => _EntryViewState();
}

class _EntryViewState extends State<EntryView> {
  @override
  Widget build(BuildContext context) {
    AllEntries placeList = Provider.of<AllEntries>(context);

    return Scaffold(
      body: Text(placeList.getAllPlaces()[0].name),
    );
  }
}
