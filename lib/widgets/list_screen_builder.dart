import 'package:flutter/material.dart';
import 'package:jarlist/alll_entry.dart';
import 'package:jarlist/models/place.dart';
import 'package:jarlist/size_config.dart';
import 'package:provider/provider.dart';

class ListScreenWidget extends StatefulWidget {
  @override
  State<ListScreenWidget> createState() => _ListScreenWidgetState();
}

class _ListScreenWidgetState extends State<ListScreenWidget>
    with AutomaticKeepAliveClientMixin<ListScreenWidget> {

  bool value = false;

  List<bool> _isChecked = List.generate(
    50,
    (i) => false,
  );
  List<Place> placeList = [];



  @override
  Widget build(BuildContext context) {
    //TODO: rename Entry() to AllPlaces()
    Entry placeList = Provider.of<Entry>(context);
    @override
    void initState() {
      super.initState();
      //stores checkList state in a list of booleans to be referenced with _isChecked[i]
      //without this everytime the checkbox is toggled, the whole list is toggled
      _isChecked = List<bool>.filled(placeList.getMyPlaces().length, false);
      print(placeList.getMyPlaces().length);
    }
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
                        height: SizeConfig.blockSizeVertical * 17,
                        child: Column(
                          children: [
                            Container(
                              //TITLE

                              margin: const EdgeInsets.only(top: 10, left: 15),
                              child: Align(
                                  alignment: Alignment.topLeft,
                                  child: Expanded(child: Text(placeList.getMyPlaces()[i].name))),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [

                                //container in flexible to allow address to wrap
                                Flexible(
                                  child: Container(
                                    //ADDRESS

                                    margin:
                                        const EdgeInsets.only(top: 10, left: 15, right: 15),
                                    child: Align(
                                        alignment: Alignment.topLeft,
                                        child: Text(placeList.getMyPlaces()[i].address, overflow: TextOverflow.clip,)),
                                  ),
                                ),
                                //TODO: dates
                                // const Spacer(),
                                // Container(
                                //   //DATE
                                // margin:
                                //       const EdgeInsets.only(top: 10, right: 15),
                                //   child: Align(
                                //       alignment: Alignment.topLeft,
                                //       child: Text("Entry Date: \n" + placeList.getMyPlaces()[i].name)),
                                // )
                              ],
                            ),
                            Spacer(),
                            Row(
                              //ROW FOR TAGS
                              //TODO: horizontal listview for tags
                              children: [
                                Container(
                                  margin: const EdgeInsets.only(top: 10, left: 15),
                                  child: Chip(
                                    label: Text( placeList.getMyPlaces()[i].rating),
                                  )
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
          itemCount: placeList.getMyPlaces().length,
        ),
      ),
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
