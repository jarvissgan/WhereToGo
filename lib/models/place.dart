import 'package:jarlist/all_tags.dart';

class Place {
  String id;
  String listName;
  List<dynamic> tagList;
  List<dynamic> openingHours;
  List photoReferences;
  String rating;
  String address,
      phone,
      name,
      website,
      entryDate,
  restaurantNotes;
  bool checkState;

  Place({required this.id, required this.listName, required this.entryDate, required this.address, required this.phone, required this.name, required this.website, required this.openingHours, required this.photoReferences , required this.rating, required this.tagList, required this.restaurantNotes, required this.checkState});


  Place.fromMap(Map<String, dynamic> snapshot, String id) :
        id = id ?? '',
        listName = snapshot['listName'] ?? '',
        entryDate = snapshot['entryDate'] ?? '',
        address = snapshot['address'] ?? '',
        phone = snapshot['phone'] ?? '',
        name = snapshot['name'] ?? '',
        website = snapshot['website'] ?? '',
        openingHours = snapshot['openingHours'] ?? '',
        photoReferences = snapshot['photoReferences'] ?? '',
        rating = snapshot['rating'] ?? '',
        tagList = snapshot['tagList'] ?? '',
        restaurantNotes = snapshot['restaurantNotes'] ?? '',
        checkState = snapshot['checkState'] ?? false;
}