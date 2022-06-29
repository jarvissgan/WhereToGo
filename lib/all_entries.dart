import 'package:flutter/material.dart';
import 'package:jarlist/models/place.dart';

class AllEntries with ChangeNotifier {
  List<Place> myPlaces = [];

  List<Place> getAllPlaces() {
    return myPlaces;
  }

  void addPlace(listName, address, phone, name, website, entryDate, openingHours, rating, json, tagList, restaurantNotes) {
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
      restaurantNotes: restaurantNotes,
    ));
    //prints all items in myPlaces list
    // var se = 0;
    // print(myPlaces[se].listName);
    // print(myPlaces[se].name);
    // print(myPlaces[se].address);
    // print(myPlaces[se].phone);
    // print(myPlaces[se].website);
    // print(myPlaces[se].entryDate);
    // print(myPlaces[se].openingHours);
    // print(myPlaces[se].rating);
    // print(myPlaces[se].json);
    // print(myPlaces[se].tagList);


    notifyListeners();
  }

  //updates place with new values without removing entry from list

  void updatePlace(listName, address, phone, name, website, entryDate, openingHours, rating, json, tagList, restaurantNotes) {
    //gets position of place in list
    int position = myPlaces.indexWhere((place) => place.name == name);

    print('POS $position');

    myPlaces.removeWhere((place) => place.name == name);
    myPlaces.insert(0,Place(
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
      restaurantNotes: restaurantNotes,
    ));
    notifyListeners();
  }

  //sort list by name
  void sortByName() {
    myPlaces.sort((a, b) => a.name.compareTo(b.name));
    notifyListeners();
  }

  //sort list by entry date
  void sortByDate() {
    myPlaces.sort((a, b) => a.entryDate.compareTo(b.entryDate));
    notifyListeners();
  }


  void removePlace(listName) {
    myPlaces.removeWhere((place) => place.listName == listName);
    notifyListeners();
  }

  void removePlaceWithName(name) {
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
