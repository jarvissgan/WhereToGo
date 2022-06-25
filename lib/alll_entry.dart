import 'package:flutter/material.dart';
import 'package:jarlist/models/place.dart';

class AllEntries with ChangeNotifier {
  List<Place> myPlaces = [];

  List<Place> getAllPlaces() {
    return myPlaces;
  }

  void addPlace(listName, address, phone, name, website, entryDate, openingHours, rating, json, tagList) {
    myPlaces.insert(myPlaces.length,Place(
      listName: listName,
      name: name,
      address: address,
      phone: phone,
      website: website,
      openingHours: openingHours,
      rating: rating,
      entryDate: entryDate,
      json: {
        'address': address,
        'phone': phone,
        'name': name,
        'website': website,
        'entryDate': entryDate,
        'openingHours': openingHours,
        'rating': rating,
      },
      tagList: tagList,
    ));
    //prints all items in myPlaces list
    notifyListeners();
  }
  void removePlace(name) {
    myPlaces.removeWhere((place) => place.name == name);
    notifyListeners();
  }

  List<Place> returnPlace(){
    return myPlaces;
  }

  //returns details of location
  String extractAddress(json) {
    return json['result']['formatted_address'] as String;
  }

  String extractPhone(json) {
    return json['result']['formatted_phone_number'] as String;
  }

  String extractName(json) {
    return json['result']['name'] as String;
  }

  double extractRating(json) {
    return json['result']['rating'] as double;
  }

  String extractPlaceId(json) {
    return json['result']['place_id'] as String;
  }

  String extractWebsite(json) {
    return json['result']['website'] as String;
  }

  List<dynamic> extractOpeningHours(json) {
    return json['result']['opening_hours']['weekday_text'] as List<dynamic>;
  }

  List<dynamic> extractPhotos(json) {
    //do future work to get multiple photos
    return json['result']['photos'] as List<dynamic>;
  }
}
