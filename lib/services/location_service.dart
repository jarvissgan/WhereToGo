import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

import 'package:jarlist/all_entries.dart';

class LocationService {
  /*
  location service uses google places api to extract information
  about a location from user input
  */
  final String key = 'AIzaSyCalXPvIMk2Vh4ypx4FuDcKPsQQUqLwwAs';

  Future<String> getPlaceID(String input) async {
    //gets place id of location, to be used in getPlace()
    final String url =
        'https://maps.googleapis.com/maps/api/place/findplacefromtext/json?input=$input&inputtype=textquery&key=$key';

    var response = await http.post(Uri.parse(url));
    var json = convert.jsonDecode(response.body);

    //retrieves response from api and returns a placeid as String
    var placeId = json['candidates'][0]['place_id'] as String;
    //candidates refers to most likely matches
    //TODO: add autocomplete for location & generate listview when search is complete

    print(placeId);
    return placeId;
  }

  Future<Map<String, dynamic>> getPlace(String input) async {
    //uses getPlaceId to get location details from google api
    final placeID = await getPlaceID(input);
    String url =
        'https://maps.googleapis.com/maps/api/place/details/json?placeid=$placeID&key=$key';

    var response = await http.post(Uri.parse(url));
    var json = convert.jsonDecode(response.body);
    // print(CreateEntry(json).extractPhotos());

    var results = json as Map<String, dynamic>;

    return results;
  }
}
