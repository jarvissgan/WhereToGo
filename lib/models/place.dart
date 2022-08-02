import 'package:jarlist/all_tags.dart';

class Place {
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

  Place({required this.listName, required this.entryDate, required this.address, required this.phone, required this.name, required this.website, required this.openingHours, required this.photoReferences , required this.rating, required this.tagList, required this.restaurantNotes});

}