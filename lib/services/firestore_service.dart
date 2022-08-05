import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:jarlist/models/list.dart';
import 'package:jarlist/models/tag.dart';

import '../models/place.dart';

class FirestoreService {
  addPlace(
      id,
      listName,
      placeID,
      restaurantName,
      restaurantAddress,
      restaurantPhone,
      restaurantWebsite,
      restaurantEntryDate,
      restaurantRating,
      checkState,
      List<dynamic> restaurantOpeningHours,
      List<dynamic> restaurantTags,
      String restaurantNotes,
      List<dynamic> photoReferences) {
    String idPlace =
        FirebaseFirestore.instance.collection('places').doc().id.toString();
    return FirebaseFirestore.instance.collection('places').doc(idPlace).set({
      'id': idPlace,
      'listName': listName,
      'placeID': placeID,
      'name': restaurantName,
      'address': restaurantAddress,
      'number': restaurantPhone,
      'website': restaurantWebsite,
      'checkState': checkState,
      'openingHours': restaurantOpeningHours,
      'tagList': restaurantTags,
      'restaurantNotes': restaurantNotes,
      'photoReferences': photoReferences,
    });
  }
  String idLists =
  FirebaseFirestore.instance.collection('places').doc().id.toString();
  addList(String listName) {
    return FirebaseFirestore.instance.collection('lists').doc(idLists).set({
      'listName': listName,
    });
  }

  changeCheckState(documentID, checkState) {
    return FirebaseFirestore.instance
        .collection('places')
        .doc(documentID)
        .update({'checkState': checkState});
  }

  removeEntry(id) {
    return FirebaseFirestore.instance.collection('places').doc(id).delete();
  }

  //removeEntry with documentID
  removeEntryWithDocumentID(documentID) {
    return FirebaseFirestore.instance
        .collection('places')
        .doc(documentID)
        .delete();
  }

  //removeList with documentID
  removeListWithDocumentID(documentID) {
    return FirebaseFirestore.instance
        .collection('lists')
        .doc(documentID)
        .delete();
  }

  //stream gets all places from firestore
  Stream<List<Place>> getPlaces() {
    return FirebaseFirestore.instance.collection('places').get().asStream().map(
          (snapshot) => snapshot.docs
              .map((doc) => Place.fromMap(doc.data(), doc.id))
              .toList(),
        );
  }

  //stream gets all lists from firestore
  Stream<List<Lists>> getLists() {
    return FirebaseFirestore.instance.collection('lists').snapshots().map(
        (snapshot) => snapshot.docs
            .map<Lists>((doc) => Lists.fromMap(doc.data(), doc.id)).toList());
  }

  //stream get all lists from firestore
  // Stream<List<dynamic>> getLists() {
  //   return FirebaseFirestore.instance.collection('lists').snapshots().map(
  //       (snapshot) => snapshot.docs
  //           .map<String>((doc) => Lists.fromMap(doc.data(), doc.id))
  //           .toList());
  // }
  //stream gets all tags from firestore
  Stream<List<Tag>> getTags() {
    return FirebaseFirestore.instance.collection('tags').snapshots().map(
        (snapshot) => snapshot.docs
            .map<Tag>((doc) => Tag.fromMap(doc.data(), doc.id))
            .toList());
  }

  editEntry(
    id,
    restaurantName,
    restaurantAddress,
    restaurantWebsite,
      restaurantNumber,
      restaurantEntryDate,
    restaurantOpeningHours,
    List tagList,
    String restaurantNotes,
  ) {
    return FirebaseFirestore.instance.collection('places').doc(id).update({
      'name': restaurantName,
      'address': restaurantAddress,
      'website': restaurantWebsite,
      'number': restaurantNumber,
      'entryDate': restaurantEntryDate,
      'openingHours': restaurantOpeningHours,
      'tagList': tagList,
      'restaurantNotes': restaurantNotes,
    });
  }

  //checks for duplicate entries in firestore
  checkForDuplicate(name) {
    return FirebaseFirestore.instance
        .collection('places')
        .where('name', isEqualTo: name)
        .get()
        .then((QuerySnapshot snapshot) {
      if (snapshot.docs.isNotEmpty) {
        return true;
      } else {
        return false;
      }
    });
  }
}
