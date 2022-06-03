import 'package:flutter/material.dart';
import 'package:jarlist/size_config.dart';

class RecommendedList extends StatelessWidget {
  List<String> items = List.generate(
    5,
    (i) => "List $i",
  );
// TODO: gather data from database and randomize into array
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Container(
      child: Expanded(
        flex: 1,
        child: Column(children: [
          //aligns text left while also padding it
          Expanded(
            flex:0,
            child: Container(
              child: const Align(
                child: Text('Recommended Lists:',
                    style: TextStyle(
                        fontSize: 15,
                        color: Colors.black,
                        fontWeight: FontWeight.bold)),
                alignment: Alignment.topLeft,
              ),
              padding: const EdgeInsets.only(left: 40),
            ),
          ),
          Expanded(
            flex: 1,
            child: ConstrainedBox(
              constraints: BoxConstraints(
                maxHeight: SizeConfig.blockSizeVertical * 50,
              ),
              child: ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemBuilder: (cxt, i) {
                    return Align(
                      //todo: reduce padding and increase tap area
                      alignment: Alignment.centerLeft,
                      child: ListTile(
                        visualDensity:
                            const VisualDensity(horizontal: -1.0, vertical: -4.0),
                        title: Align(
                            //aligns buttons to left
                            alignment: Alignment.centerLeft,
                            child: Container(
                                child: Text(items[i]),
                                padding: const EdgeInsets.only(left: 25))),
                      ),
                    );
                  },
                  //limits the number of items to display to prevent overflow
                  itemCount: 5),
            ),
          ),
        ]),
      ),
    );
  }
}
