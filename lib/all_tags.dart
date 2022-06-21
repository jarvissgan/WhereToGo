import 'package:flutter/material.dart';
import 'package:jarlist/models/tag.dart';

class AllTags with ChangeNotifier {
  List<Tag> allTags = [];

  List<Tag> getAllTags() {
    return allTags;
  }
  String addTag(name, color) {
    //adds tag if name doesn't already exist
    if(allTags.contains(name)){
      //TODO: add snackbar/message to show tag already exists

      return "tag already exists";

    } else {
      allTags.insert(allTags.length, Tag(name: name, color: color));
      notifyListeners();
      return "tag added";
    }
  }
  void removeTag(name) {
    allTags.removeWhere((tag) => tag.name == name);
    notifyListeners();
  }
  void updateTagName(name, newName) {
    allTags.removeWhere((tag) => tag.name == name);
    allTags.insert(allTags.length, Tag(name: newName, color: name.color));
    notifyListeners();
  }
}