import 'package:flutter/material.dart';
import 'package:jarlist/all_places.dart';
import 'package:jarlist/alll_entry.dart';
import 'package:provider/provider.dart';

class ListScreenHeader extends StatefulWidget {
  @override
  State<ListScreenHeader> createState() => _ListScreenHeaderState();
}

class _ListScreenHeaderState extends State<ListScreenHeader> {
  String _dropDownValue = 'Entry date';
  String listName = '';
  String selectedList = '';


  @override
  Widget build(BuildContext context) {
    AllLists listList = Provider.of<AllLists>(context);
    //adds element 'add' to dropDownList
    List<String> dropDownList = listList.getNamesAsList();
    dropDownList.insert(0, 'All Entries');

    return Column(
      children: [
        Container(
          margin: EdgeInsets.only(top: 10, left: 30, right: 30),
          child: DropdownButtonFormField<String>(
            value: 'All Entries',
            hint: Text('Select a list to view'),
            items: dropDownList.map((String dropdownItem) {
              return DropdownMenuItem<String>(
                value: dropdownItem,
                child: Text(dropdownItem),
              );
            }).toList(),
            onChanged: (value) {
              setState(() {
                //checks if value is 'All Entries'
                if (value == 'All Entries') {
                  selectedList = '';
                } else {
                  selectedList = value!;
                }
                selectedList = value!;
              });
            },
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            //dropdown box containing lists from AllLists class
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
                  onChanged: (value) {
                    setState(() {
                      //TODO: implement all sorts
                      _dropDownValue = value!;
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
        ),
      ],
    );
  }
}
