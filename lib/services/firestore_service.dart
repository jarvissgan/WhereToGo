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
    String ids =
        FirebaseFirestore.instance.collection('places').doc().id.toString();
    return FirebaseFirestore.instance.collection('places').doc(ids).set({
      'id': ids,
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

  addList(String id, String listName) {
    return FirebaseFirestore.instance.collection('lists').add({
      'id': id,
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

  //stream gets all places from firestore
  Stream<List<Place>> getPlaces() {
    return FirebaseFirestore.instance.collection('places').get().asStream().map(
          (snapshot) => snapshot.docs
              .map((doc) => Place.fromMap(doc.data(), doc.id))
              .toList(),
        );
  }

  //stream gets all lists from firestore
  Stream<List<String>> getLists() {
    return FirebaseFirestore.instance.collection('lists').snapshots().map(
        (snapshot) => snapshot.docs
            .map<String>((doc) => doc.data()['listName'])
            .toList());
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
      restaurant,
      restaurantNumber,
      restaurantWebsite,
      checkState,
      restaurantPlaceId,
      restaurantOpeningHours) {
    return FirebaseFirestore.instance.collection('places').doc(id).update({
      'restaurantName': restaurantName,
      'restaurantAddress': restaurantAddress,
      'restaurant': restaurant,
      'restaurantNumber': restaurantNumber,
      'restaurantWebsite': restaurantWebsite,
      'checkState': checkState,
      'restaurantPlaceId': restaurantPlaceId,
      'restaurantOpeningHours': restaurantOpeningHours,
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
