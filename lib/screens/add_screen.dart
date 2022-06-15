import 'package:flutter/material.dart';
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
    return Column(children: [
      Row(
        //TODO: complete add screen
        children: [
          Expanded(
              child: TextFormField(
            controller: _searchController,
            textCapitalization: TextCapitalization.words,
            decoration: InputDecoration(hintText: 'Search'),
            onChanged: (value) {
              if (value != '') {
                print(value);
              } else {
                value = '';
              }
            },
          )),
          IconButton(onPressed: () {
            LocationService().getPlace(_searchController.text).then((value) {
              print(value);
            });
          }, icon: Icon(Icons.search)),
        ],
      )
    ]);
  }
}
