import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:jarlist/all_entries.dart';
import 'package:jarlist/screens/list_screen.dart';
import 'package:jarlist/services/location_service.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';

class EntryView extends StatefulWidget {
  static const String routeName = '/entryView';

  @override
  State<EntryView> createState() => _EntryViewState();
}

bool _editable = false;

class _EntryViewState extends State<EntryView> {
  String restaurantName = '';
  String restaurantAddress = '';
  String restaurantPhone = '';
  String restaurantWebsite = '';
  String restaurantNotes = '';

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    AllEntries placeList = Provider.of<AllEntries>(context, listen: false);
    final String key = 'no';

    //gets arguments from Navigator
    final arguments =
    ModalRoute
        .of(context)
        ?.settings
        .arguments as Map<String, dynamic>;
    List openingHours = arguments['openingHours'] as List;
    List tagList = arguments['tagList'] as List;
    String website = arguments['website'] as String;
    String phone = arguments['phone'] as String;

    void saveForm() {
      bool isValid = _formKey.currentState!.validate();
      if (isValid) {
        _formKey.currentState!.save();
        setState(() {
          placeList.updatePlace(
              arguments['listName'],
              restaurantAddress,
              phone,
              arguments['name'],
              website,
              arguments['entry'],
              openingHours,
              arguments['photoReferences'],
              arguments['rating'],
              tagList,
              restaurantNotes);

          _formKey.currentState!.reset();
          Navigator.of(context).pop();
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text('Updated!'),
              duration: Duration(seconds: 1)
          ));
        });
      }
    }

    return Form(
      key: _formKey,
      child: Scaffold(
          resizeToAvoidBottomInset: false,
          body: Container(
            margin: const EdgeInsets.only(top: 30, left: 30, right: 30),
            child: Column(
              children: [
                //back button to go back to list view
                Align(
                  alignment: Alignment.topLeft,
                  child: IconButton(
                    icon: Icon(Icons.arrow_back),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ),
                TextFormField(
                  initialValue: arguments['name'] as String,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  decoration: InputDecoration(
                    //hide border when not editable
                    border: _editable ? OutlineInputBorder() : InputBorder.none,
                    isDense: true,
                    //shows label when editable
                    labelText: _editable ? 'Name' : '',
                    contentPadding: const EdgeInsets.all(10),
                  ),
                  enabled: false,
                  onChanged: (value) {},
                ),
                Container(
                  child: CarouselSlider(
                    items: [
                      for (int i = 0; i < arguments['photoReferences'].length;
                      i++)
                        Container(
                          child: Image.network(
                            'https://maps.googleapis.com/maps/api/place/photo?maxwidth=400&photo_reference=${arguments['photoReferences'][i]}&key=$key',
                            fit: BoxFit.cover,
                          ),
                        ),
                    ], options: CarouselOptions(),
                  ),
                ),
                //textFormField for address
                Container(
                  margin: _editable
                      ? const EdgeInsets.only(top: 20)
                      : const EdgeInsets.only(top: 0),
                  child: TextFormField(
                    style: TextStyle(
                        fontSize: 14, fontWeight: FontWeight.normal),
                    initialValue: arguments['address'] as String,
                    decoration: InputDecoration(
                      //hide border when not editable
                      border: _editable ? OutlineInputBorder() : InputBorder
                          .none,
                      isDense: true,
                      //shows label when editable
                      labelText: _editable ? 'Address' : '',
                      contentPadding: const EdgeInsets.all(10),
                    ),
                    onSaved: (value) {
                      setState(() {
                        restaurantAddress = value!;
                      });
                    },
                    enabled: _editable,
                    minLines: 2,
                    maxLines: 3,
                  ),
                ),
                //textFormField for phone number
                if (_editable)
                  Container(
                    margin: const EdgeInsets.only(top: 20),
                    child: TextFormField(
                      style:
                      TextStyle(fontSize: 14, fontWeight: FontWeight.normal),
                      initialValue: phone,
                      decoration: InputDecoration(
                        //hide border when not editable
                        border:
                        _editable ? OutlineInputBorder() : InputBorder.none,
                        isDense: true,
                        //shows label when editable
                        labelText: _editable ? 'Phone' : '',
                        contentPadding: const EdgeInsets.all(10),
                      ),
                      enabled: _editable,
                      onChanged: (value) {},
                      minLines: 2,
                      maxLines: 3,
                    ),
                  ),
                if (!_editable)
                  Container(
                    margin: const EdgeInsets.only(top: 20, left: 10),
                    child: Align(
                        alignment: Alignment.centerLeft,
                        child: RichText(
                          text: phone.isEmpty
                              ? TextSpan(text: 'No Number')
                              : TextSpan(
                              text: phone,
                              style: TextStyle(
                                  color: Colors.blue,
                                  decoration: TextDecoration.underline),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  //TODO: not hardcode
                                  launchUrlString('tel:+6596478437');
                                }),
                        )),
                  ),
                if (_editable)
                //textFormField for website
                  Container(
                    margin: const EdgeInsets.only(top: 20),
                    child: TextFormField(
                      style:
                      TextStyle(fontSize: 14, fontWeight: FontWeight.normal),
                      initialValue: arguments['website'] as String,
                      decoration: InputDecoration(
                        //hide border when not editable
                        border:
                        _editable ? OutlineInputBorder() : InputBorder.none,
                        isDense: true,
                        //shows label when editable
                        labelText: _editable ? 'Website' : '',
                        contentPadding: const EdgeInsets.all(10),
                      ),
                      enabled: _editable,
                      onChanged: (value) {},
                    ),
                  ),
                if (!_editable)
                //textFormField for website
                  Container(
                    margin: const EdgeInsets.only(top: 20, left: 10),
                    child: Align(
                        alignment: Alignment.centerLeft,
                        child: RichText(
                          text: website.isEmpty
                              ? TextSpan(text: 'No website')
                              : TextSpan(
                              text: website,
                              style: TextStyle(
                                  color: Colors.blue,
                                  decoration: TextDecoration.underline),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  launch(website);
                                }),
                        )),
                  ),
                Container(
                  margin: const EdgeInsets.only(left: 10),
                  child: ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true, //scrolls horizontally
                    itemCount: openingHours.length,
                    itemBuilder: (context, index) {
                      return Container(
                          margin: const EdgeInsets.only(left: 10, right: 10),
                          child: Text(openingHours[index] as String));
                    },
                  ),
                ),
                // Text(arguments['rating'] as String),
                //generates chips for tags based on list of tags
                Wrap(
                  children: [
                    //for loop to generate chips from tagList
                    for (var tag in tagList)
                      FilterChip(
                          label: Text(tag['name']),
                          selected: false,
                          onSelected: (value) {
                            setState(() {});
                          })
                  ],
                ),
                Container(
                  //container containing notes
                    margin: const EdgeInsets.only(top: 10, left: 20, right: 20),
                    child: Column(children: [
                      TextFormField(
                        initialValue: arguments['restaurantNotes'] as String,
                        validator: (value) {
                          if (value!.length > 200) {
                            return 'Please enter notes';
                          }
                        },
                        onSaved: (value) {
                          restaurantNotes = value!;
                        },
                        decoration: InputDecoration(
                          //hide border when not editable
                          border: OutlineInputBorder(),
                          isDense: true,
                          //shows label when editable
                          labelText: 'Notes',
                          contentPadding: const EdgeInsets.all(10),
                        ),
                        keyboardType: TextInputType.multiline,
                        minLines: 4,
                        //expands to fit 4 lines
                        maxLines: 4,
                      ),
                    ])),
                //buttons to delete and edit entry
                Align(
                  alignment: Alignment.bottomRight,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      IconButton(
                          icon: Icon(Icons.delete),
                          onPressed: () {
                            //show dialog to confirm deletion
                            showDialog(
                                context: context,
                                builder: (context) =>
                                    AlertDialog(
                                      title: const Text('Delete entry'),
                                      content: const Text(
                                          'Are you sure you want to delete this entry?'),
                                      actions: <Widget>[
                                        TextButton(
                                          child: const Text('Cancel'),
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                        ),
                                        TextButton(
                                          child: const Text('Delete'),
                                          onPressed: () {
                                            //delete entry
                                            setState(() {
                                              placeList
                                                  .removePlace(
                                                  arguments['name']);
                                              //navigate to list view by popping
                                              Navigator.of(context).pop();
                                              Navigator.of(context).pop();
                                            });
                                          },
                                        ),
                                      ],
                                    ));
                          }),
                      IconButton(
                        icon: Icon(Icons.edit),
                        onPressed: () {
                          setState(() {
                            if (!_editable) {
                              _editable = true;
                            } else {
                              //dialog to confirm edit
                              showDialog(
                                  context: context,
                                  builder: (context) =>
                                      AlertDialog(
                                        title: const Text('Edit entry'),
                                        content: const Text(
                                            'Are you sure you want to edit this entry?'),
                                        actions: <Widget>[
                                          TextButton(
                                            child: const Text('Cancel'),
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            },
                                          ),
                                          TextButton(
                                            child: const Text('Save'),
                                            onPressed: () {
                                              setState(() {
                                                _editable = false;
                                                saveForm();
                                                Navigator.of(context).pop();
                                              });
                                            },
                                          ),
                                        ],
                                      ));
                            }
                          });
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          )),
    );
  }
}
