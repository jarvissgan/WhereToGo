import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:jarlist/all_entries.dart';
import 'package:jarlist/all_list.dart';
import 'package:jarlist/all_tags.dart';
import 'package:jarlist/models/list.dart';
import 'package:jarlist/models/place.dart';
import 'package:jarlist/services/firestore_service.dart';
import 'package:jarlist/size_config.dart';
import 'package:provider/provider.dart';

class ListScreenWidget extends StatefulWidget {
  @override
  State<ListScreenWidget> createState() => _ListScreenWidgetState();
}

String buttonName = 'Detailed';
bool buttonState = false; //false == detailed, true == compact
String _dropDownListValue = 'All Entries';

class _ListScreenWidgetState extends State<ListScreenWidget>
    with AutomaticKeepAliveClientMixin<ListScreenWidget> {
  bool value = false;
  String _dropDownValue = 'Entry date';
  String listName = '';

  //TODO: make this dynamic

  List<Place> placeList = [];
  String selectedListName = 'All Entries';
  List selectedList = [];

  // List changeLists() = [];

  @override
  Widget build(BuildContext context) {
    //TODO: rename Entry() to AllPlaces()
    // AllEntries placeList = Provider.of<AllEntries>(context);
    // AllLists listList = Provider.of<AllLists>(context);

    @override
    void initState() {
      super.initState();
      //stores checkList state in a list of booleans to be referenced with _isChecked[i]
      //without this everytime the checkbox is toggled, the whole list is toggled
      // _isChecked = List<bool>.filled(placeList.getAllPlaces().length, false);
      // print(placeList.getAllPlaces().length);
    }

    Future<Stream<List<Place>>> _getPlaces() async {
      return FirestoreService().getPlaces();
    }

    super.build(context);
    FirestoreService fsService = FirestoreService();
    return FutureBuilder(
        future: _getPlaces(),
        builder: (context, snapshot) {
          return StreamBuilder<List<Lists>>(
              stream: fsService.getLists(),
              builder: (context, snapshot1) {
                return StreamBuilder<List<Place>>(
                    stream: fsService.getPlaces(),
                    builder: (context, snapshot) {
                      // print(snapshot.data?[0].id);

                      List<dynamic> changeLists() {
                        if (snapshot.data != null) {
                          if (selectedListName == 'All Entries') {
                            return snapshot.data!;
                          } else {
                            return snapshot.data!.where((element) {
                              return element.listName == selectedListName;
                            }).toList();
                          }
                        } else {
                          return ['No data'];
                        }
                      }

                      List<String>? dropDownList = [];
                      for (var list in snapshot1.data ?? []) {
                        dropDownList.add(list.listName);
                      }
                      dropDownList.insert(0, 'All Entries');

                      // print(dropDownList.length);
                      if (dropDownList.length == 1) {
                        _dropDownListValue = 'All Entries';
                      }
                      print(snapshot.data);

                      if (snapshot.data != null) {
                        return snapshot.connectionState ==
                                ConnectionState.waiting
                            ? const Center(child: CircularProgressIndicator())
                            : Column(children: [
                                Container(
                                  margin: EdgeInsets.only(
                                      top: 10, left: 30, right: 30),
                                  child: DropdownButtonFormField<String>(
                                    value: _dropDownListValue,
                                    hint: Text('Select a list to view'),
                                    items:
                                        dropDownList.map((String dropdownItem) {
                                      return DropdownMenuItem<String>(
                                        value: dropdownItem,
                                        child: Text(dropdownItem),
                                      );
                                    }).toList(),
                                    onChanged: (value) {
                                      setState(() {
                                        //checks if value is 'All Entries'
                                        selectedListName = value!;
                                        // changeList();
                                        changeLists();
                                      });
                                    },
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    //dropdown box containing lists from AllLists class
                                    Align(
                                      //button to expand/compact list
                                      alignment: Alignment.centerLeft,
                                      child: Container(
                                        margin: const EdgeInsets.only(
                                            top: 15, left: 30),
                                        child: TextButton.icon(
                                          icon: const Icon(
                                              Icons.format_list_bulleted),
                                          label: Text(buttonName),
                                          onPressed: () {
                                            setState(() {
                                              if (buttonName != 'Compact') {
                                                buttonState = true;
                                                buttonName = 'Compact';
                                                //change button icon to compact onTap

                                              } else {
                                                buttonState = false;
                                                buttonName = 'Detailed';
                                              }
                                            });
                                            //TODO: expand/compact list
                                          },
                                        ),
                                      ),
                                    ),
                                    Align(
                                      //drop down list for sorting
                                      alignment: Alignment.centerRight,
                                      child: Container(
                                        margin: const EdgeInsets.only(
                                            top: 15, right: 30),
                                        child: DropdownButton<String>(
                                          value: _dropDownValue,
                                          icon:
                                              const Icon(Icons.arrow_drop_down),
                                          onChanged: (value) {
                                            setState(() {
                                              _dropDownValue = value!;

                                              if (value == 'Entry date') {
                                                // placeList.sortByDate();
                                                snapshot.data!.sort((a, b) => a
                                                    .entryDate
                                                    .compareTo(b.entryDate));
                                              } else {
                                                // placeList.sortByName();
                                                snapshot.data!.sort((a, b) =>
                                                    a.name.compareTo(b.name));
                                              }
                                            });
                                          },
                                          items: [
                                            'Entry date',
                                            'Alphabetical',
                                            'Unchecked'
                                          ].map<DropdownMenuItem<String>>(
                                              (String value) {
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
                                Expanded(
                                  key: Key('expanded'),
                                  child: SingleChildScrollView(
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
                                              print(changeLists()[i].name);
                                              fsService
                                                  .removeEntryWithDocumentID(
                                                      changeLists()[i].id);
                                            });
                                          },
                                          child: ListTile(
                                            title: Row(children: [
                                              if (buttonState)
                                                Checkbox(
                                                  //CHECKBOX
                                                  value: snapshot
                                                      .data![i].checkState,
                                                  //references _isChecked for value of checkbox
                                                  onChanged: (bool? newValue) {
                                                    setState(() {
                                                      fsService
                                                          .changeCheckState(
                                                              snapshot
                                                                  .data![i].id,
                                                              newValue);
                                                    });
                                                  },
                                                ),
                                              if (buttonState)
                                                Card(
                                                    shape:
                                                        RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                      side: const BorderSide(
                                                        color: Colors.blueGrey,
                                                        width: 0.2,
                                                      ),
                                                    ),
                                                    child: InkWell(
                                                      splashColor: Colors.blue
                                                          .withAlpha(30),
                                                      onTap: () {
                                                        Navigator.of(context)
                                                            .pushNamed(
                                                                '/entryView',
                                                                arguments: {
                                                              'listName':
                                                                  changeLists()[
                                                                          i]
                                                                      .listName,
                                                              'name':
                                                                  changeLists()[
                                                                          i]
                                                                      .name,
                                                              'address':
                                                                  changeLists()[
                                                                          i]
                                                                      .address,
                                                              'phone':
                                                                  changeLists()[
                                                                          i]
                                                                      .phone,
                                                              'website':
                                                                  changeLists()[
                                                                          i]
                                                                      .website,
                                                              'entry':
                                                                  changeLists()[
                                                                          i]
                                                                      .entryDate,
                                                              'openingHours':
                                                                  changeLists()[
                                                                          i]
                                                                      .openingHours,
                                                              'rating':
                                                                  changeLists()[
                                                                          i]
                                                                      .rating,
                                                              'tagList':
                                                                  changeLists()[
                                                                          i]
                                                                      .tagList,
                                                              'restaurantNotes':
                                                                  changeLists()[
                                                                          i]
                                                                      .restaurantNotes,
                                                              'photoReferences':
                                                                  changeLists()[
                                                                          i]
                                                                      .photoReferences,
                                                            });
                                                      },
                                                      child: SizedBox(
                                                        //dimensions that scale with screen size
                                                        width: SizeConfig
                                                                .blockSizeHorizontal *
                                                            70,
                                                        height: SizeConfig
                                                                .blockSizeVertical *
                                                            17,
                                                        child: Column(
                                                          children: [
                                                            Container(
                                                              //TITLE

                                                              margin:
                                                                  const EdgeInsets
                                                                          .only(
                                                                      top: 10,
                                                                      left: 15),
                                                              child: Align(
                                                                  alignment:
                                                                      Alignment
                                                                          .topLeft,
                                                                  child: Text(
                                                                      changeLists()[
                                                                              i]
                                                                          .name)),
                                                            ),
                                                            Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .spaceEvenly,
                                                              children: [
                                                                //container in flexible to allow address to wrap
                                                                Flexible(
                                                                  child:
                                                                      Container(
                                                                    //ADDRESS

                                                                    margin: const EdgeInsets
                                                                            .only(
                                                                        top: 10,
                                                                        left:
                                                                            15,
                                                                        right:
                                                                            15),
                                                                    child: Align(
                                                                        alignment: Alignment.topLeft,
                                                                        child: Text(
                                                                          changeLists()[i]
                                                                              .address,
                                                                          overflow:
                                                                              TextOverflow.clip,
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
                                                            Container(
                                                              margin:
                                                                  const EdgeInsets
                                                                          .only(
                                                                      top: 10,
                                                                      left: 15,
                                                                      right:
                                                                          15),
                                                              child: Wrap(
                                                                direction: Axis
                                                                    .horizontal,
                                                                spacing: SizeConfig
                                                                        .safeBlockHorizontal *
                                                                    2,
                                                                runSpacing:
                                                                    SizeConfig
                                                                            .safeBlockHorizontal *
                                                                        2,
                                                                children: [
                                                                  Row(
                                                                    //ROW FOR TAGS
                                                                    children: [
                                                                      //takes elements from list of tags and creates a chip for each one
                                                                      for (var tag
                                                                          in changeLists()[i]
                                                                              .tagList)
                                                                        Chip(
                                                                          //TODO: fix tags getting overwritten by new entry
                                                                          label:
                                                                              Text(tag['name'] as String),
                                                                          //TODO: colors for tags
                                                                        ),
                                                                    ],
                                                                  )
                                                                ],
                                                              ),
                                                            )
                                                          ],
                                                        ),
                                                      ),
                                                    )),
                                              if (!buttonState)
                                                Checkbox(
                                                  //CHECKBOX
                                                  value: snapshot
                                                      .data![i].checkState,
                                                  //references _isChecked for value of checkbox
                                                  onChanged: (bool? newValue) {
                                                    setState(() {
                                                      // _isChecked[i] = newValue!;
                                                      fsService
                                                          .changeCheckState(
                                                              snapshot
                                                                  .data![i].id,
                                                              newValue);
                                                    });
                                                  },
                                                ),
                                              //if button = expanded
                                              if (!buttonState)
                                                Card(
                                                    shape:
                                                        RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                      side: const BorderSide(
                                                        color: Colors.blueGrey,
                                                        width: 0.2,
                                                      ),
                                                    ),
                                                    child: InkWell(
                                                      splashColor: Colors.blue
                                                          .withAlpha(30),
                                                      onTap: () {
                                                        /*TODO: create route*/
                                                        debugPrint('Tapped');
                                                        Navigator.of(context)
                                                            .pushNamed(
                                                                '/entryView',
                                                                arguments: {
                                                              'id':
                                                                  changeLists()[
                                                                          i]
                                                                      .id,
                                                              'listName':
                                                                  changeLists()[
                                                                          i]
                                                                      .listName,
                                                              'name':
                                                                  changeLists()[
                                                                          i]
                                                                      .name,
                                                              'address':
                                                                  changeLists()[
                                                                          i]
                                                                      .address,
                                                              'phone':
                                                                  changeLists()[
                                                                          i]
                                                                      .phone,
                                                              'website':
                                                                  changeLists()[
                                                                          i]
                                                                      .website,
                                                              'entryDate':
                                                                  changeLists()[
                                                                          i]
                                                                      .entryDate,
                                                              'openingHours':
                                                                  changeLists()[
                                                                          i]
                                                                      .openingHours,
                                                              'rating':
                                                                  changeLists()[
                                                                          i]
                                                                      .rating,
                                                              'tagList':
                                                                  changeLists()[
                                                                          i]
                                                                      .tagList,
                                                              'restaurantNotes':
                                                                  changeLists()[
                                                                          i]
                                                                      .restaurantNotes,
                                                              'photoReferences':
                                                                  changeLists()[
                                                                          i]
                                                                      .photoReferences,
                                                            });
                                                      },
                                                      child: SizedBox(
                                                        //dimensions that scale with screen size
                                                        width: SizeConfig
                                                                .blockSizeHorizontal *
                                                            70,
                                                        height: SizeConfig
                                                                .blockSizeVertical *
                                                            7,
                                                        child: Column(
                                                          children: [
                                                            Container(
                                                              //TITLE
                                                              margin:
                                                                  const EdgeInsets
                                                                          .only(
                                                                      top: 10,
                                                                      left: 15),
                                                              child: Align(
                                                                  alignment:
                                                                      Alignment
                                                                          .topLeft,
                                                                  child: Wrap(
                                                                    direction: Axis
                                                                        .horizontal,
                                                                    spacing:
                                                                        SizeConfig.safeBlockHorizontal *
                                                                            2,
                                                                    runSpacing:
                                                                        SizeConfig.safeBlockHorizontal *
                                                                            2,
                                                                    children: [
                                                                      Container(
                                                                        margin: const EdgeInsets.only(
                                                                            left:
                                                                                5,
                                                                            right:
                                                                                5),
                                                                        child:
                                                                            Row(
                                                                          mainAxisAlignment:
                                                                              MainAxisAlignment.spaceBetween,
                                                                          children: [
                                                                            Text(changeLists()[i].name),
                                                                            Text(changeLists()[i].entryDate),
                                                                          ],
                                                                        ),
                                                                      )
                                                                    ],
                                                                  )),
                                                            ),
                                                            const Spacer(),
                                                          ],
                                                        ),
                                                      ),
                                                    )),
                                            ]),
                                          ),
                                        );
                                      },
                                      //limits the number of items to display to prevent overflow
                                      itemCount: changeLists().length,
                                    ),
                                  ),
                                ),
                              ]);
                      } else {
                        return Center(
                          child: Text('No entries yet'),
                        );
                      }
                    });
              });
        });
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => false;
}
