import 'package:flutter/material.dart';
import 'package:jarlist/alll_entry.dart';
import 'package:jarlist/models/place.dart';
import 'package:jarlist/size_config.dart';

class ListScreenWidget extends StatefulWidget {

  @override
  State<ListScreenWidget> createState() => _ListScreenWidgetState();
}

class _ListScreenWidgetState extends State<ListScreenWidget>
    with AutomaticKeepAliveClientMixin<ListScreenWidget> {




  //
  // List<String> items = List.generate(
  //   50,
  //   (i) => "List $i",
  // );
  bool value = false;

  List<bool> _isChecked = List.generate(
    50,
    (i) => false,
  );

  @override
  void initState() {
    super.initState();

    //stores checkList state in a list of booleans to be referenced with _isChecked[i]
    //without this everytime the checkbox is toggled, the whole list is toggled
    _isChecked = List<bool>.filled(placeList.length, false);
    print(placeList.length);
  }
  List<Place> placeList = [];


  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Expanded(
      child: SingleChildScrollView(
        child: ListView.builder(
          physics: const BouncingScrollPhysics(),
          shrinkWrap: true,
          scrollDirection: Axis.vertical,
          itemBuilder: (cxt, i) {
            return ListTile(
              title: Row(children: [
                Checkbox(
                  //CHECKBOX
                  value: _isChecked[i], //references _isChecked for value of checkbox
                  onChanged: (bool? newValue) {
                    setState(() {
                      _isChecked[i] = newValue!;
                    });
                  },
                ),
                Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                      side: const BorderSide(
                        color: Colors.blueGrey,
                        width: 0.2,
                      ),
                    ),
                    child: InkWell(
                      splashColor: Colors.blue.withAlpha(30),
                      onTap: () {
                        /*TODO: create route*/
                        debugPrint('Tapped');
                      },
                      child: SizedBox(
                        //dimensions that scale with screen size
                        width: SizeConfig.blockSizeHorizontal * 70,
                        height: SizeConfig.blockSizeVertical * 15,
                        child: Column(
                          children: [
                            Container(
                              //TITLE

                              margin: const EdgeInsets.only(top: 10, left: 15),
                              child: Align(
                                  alignment: Alignment.topLeft,
                                  child: Text(placeList[i].name)),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Container(
                                  //ADDRESS

                                  margin:
                                      const EdgeInsets.only(top: 10, left: 15),
                                  child: Align(
                                      alignment: Alignment.topLeft,
                                      child: Text(placeList[i].address)),
                                ),
                                const Spacer(),
                                Container(
                                  //DATE
                                margin:
                                      const EdgeInsets.only(top: 10, right: 15),
                                  child: Align(
                                      alignment: Alignment.topLeft,
                                      child: Text("Entry Date: \n" + placeList[i].name)),
                                )
                              ],
                            ),
                            Row(
                              //ROW FOR TAGS
                              children: [
                                Container(
                                  margin: const EdgeInsets.only(top: 5, left: 10),
                                  child: Card(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(9),
                                        side: const BorderSide(
                                          color: Colors.blueGrey,
                                          width: 0.5,
                                        ),
                                      ),
                                      child: SizedBox(
                                        width: SizeConfig.blockSizeHorizontal * 20,
                                        height: SizeConfig.blockSizeVertical * 3,
                                        child: Center(child: Text(placeList[i].name)),
                                      )),
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                    )),
              ]),
            );
          },
          //limits the number of items to display to prevent overflow
          itemCount: placeList.length,
        ),
      ),
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
