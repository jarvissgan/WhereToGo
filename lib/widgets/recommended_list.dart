import 'package:flutter/material.dart';
import 'package:jarlist/widgets/list_screen_builder.dart';
import 'package:jarlist/size_config.dart';

class RecommendedList extends StatefulWidget {
  @override
  State<RecommendedList> createState() => _RecommendedListState();
}

class _RecommendedListState extends State<RecommendedList> {
  List<String> items = List.generate(
    4,
    (i) => "List $i",
  );

// TODO: gather data from database and randomize into array
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Flex(
      direction: Axis.vertical,
      children: [
        Column(children: [
          //aligns text left while also padding it
          Container(
              margin: const EdgeInsets.only(top: 15, bottom: 10),
            child: const Align(
              alignment: Alignment.centerLeft,
              child: Text('Recommended Lists:',
                  style: TextStyle(
                      fontSize: 15,
                      color: Colors.black,
                      fontWeight: FontWeight.bold)),
            ),
            padding: const EdgeInsets.only(left: 40),
          ),
          ConstrainedBox(
            //todo: contrained box that doesn't move when there is a not enough elements in list
            constraints: BoxConstraints(
              maxHeight: SizeConfig.blockSizeVertical * 50,
            ),
            child: ListView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (cxt, i) {
                  return ListTile(
                    visualDensity:
                        const VisualDensity(horizontal: -1.0, vertical: -4.0),
                    title: Container(
                        child: Text(items[i]),
                        padding: const EdgeInsets.only(left: 25)),
                  );
                },
                //limits the number of items to display to prevent overflow
                itemCount: 4),
          ),
          TextButton(
            onPressed: () {}, //TODO: create route
            child: Text('Create New List'),
          ),
        ])
      ],
    );
  }
}
