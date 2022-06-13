import 'package:flutter/material.dart';

class AddScreen extends StatefulWidget {
  @override
  State<AddScreen> createState() => _AddScreenState();
}

class _AddScreenState extends State<AddScreen> {
  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Row(
        //TODO: complete add screen
        children: [
          TextField(
            // controller: _controller,
            decoration: InputDecoration(
              labelText: 'Search',
              prefixIcon: Icon(Icons.search),
            ),
          ),
        ],
      )
    ]);
  }
}
