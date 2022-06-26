import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:jarlist/alll_entry.dart';
import 'package:jarlist/screens/list_screen.dart';
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
  @override
  Widget build(BuildContext context) {
    AllEntries placeList = Provider.of<AllEntries>(context);

    //gets arguments from Navigator
    final arguments =
        ModalRoute.of(context)?.settings.arguments as Map<String, Object>;
    List openingHours = arguments['openingHours'] as List;
    List tagList = arguments['tagList'] as List;
    String website = arguments['website'] as String;
    String phone = arguments['phone'] as String;

    return Scaffold(
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
                enabled: _editable,
                onChanged: (value) {},
              ),
              //textFormField for address
              Container(
                margin: _editable
                    ? const EdgeInsets.only(top: 20)
                    : const EdgeInsets.only(top: 0),
                child: TextFormField(
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.normal),
                  initialValue: arguments['address'] as String,
                  decoration: InputDecoration(
                    //hide border when not editable
                    border: _editable ? OutlineInputBorder() : InputBorder.none,
                    isDense: true,
                    //shows label when editable
                    labelText: _editable ? 'Address' : '',
                    contentPadding: const EdgeInsets.all(10),
                  ),
                  enabled: _editable,
                  onChanged: (value) {},
                  minLines: 2,
                  maxLines: 3,
                ),
              ),
              //textFormField for phone number
              if(_editable)
                Container(
                  margin: const EdgeInsets.only(top: 20),
                  child: TextFormField(
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.normal),
                    initialValue: phone,
                    decoration: InputDecoration(
                      //hide border when not editable
                      border: _editable ? OutlineInputBorder() : InputBorder.none,
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
              if(!_editable)
                Container(
                  margin: const EdgeInsets.only(top: 20),
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
              //textFormField for website
              // Container(
              //   margin: _editable ? const EdgeInsets.only(top: 20) : const EdgeInsets.only(top: 0),
              //   child: TextFormField(
              //     style: TextStyle(fontSize: 14, fontWeight: FontWeight.normal),
              //     initialValue: arguments['website'] as String,
              //     decoration: InputDecoration(
              //       //hide border when not editable
              //       border: _editable ? OutlineInputBorder() : InputBorder.none,
              //       isDense: true,
              //       //shows label when editable
              //       labelText: _editable ? 'Website' : '',
              //       contentPadding: const EdgeInsets.all(10),
              //     ),
              //     enabled: _editable,
              //     onChanged: (value) {
              //     },
              //     onSaved: (value) {
              //     },
              //     validator: (value) {
              //       //TODO: nullable website
              //       if (value == '') {
              //         return 'Please enter a website';
              //       }
              //       return null;
              //     },
              //   ),
              // ),
              ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true, //scrolls horizontally
                itemCount: openingHours.length,
                itemBuilder: (context, index) {
                  return Container(
                      margin: const EdgeInsets.only(left: 10, right: 10),
                      child: Text(openingHours[index] as String));
                },
              ),
              Text(arguments['rating'] as String),
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
              Text(arguments['restaurantNotes'] as String),
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
                              builder: (context) => AlertDialog(
                                    title: const Text('Delete entry'),
                                    content: const Text(
                                        'Are you sure you want to delete this entry?'),
                                    actions: <Widget>[
                                      FlatButton(
                                        child: const Text('Cancel'),
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                      ),
                                      FlatButton(
                                        child: const Text('Delete'),
                                        onPressed: () {
                                          //delete entry
                                          setState(() {
                                            placeList
                                                .removePlace(arguments['name']);
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
                          if (_editable) {
                            _editable = false;
                          } else {
                            _editable = true;
                          }
                        });
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}
