import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:jarlist/all_entries.dart';
import 'package:jarlist/all_list.dart';
import 'package:jarlist/all_tags.dart';
import 'package:jarlist/models/place.dart';
import 'package:jarlist/services/firestore_service.dart';
import 'package:jarlist/services/location_service.dart';
import 'package:jarlist/size_config.dart';
import 'package:jarlist/widgets/tag_dialog.dart';
import 'package:provider/provider.dart';

class AddScreen extends StatefulWidget {
  @override
  State<AddScreen> createState() => _AddScreenState();
}

String createListName = '';

class _AddScreenState extends State<AddScreen> {
  final _formKey = GlobalKey<FormState>();
  final _formKey2 = GlobalKey<FormState>();
  TextEditingController _searchController = TextEditingController();
  String listName = '';
  String restaurantName = '';
  String restaurantAddress = '';
  String restaurantPhone = '';
  String restaurantWebsite = '';
  String restaurantNotes = '';
  String restaurantRating = '';
  List<dynamic> restaurantTags = [];
  List<String> autocompletePlaces = [];
  List selectedTags = [];
  String tagName = '';
  String tagColor = '';
  List<dynamic> restaurantHours = [];
  List<String> photoReferences = [];
  String restaurantId = '';
  late List<String> autoCompleteData = [];

  void saveListForm(AllLists listList) async {
    bool isValid = _formKey2.currentState!.validate();

    if (isValid) {
      _formKey2.currentState!.save();
      print('YOUIUUU $createListName');
      setState(() {
        listList.addList(
          createListName,
        );
        Navigator.of(context).pop();
        _formKey2.currentState!.reset();
        createListName = '';
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Saved!'),
          duration: Duration(seconds: 1),
        ));
      });
    } else {
      print("invalid");
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Please enter a name for your list'),
        duration: Duration(seconds: 1),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    //TODO: rename AllEntries() to AllPlaces()
    // AllEntries placeList = Provider.of<AllEntries>(context);
    AllTags tagList = Provider.of<AllTags>(context);
    AllLists listList = Provider.of<AllLists>(context);

    List<String> dropDownList = listList.getNamesAsList();
    dropDownList.add('Create a new list');

    void saveForm() async {
      bool isValid = _formKey.currentState!.validate();
      if (isValid) {
        _formKey.currentState!.save();

        FirestoreService fsService = FirestoreService();
        fsService.addPlace(
          listName,
          restaurantId,
          restaurantName,
          restaurantAddress,
          restaurantPhone,
          restaurantWebsite,
          restaurantHours,
          photoReferences,
        );

        setState(() {
          print('LMAOO$listName');
          if (placeList.myPlaces
              .any((element) => element.name == restaurantName)) {
            //shows dialog if restaurant already exists
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: Text('Error'),
                  content: Text('Restaurant already exists'),
                  actions: <Widget>[
                    TextButton(
                      child: Text('OK'),
                      onPressed: () {
                        Navigator.of(context).pop();
                        _formKey.currentState!.reset();
                        restaurantName = '';
                        restaurantAddress = '';
                        restaurantPhone = '';
                        restaurantWebsite = '';
                        restaurantNotes = '';
                        restaurantRating = '';
                        restaurantTags = [];
                        selectedTags = [];
                        restaurantHours = [];
                        photoReferences = [];
                        restaurantId = '';
                        tagList.clearSelectedTags();
                      },
                    ),
                  ],
                );
              },
            );
          } else {
            placeList.addPlace(
                listName,
                restaurantAddress,
                restaurantPhone,
                restaurantName,
                restaurantWebsite,
                DateFormat.yMMMd().format(DateTime.now()).toString(),
                restaurantHours,
                restaurantRating,
                photoReferences,
                restaurantTags = List.from(tagList.getSelectedTags()),
                restaurantNotes);

            _formKey.currentState!.reset();
            restaurantName = '';
            restaurantAddress = '';
            restaurantPhone = '';
            restaurantWebsite = '';
            restaurantNotes = '';
            restaurantRating = '';
            restaurantTags = [];
            selectedTags = [];
            restaurantHours = [];
            photoReferences = [];
            restaurantId = '';
            tagList.clearSelectedTags();
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text('Saved!'),
              duration: Duration(seconds: 1),
            ));
          }
        });
      } else {
        FocusScope.of(context).unfocus();
        ScaffoldMessenger.of(context).hideCurrentSnackBar();
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Please fill out all fields'),
          duration: Duration(seconds: 1),
        ));
      }
    }

    FirestoreService fsService = FirestoreService();
    return StreamBuilder<List<Place>>(
      stream: fsService.getPlaces(),
      builder: (context, snapshot) {
        return snapshot.connectionState == ConnectionState.waiting ? const Center(child: CircularProgressIndicator()) :
        Scaffold(
          resizeToAvoidBottomInset: false,
          body: Form(
            key: _formKey,
            child: snapshot.data!.length >0 ? SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: SizedBox(
                width: SizeConfig.blockSizeHorizontal * 100,
                height: SizeConfig.blockSizeVertical * 101,
                child: Column(children: [
                  //dropdownbutton containing all lists
                  SizedBox(
                    width: SizeConfig.blockSizeHorizontal * 100,
                    height: SizeConfig.blockSizeVertical * 7,
                    child: Container(
                      margin: EdgeInsets.only(
                        top: 10,
                        left: 30,
                        right: 30,
                      ),
                      child: DropdownButtonFormField<String>(
                        hint: Text('Select a list to save to'),
                        value: null,
                        items: dropDownList.map((String dropdownItem) {
                          return DropdownMenuItem<String>(
                            value: dropdownItem,
                            child: Text(dropdownItem),
                          );
                        }).toList(),
                        onChanged: (value) {
                          //create a new list if user selects 'create a new list'
                          if (value == 'Create a new list') {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: Text('Create a new list'),
                                  content: Form(
                                    key: _formKey2,
                                    child: TextFormField(
                                      controller: TextEditingController(
                                        text: createListName,
                                      ),
                                      validator: (value) {
                                        if (value == '') {
                                          return 'Please enter a name for your list';
                                        } else {
                                          for (var list in listList.getAllLists()) {
                                            if (list.listName == value) {
                                              return 'List already exists';
                                            }
                                          }
                                          return null;
                                        }
                                      },
                                      onSaved: (value) {
                                        setState(() {
                                          createListName = value!;
                                        });
                                      },
                                      decoration: InputDecoration(
                                        labelText: 'List name',
                                      ),
                                    ),
                                  ),
                                  actions: <Widget>[
                                    TextButton(
                                      child: Text('Cancel'),
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                    ),
                                    TextButton(
                                      child: Text('Save'),
                                      onPressed: () {
                                        setState(() {
                                          saveListForm(listList);
                                        });
                                      },
                                    ),
                                  ],
                                );
                              },
                            );
                          } else {
                            setState(() {
                              listName = value!;
                            });
                          }
                        },
                        onSaved: (value) {
                          setState(() {
                            listName = value!;
                          });
                        },
                        validator: (value) {
                          if (value == null) {
                            return 'Please select a list';
                          }
                          return null;
                        },
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(
                      top: 10,
                      left: 30,
                      right: 30,
                    ),
                    child: Autocomplete<AutocompleteValue>(
                      displayStringForOption: (value) => value.description,
                      optionsBuilder: (TextEditingValue textEditingValue) async {
                        if (textEditingValue.text.isEmpty) {
                          return const Iterable<AutocompleteValue>.empty();
                        } else {
                          List<AutocompleteValue> autoCompleteList =
                              await LocationService()
                                  .getAutocomplete(textEditingValue.text);
                          return autoCompleteList.map(
                              (AutocompleteValue autocompleteValue) =>
                                  autocompleteValue);
                        }
                      },
                      onSelected: (AutocompleteValue selected) {
                        LocationService().getPlace(selected.place_id).then((value) {
                          setState(() {
                            //gets list of photo_references from google api

                            FocusScope.of(context).unfocus();
                            //sets the restaurant name, address, phone, website
                            restaurantName = AllEntries().extractName(value);
                            restaurantAddress = AllEntries().extractAddress(value);
                            restaurantPhone = AllEntries().extractPhone(value);
                            restaurantWebsite = AllEntries().extractWebsite(value);
                            restaurantRating =
                                AllEntries().extractRating(value).toString();
                            restaurantHours =
                                AllEntries().extractOpeningHours(value);
                            photoReferences = value['result']['photos']
                                .map((photo) => photo['photo_reference'])
                                .toList();
                            restaurantId = AllEntries().extractPlaceId(value);
                          });
                        });
                      },
                      fieldViewBuilder:
                          (context, controller, focusNode, onEditingComplete) {
                        return TextField(
                          controller: controller,
                          focusNode: focusNode,
                          textCapitalization: TextCapitalization.words,
                          onEditingComplete: onEditingComplete,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            isDense: true,
                            contentPadding: EdgeInsets.all(8),
                            hintText: 'Search',
                            prefixIcon: Icon(Icons.search),
                            suffixIcon: IconButton(
                              icon: Icon(Icons.clear),
                              onPressed: () {
                                controller.clear();
                              },
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  //name
                  Container(
                    margin: const EdgeInsets.only(left: 30, right: 30, top: 10),
                    child: Row(children: [
                      Text('Name: \t\t'),
                      SizedBox(
                        width: SizeConfig.blockSizeHorizontal * 70,
                        height: SizeConfig.blockSizeVertical * 5,
                        child: TextFormField(
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter a name';
                            } else {
                              return null;
                            }
                          },
                          onSaved: (value) {
                            restaurantName = value!;
                          },
                          controller: TextEditingController(text: restaurantName),
                          decoration: InputDecoration(
                            hintText: 'Name',
                            isDense: true,
                            contentPadding: EdgeInsets.all(8),
                          ),
                        ),
                      ),
                    ]),
                  ),

                  Container(
                      //contains address
                      //TODO: onclick on address to open maps
                      margin: const EdgeInsets.only(top: 7, left: 30, right: 30),
                      child: Column(children: [
                        const Align(
                            alignment: Alignment.centerLeft,
                            child: Text('Address:')),
                        TextFormField(
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter an address';
                            } else {
                              return null;
                            }
                          },
                          onSaved: (value) {
                            restaurantAddress = value!;
                          },
                          controller:
                              TextEditingController(text: restaurantAddress),
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            isDense: true,
                            contentPadding: EdgeInsets.all(8),
                          ),
                          keyboardType: TextInputType.multiline,
                          minLines: 2,
                          //expands to fit 2 lines
                          maxLines: 3,
                        ),
                      ])),
                  Container(
                      //container containing website
                      //TODO: onclick on website to open website
                      margin: const EdgeInsets.only(top: 10, left: 30, right: 30),
                      child: Column(children: [
                        const Align(
                            alignment: Alignment.centerLeft,
                            child: Text('Website:')),
                        TextFormField(
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter a website';
                            } else {
                              return null;
                            }
                          },
                          onSaved: (value) {
                            restaurantWebsite = value!;
                          },
                          controller:
                              TextEditingController(text: restaurantWebsite),
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            isDense: true,
                            contentPadding: EdgeInsets.all(8),
                          ),
                          keyboardType: TextInputType.multiline,
                          minLines: 1,
                          //expands to fit 2 lines
                          maxLines: 2,
                        ),
                      ])),
                  Container(
                    margin: const EdgeInsets.only(left: 30, right: 30, top: 10),
                    child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        // row containing rating and phone number
                        children: [
                          Text("Rating: \t\t $restaurantRating"),
                          Container(
                            child: Row(children: [
                              const Text("Phone Number: "),
                              SizedBox(
                                //TODO: error checking for phone number length
                                width: SizeConfig.blockSizeHorizontal * 25,
                                height: SizeConfig.blockSizeVertical * 5,
                                child: TextFormField(
                                  keyboardType: TextInputType.number,
                                  validator: (value) {
                                    if (value == null) {
                                      return 'Please enter a phone number';
                                    } else if (value.length != 9) {
                                      return 'Please enter a valid phone number';
                                    } else {
                                      return null;
                                    }
                                  },
                                  onSaved: (value) {
                                    restaurantPhone = value!;
                                  },
                                  controller:
                                      TextEditingController(text: restaurantPhone),
                                  decoration: const InputDecoration(
                                    hintText: 'Phone',
                                    isDense: true,
                                    contentPadding: EdgeInsets.all(8),
                                  ),
                                  readOnly: false,
                                ),
                              ),
                            ]),
                          ),
                        ]),
                  ),
                  Container(
                    //opening opening hours
                    margin: const EdgeInsets.only(left: 30, right: 30, top: 5),
                    child: Column(children: [
                      const Align(
                          alignment: Alignment.centerLeft,
                          child: Text('Opening Hours: ')),
                      ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true, //scrolls horizontally
                        itemCount: restaurantHours.length,
                        itemBuilder: (context, index) {
                          return Text(restaurantHours[index]);
                        },
                      ),
                    ]),
                  ),

                  Spacer(),
                  //pushes notes box and buttons to bottom

                  Container(
                      //container containing notes
                      margin: const EdgeInsets.only(top: 10, left: 30, right: 30),
                      child: Column(children: [
                        Align(
                            alignment: Alignment.centerLeft, child: Text('Notes:')),
                        TextFormField(
                          validator: (value) {
                            if (value!.length > 200) {
                              return 'Please enter notes';
                            }
                          },
                          onSaved: (value) {
                            restaurantNotes = value!;
                          },
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            isDense: true,
                            contentPadding: const EdgeInsets.all(8),
                          ),
                          keyboardType: TextInputType.multiline,
                          minLines: 4,
                          //expands to fit 4 lines
                          maxLines: 4,
                        ),
                      ])),
                  Container(
                      //container for tags
                      //TODO: change font size
                      alignment: Alignment.centerLeft,
                      margin: const EdgeInsets.only(
                          top: 5, left: 30, right: 30, bottom: 10),
                      child: Row(children: [
                        //TAGS
                        //TODO: add horizontal listview of tags, and make it tappable
                        //TODO: add tag dialog box, and scroll list of existing tags
                        const Text('Tags: '),

                        Expanded(
                          child: Wrap(
                            direction: Axis.horizontal,
                            spacing: SizeConfig.safeBlockHorizontal * 2,
                            runSpacing: SizeConfig.safeBlockHorizontal * 2,
                            children: [
                              for (var tag in tagList.getSelectedTags())
                                GestureDetector(
                                  onTap: () {
                                    showDialog(
                                      context: context,
                                      builder: (context) => TagDialog(),
                                    );
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      // color: tag.color,
                                    ),
                                    child: Chip(
                                      //get name from map and set as text
                                      label: Text(tag['name']),
                                      // onDeleted: () {
                                      //   tagList.removeTag(tag);
                                      //   setState(() {
                                      //     restaurantTags = tagList.getAllTags();
                                      //   });
                                      // },
                                    ),
                                  ),
                                ),
                              InputChip(
                                label: Text('Add Tags'),
                                onPressed: () {
                                  //utilize inputchip to add tags
                                  showDialog(
                                      barrierDismissible: false,
                                      context: context,
                                      builder: (BuildContext context) {
                                        //WillPopScope() to prevent taps outside dialog from closing dialog
                                        return WillPopScope(
                                            onWillPop: () => Future.value(false),
                                            child: TagDialog());
                                      });
                                },
                              ),
                            ],
                          ),
                        ),
                      ])),

                  Container(
                    margin: const EdgeInsets.only(
                        top: 5, left: 30, right: 30, bottom: 30),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: SizeConfig.blockSizeHorizontal * 40,
                          height: SizeConfig.blockSizeVertical * 5,
                          child: OutlinedButton(
                              onPressed: () {
                                const snackBar = SnackBar(
                                  content: Text('Cleared!'),
                                  duration: Duration(seconds: 1),
                                );
                                setState(() {
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(snackBar);
                                  restaurantName = '';
                                  restaurantAddress = '';
                                  restaurantPhone = '';
                                  restaurantWebsite = '';
                                  restaurantRating = '';
                                  restaurantHours = [];
                                  photoReferences = [];
                                  restaurantId = '';
                                  // tagList.clearSelectedTags();
                                });
                              },
                              child: Text('Clear all')),
                        ),
                        SizedBox(
                          width: SizeConfig.blockSizeHorizontal * 40,
                          height: SizeConfig.blockSizeVertical * 5,
                          child: OutlinedButton(
                              onPressed: () {
                                setState(() {
                                  saveForm();
                                });
                                //TODO: change color of button
                              },
                              child: Text('Add to list')),
                        )
                      ],
                    ),
                  ),
                ]),
              ),
            ),
          ),
        ),
      }
    );
  }
}
