import 'package:flutter/material.dart';
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
    return Container(
      child: Expanded(
        flex: 1,
        child: Column(children: [
          ListView.builder(
              //makes container unscrollable
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemBuilder: (cxt, i) {
                return Align(
                  //todo: reduce padding and increase tap area & increase font size
                  alignment: Alignment.centerLeft,
                  child: ListTile(
                    title: Align(
                        //aligns buttons to left
                        alignment: Alignment.centerLeft,
                        child: Container(
                            child: TextButton(
                                //todo: include onPressed
                                onPressed: () {},
                                child: Text(items[i])),
                            padding: EdgeInsets.only(left: 10))),
                  ),
                );
              },
              //tells the listview how many items to display
              itemCount: 4),
          //adds a create button
          //TODO: route to create list page
          Expanded(
            flex: 0,
            child: Container(
              child: Align(
                alignment: Alignment.centerLeft,
                child: TextButton.icon(
                    onPressed: () {},
                    icon: Icon(Icons.add),
                    label: Text("Create New List")),
              ),
              padding: EdgeInsets.only(left: 30),
            ),
          ),
        ]),
      ),
    );
  }
}
