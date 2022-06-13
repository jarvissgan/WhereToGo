import 'package:flutter/material.dart';

class ListScreenHeader extends StatefulWidget {

  @override
  State<ListScreenHeader> createState() => _ListScreenHeaderState();
}

class _ListScreenHeaderState extends State<ListScreenHeader> {
  String _dropDownValue = 'Entry date';

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Align(
          //button to expand/compact list
          alignment: Alignment.centerLeft,
          child: Container(
            margin: const EdgeInsets.only(top: 15, left: 30),
            child: TextButton.icon(
              icon: const Icon(Icons.format_list_bulleted),
              label: const Text('Detailed'),
              onPressed: () {
                //TODO: expand/compact list
              },
            ),
          ),
        ),
        Align(
          //drop down list for sorting
          alignment: Alignment.centerRight,
          child: Container(
            margin: const EdgeInsets.only(top: 15, right: 30),
            child: DropdownButton<String>(
              value: _dropDownValue,
              icon: const Icon(Icons.arrow_drop_down),
              onChanged: (String? newValue) {
                setState(() {
                  //TODO: implement all sorts
                  _dropDownValue = newValue!;
                });
              },
              items: ['Entry date', 'Alphabetical', 'Unchecked']
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
        ),
          ),
        ),
      ],
    );
  }
}
