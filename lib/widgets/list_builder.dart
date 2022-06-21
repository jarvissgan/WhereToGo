import 'package:flutter/material.dart';
import 'package:jarlist/models/place.dart';
import 'package:jarlist/screens/add_screen.dart';
import 'package:jarlist/size_config.dart';

class ListBuilder extends StatelessWidget {
  //todo: add list data
  List<String> items = List.generate(
    50,
    (i) => "List $i",
  );

  ListBuilder(this.items);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Flex(
      direction: Axis.vertical,
      children: [
        Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Align(
                  alignment: Alignment.centerLeft,
                  child: Container(
                      margin: const EdgeInsets.only(top: 15, left: 40),
                      child: const Text(
                    "Lists:",
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.normal,
                        color: Colors.black),
                  ))),
              ListView.builder(
                  //makes container unscrollable
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemBuilder: (cxt, i) {
                    return ListTile(
                      title: Align(
                          //aligns buttons to left
                          alignment: Alignment.centerLeft,
                          child: Container(
                              margin: const EdgeInsets.only(top: 10, left: 0),
                              child: TextButton(
                                  //todo: include onPressed
                                  onPressed: () {},
                                  child: Text(items[i])),
                              padding: EdgeInsets.only(left: 10))),
                    );
                  },
                  //tells the listview how many items to display
                  itemCount: 4),
              //adds a create button
              //TODO: route to create list page
              Expanded(
                flex: 0,
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Container(
                    margin: const EdgeInsets.only(top: 15, left: 25),
                    child: TextButton.icon(
                        onPressed: () {},
                        icon: Icon(Icons.add),
                        label: Text("Create New List")),
                  ),
                ),
              ),
            ]),
      ],
    );
  }
}
