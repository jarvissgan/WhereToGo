
import 'package:flutter/material.dart';

class List_ListView extends StatelessWidget {
  //generate list data
  final List<String> items = List.generate(
    10,
    (i) => "Item $i",
  );
  @override
  Widget build(BuildContext context) {
    print(items);
    return Expanded(
      child: ListView(
        children:[
          ListTile(
            title: Text(items[0]),
          ),
        ]

      ),
    );
  }
}
