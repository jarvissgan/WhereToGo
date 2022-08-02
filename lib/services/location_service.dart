import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class LocationService {
  /*
  location service uses google places api to extract information
  about a location from user input
  */
  final String key = 'no';

  // Future<String> getPlaceID(String input) async {
  //   //gets place id of location, to be used in getPlace()
  //   final String url =
  //       'https://maps.googleapis.com/maps/api/place/findplacefromtext/json?input=$input&inputtype=textquery&key=$key';
  //
  //   var response = await http.post(Uri.parse(url));
  //   var json = convert.jsonDecode(response.body);
  //
  //   //retrieves response from api and returns a placeid as String
  //   var placeId = json['candidates'][0]['place_id'] as String;
  //   //candidates refers to most likely matches
  //
  //   print(placeId);
  //   return placeId;
  // }

  Image getImage(String placeId) {
    //gets image of location
    final String url =
        'https://maps.googleapis.com/maps/api/place/photo?maxwidth=400&photoreference=$placeId&key=$key';
    return Image.network(url);
  }

  Future<Map<String, dynamic>> getPlace(String input) async {
    //uses getPlaceId to get location details from google api
    // final placeID = await getPlaceID(input);
    String url =
        'https://maps.googleapis.com/maps/api/place/details/json?placeid=$input&key=$key';

    var response = await http.post(Uri.parse(url));
    var json = convert.jsonDecode(response.body);
    // print(CreateEntry(json).extractPhotos());

    var results = json as Map<String, dynamic>;

    return results;
  }

  //gets autocomplete results from google api
  Future<List<AutocompleteValue>> getAutocomplete(String input) async {
    // final placeID = await getPlaceID(input);
    //TODO: add session token to prevent google from blocking requests
    String url =
        'https://maps.googleapis.com/maps/api/place/autocomplete/json?input=$input&components=country:sg&types=establishment&key=$key';

    var response = await http.post(Uri.parse(url));
    var json = convert.jsonDecode(response.body);
    // print(CreateEntry(json).extractPhotos());

    // var results = json as Map<String, dynamic>;

    List predictions = json['predictions'];

    return predictions
        .map((res) => AutocompleteValue(
              description: res["description"],
              place_id: res["place_id"],
            ))
        .toList();
  }
}

class AutocompleteValue {
  final String description;
  final String place_id;

  AutocompleteValue({required this.description, required this.place_id});
}
