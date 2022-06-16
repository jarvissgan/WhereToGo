import 'package:flutter/material.dart';
import 'package:jarlist/create_entry.dart';
import 'package:jarlist/location_service.dart';

class AddScreen extends StatefulWidget {
  @override
  State<AddScreen> createState() => _AddScreenState();
}

class _AddScreenState extends State<AddScreen> {
  TextEditingController _searchController = TextEditingController();
  static const String googleApiKey = 'AIzaSyCalXPvIMk2Vh4ypx4FuDcKPsQQUqLwwAs';

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
            //TODO: complete add screen
            children: [
              Expanded(
                child: Container(
                  margin: EdgeInsets.only(left: 30, right: 20, top: 10),
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
                                    print(CreateEntry(value).extractName());
                              });
                            },
                            icon: Icon(Icons.search)),
                      )),
                ),
              )
            ]),
      ],
    );
  }
}
