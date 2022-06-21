import 'package:flutter/material.dart';
import 'package:jarlist/all_tags.dart';
import 'package:jarlist/alll_entry.dart';
import 'package:jarlist/location_service.dart';
import 'package:jarlist/models/place.dart';
import 'package:jarlist/screens/list_screen.dart';
import 'package:jarlist/size_config.dart';
import 'package:jarlist/widgets/tag_dialog.dart';
import 'package:provider/provider.dart';

class AddScreen extends StatefulWidget {
  @override
  State<AddScreen> createState() => _AddScreenState();
}

class _AddScreenState extends State<AddScreen> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _searchController = TextEditingController();
  String restaurantName = '';
  String restaurantAddress = '';
  String restaurantPhone = '';
  String restaurantWebsite = '';
  String restaurantNotes = '';
  String restaurantRating = '';
  String tagName = '';
  String tagColor = '';
  List<dynamic> restaurantHours = [];
  List<dynamic> restaurantImage = [];
  String restaurantId = '';

  void saveForm(Entry placeList) async {
    bool isValid = _formKey.currentState!.validate();
    if (isValid) {
      _formKey.currentState!.save();
      setState(() {
        placeList.addPlace(
            restaurantAddress,
            restaurantPhone,
            restaurantName,
            restaurantWebsite,
            DateTime.now().toString(),
            restaurantHours,
            restaurantRating, {});
        _formKey.currentState!.reset();
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Saved!'),
          duration: Duration(seconds: 1),
        ));
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


  @override
  Widget build(BuildContext context) {
    //TODO: rename Entry() to AllPlaces()
    Entry placeList = Provider.of<Entry>(context);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Form(
        key: _formKey,
        child: Column(children: [
          Container(
            margin: const EdgeInsets.only(left: 30, right: 30, top: 10),
            child: TextFormField(
                controller: _searchController,
                textCapitalization: TextCapitalization.words,
                decoration: InputDecoration(
                  hintText: 'Search a location',
                  suffixIcon: IconButton(
                      onPressed: () {
                        LocationService()
                            .getPlace(_searchController.text)
                            .then((value) {
                          setState(() {
                            FocusScope.of(context).unfocus();
                            //sets the restaurant name, address, phone, website
                            restaurantName = Entry().extractName(value);
                            restaurantAddress = Entry().extractAddress(value);
                            restaurantPhone = Entry().extractPhone(value);
                            restaurantWebsite = Entry().extractWebsite(value);
                            restaurantRating =
                                Entry().extractRating(value).toString();
                            restaurantHours =
                                Entry().extractOpeningHours(value);
                            restaurantImage = Entry().extractPhotos(value);
                            restaurantId = Entry().extractPlaceId(value);
                          });
                        });
                      },
                      icon: const Icon(Icons.search)),
                )),
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
                    if (value == null) {
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
                  onChanged: (value) {
                    setState(() {
                      restaurantName = value;
                    });
                  },
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
                    alignment: Alignment.centerLeft, child: Text('Address:')),
                TextFormField(
                  validator: (value) {
                    if (value == null) {
                      return 'Please enter an address';
                    } else {
                      return null;
                    }
                  },
                  onSaved: (value) {
                    restaurantAddress = value!;
                  },
                  controller: TextEditingController(text: restaurantAddress),
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
                    alignment: Alignment.centerLeft, child: Text('Website:')),
                TextFormField(
                  validator: (value) {
                    if (value == null) {
                      return 'Please enter a website';
                    } else {
                      return null;
                    }
                  },
                  onSaved: (value) {
                    restaurantWebsite = value!;
                  },
                  controller: TextEditingController(text: restaurantWebsite),
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

          Spacer(), //pushes notes box and buttons to bottom

          Container(
              //container containing notes
              margin: const EdgeInsets.only(top: 10, left: 30, right: 30),
              child: Column(children: [
                Align(alignment: Alignment.centerLeft, child: Text('Notes:')),
                TextFormField(
                  validator: (value) {
                    if (value == null) {
                      return 'Please enter notes';
                    } else {
                      return null;
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
                Card(
                    //creates a card for each tag
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(9),
                      side: const BorderSide(
                        color: Colors.blueGrey,
                        width: 0.5,
                      ),
                    ),
                    child: SizedBox(
                      width: SizeConfig.blockSizeHorizontal * 30,
                      height: SizeConfig.blockSizeVertical * 5,
                      child: Center(
                          child: TextButton.icon(
                        label: Text('Add Tags'),
                        icon: const Icon(Icons.add),
                        onPressed: () {
                          //utilize inputchip to add tags
                          showDialog(
                            barrierDismissible: false,
                              context: context,
                              builder: (BuildContext context) {
                                return WillPopScope(
                                  onWillPop: () => Future.value(false),
                                    child: TagDialog());
                              });
                          /*TODO: add and show tag cards on click*/
                          //TODO: convert button to chip

                        },
                      )),
                    ))
              ])),

          Container(
            margin:
                const EdgeInsets.only(top: 5, left: 30, right: 30, bottom: 30),
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
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                          restaurantName = '';
                          restaurantAddress = '';
                          restaurantPhone = '';
                          restaurantWebsite = '';
                          restaurantRating = '';
                          restaurantHours = [];
                          restaurantImage = [];
                          restaurantId = '';
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
                          saveForm(placeList);
                        });
                        //TODO: add entry to database
                        //TODO: change color of button
                      },
                      child: Text('Add to list')),
                )
              ],
            ),
          ),
        ]),
      ),
    );
  }
}
