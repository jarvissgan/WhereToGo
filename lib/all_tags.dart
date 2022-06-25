import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:jarlist/models/tag.dart';

class AllTags with ChangeNotifier {
  List<Tag> allTags = [];

  List<Tag> getAllTags() {
    return allTags;
  }

  //stores selected tags in a list
  List<dynamic> selectedTags = [];

  List<dynamic> getSelectedTags() {
    return selectedTags;
  }
  void addSelectedTags(String tag, selected) {
    //creates map of tag and selected value and adds to selectedList
    Map tempMap = {'name': tag, 'selected': selected};
    selectedTags.add(tempMap);
    notifyListeners();
  }

  void removeSelectedTags(String tagName) {
    //removes tag from selectedTags list if selectedTag = tagName
    selectedTags.removeWhere((tag) => tag['name'] == tagName);
    notifyListeners();
  }

  void clearSelectedTags(){
    selectedTags.clear();
    notifyListeners();
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

  void updateSelectedState(name, selectedState) {
    allTags.removeWhere((tag) => tag.name == name);
    allTags.insert(allTags.length, Tag(name: name, color: name.color));
    notifyListeners();
  }
  void clearAllTags() {
    allTags.clear();
    print(allTags.length);
    notifyListeners();
  }
}