import 'package:flutter/material.dart';
import 'package:jarlist/all_places.dart';
import 'package:jarlist/all_tags.dart';
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
  String _dropDownValue = 'Entry date';
  String listName = '';

  //TODO: make this dynamic
  List<bool> _isChecked = List.generate(
    50,
    (i) => false,
  );
  List<Place> placeList = [];
  String selectedListName = 'All Entries';
  List selectedList = [];
  List selectedTemp = [];


  @override
  Widget build(BuildContext context) {
    //TODO: rename Entry() to AllPlaces()
    AllEntries placeList = Provider.of<AllEntries>(context);
    AllLists listList = Provider.of<AllLists>(context);
    setState(() {

    });
    List<String> dropDownList = listList.getNamesAsList();

    dropDownList.insert(0, 'All Entries');

    void changeList() {
      setState(() {

        List temp = placeList.getAllPlaces();
        selectedTemp = [];
        //checks if placeList.getAllPlaces().listName == selectedListName
        if (selectedListName == 'All Entries') {
          selectedTemp = placeList.getAllPlaces();
        } else {
          selectedTemp = temp.where((element) {
            return element.listName == selectedListName;
          }).toList();
          //for loop to print all names in selectedTemp
        }
        for (int i = 0; i < selectedTemp.length; i++) {
          print(selectedTemp[i].name);
        }
      });
    }

    @override
    void initState() {
      super.initState();
      //stores checkList state in a list of booleans to be referenced with _isChecked[i]
      //without this everytime the checkbox is toggled, the whole list is toggled
      _isChecked = List<bool>.filled(placeList.getAllPlaces().length, false);
      print(placeList.getAllPlaces().length);
    }

    super.build(context);
    return Column(children: [
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
              print('value of list $value');
              //checks if value is 'All Entries'
              selectedListName = value!;
              changeList();
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
      SingleChildScrollView(
        child: ListView.builder(
          physics: const BouncingScrollPhysics(),
          shrinkWrap: true,
          scrollDirection: Axis.vertical,
          itemBuilder: (cxt, i) {
            return Dismissible(
              key: UniqueKey(),
              background: Container(
                color: Colors.red,
                child: Icon(
                  Icons.delete,
                  color: Colors.white,
                ),
              ),
              onDismissed: (direction) {
                setState(() {
                  placeList.removePlace(selectedTemp[i].name);
                });
              },
              child: ListTile(
                title: Row(children: [
                  Checkbox(
                    //CHECKBOX
                    value: _isChecked[i],
                    //references _isChecked for value of checkbox
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
                          Navigator.of(context)
                              .pushNamed('/entryView', arguments: {
                            'listName': selectedTemp[i].listName,
                            'name': selectedTemp[i].name,
                            'address': selectedTemp[i].address,
                            'phone': selectedTemp[i].phone,
                            'website': selectedTemp[i].website,
                            'entry': selectedTemp[i].entryDate,
                            'openingHours': selectedTemp[i].openingHours,
                            'rating': selectedTemp[i].rating,
                            'tagList': selectedTemp[i].tagList,
                            'restaurantNotes': selectedTemp[i].restaurantNotes,
                          });
                        },
                        child: SizedBox(
                          //dimensions that scale with screen size
                          width: SizeConfig.blockSizeHorizontal * 70,
                          height: SizeConfig.blockSizeVertical * 17,
                          child: Column(
                            children: [
                              Container(
                                //TITLE

                                margin:
                                    const EdgeInsets.only(top: 10, left: 15),
                                child: Align(
                                    alignment: Alignment.topLeft,
                                    child: Text(selectedTemp[i].name)),
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  //container in flexible to allow address to wrap
                                  Flexible(
                                    child: Container(
                                      //ADDRESS

                                      margin: const EdgeInsets.only(
                                          top: 10, left: 15, right: 15),
                                      child: Align(
                                          alignment: Alignment.topLeft,
                                          child: Text(
                                            selectedTemp[i].address,
                                            overflow: TextOverflow.clip,
                                          )),
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
                                  //       child: Text("Entry Date: \n" + placeList.getAllPlaces()[i].name)),
                                  // )
                                ],
                              ),
                              const Spacer(),
                              Row(
                                //ROW FOR TAGS
                                children: [
                                  //takes elements from list of tags and creates a chip for each one
                                  for (var tag in selectedTemp[i].tagList)
                                    Chip(
                                      //TODO: fix tags getting overwritten by new entry
                                      label: Text(tag['name'] as String),
                                      //TODO: colors for tags
                                    ),
                                ],
                              )
                            ],
                          ),
                        ),
                      )),
                ]),
              ),
            );
          },
          //limits the number of items to display to prevent overflow
          itemCount: selectedTemp.length,
        ),
      ),
    ]);
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
