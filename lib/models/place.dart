import 'package:jarlist/all_tags.dart';

class Place {
  String listName;
  List<dynamic> tagList;
  Map<String, dynamic> json;
  List<dynamic> openingHours;
  String rating;
  String address,
      phone,
      name,
      website,
      entryDate;

  Place({required this.listName,required this.json, required this.entryDate, required this.address, required this.phone, required this.name, required this.website, required this.openingHours, required this.rating, required this.tagList});

}