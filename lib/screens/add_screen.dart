import 'package:flutter/material.dart';
import 'package:jarlist/create_entry.dart';
import 'package:jarlist/location_service.dart';
import 'package:jarlist/size_config.dart';

class AddScreen extends StatefulWidget {
  @override
  State<AddScreen> createState() => _AddScreenState();
}

class _AddScreenState extends State<AddScreen> {
  TextEditingController _searchController = TextEditingController();
  String restaurantName = '';
  String restaurantAddress = '';
  String restaurantPhone = '';
  String restaurantWebsite = '';
  String restaurantNotes = '';
  String restaurantRating = '';
  List<dynamic> restaurantHours = [];
  List<dynamic> restaurantImage = [];
  String restaurantId = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Column(children: [
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
                          //sets the restaurant name, address, phone, website
                          restaurantName = CreateEntry(value).extractName();
                          restaurantAddress =
                              CreateEntry(value).extractAddress();
                          restaurantPhone = CreateEntry(value).extractPhone();
                          restaurantWebsite =
                              CreateEntry(value).extractWebsite();
                          restaurantRating =
                              CreateEntry(value).extractRating().toString();
                          restaurantHours =
                              CreateEntry(value).extractOpeningHours();
                          restaurantImage = CreateEntry(value).extractPhotos();
                          restaurantId = CreateEntry(value).extractPlaceId();
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
              TextField(
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
              TextField(
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
            child: Column(children: const [
              Align(alignment: Alignment.centerLeft, child: Text('Notes:')),
              TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  isDense: true,
                  contentPadding: const EdgeInsets.all(8),
                ),
                keyboardType: TextInputType.multiline,
                minLines: 4, //expands to fit 4 lines
                maxLines: 4,
              ),
            ])),
        Container(
            //container for tags
            //TODO: change font size
            alignment: Alignment.centerLeft,
            margin:
                const EdgeInsets.only(top: 5, left: 30, right: 30, bottom: 10),
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
                        /*TODO: add and show tag cards on click*/
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
                      //TODO: add entry to database
                      //TODO: change color of button
                    },
                    child: Text('Add to list')),
              )
            ],
          ),
        ),
      ]),
    );
  }
}
