import 'package:flutter/material.dart';
import 'package:jarlist/models/list.dart';

class AllLists with ChangeNotifier{
  List<dynamic> allLists = [];
  List<dynamic> getAllLists() {
    return allLists;
  }
  void addList(name, entryList, tagList) {
    //adds list if name doesn't already exist
    if(allLists.contains(name)){
      print("list already exists");
      notifyListeners();
    } else {
      allLists.insert(allLists.length, Lists(listName: name, entrylist: entryList,  tagList: tagList));
      notifyListeners();
    }
  }
  void removeList(name) {
    allLists.removeWhere((list) => list.listName == name);
    notifyListeners();
  }

  //gets names in list
  List<String> getNamesAsList(){
    List<String> listNameList = [];
    for(var list in allLists){
      listNameList.add(list.listName as String);
    }
    print(listNameList);
    return listNameList;
  }
  void updateListName(name, newName, entryList, tagList) {
    allLists.removeWhere((list) => list.listName == name);
    allLists.insert(allLists.length, Lists(entrylist: entryList, listName: newName, tagList: tagList));
    notifyListeners();
  }

  // //edit place with new values
  // void editPlace(name, address, ) {
  //   //checks where place is in list
  //   int index = allLists.indexWhere((list) => list.listName == name);
  //   allLists.removeWhere((list) => list.listName == name);
  //   allLists.insert(index, Lists(entrylist: entryList, listName: name, tagList: tagList));
  //   notifyListeners();
  // }

  //gets list by name
  List<dynamic> getListByName(name){
    for(var list in allLists){
      if(list.listName == name){
        return list;
      }
    }
    return allLists;
  }
  void clearAllLists() {
    allLists.clear();
    print(allLists.length);
    notifyListeners();
  }
}