import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:jarlist/models/list.dart';
import 'package:jarlist/models/tag.dart';

import '../models/place.dart';

class FirestoreService {
  addPlace(
      listName,
      placeID,
      restaurantName,
      restaurantAddress,
      restaurantPhone,
      restaurantWebsite,
      checkState,
      List<dynamic> restaurantOpeningHours,
      List<String> photoReferences) {
    return FirebaseFirestore.instance.collection('places').add({
      'listName': listName,
      'placeID': placeID,
      'name': restaurantName,
      'address': restaurantAddress,
      'number': restaurantPhone,
      'website': restaurantWebsite,
      'checkState': checkState,
      'openingHours': restaurantOpeningHours,
      'photoReferences': photoReferences,
    });
  }

  changeCheckState(placeID, checkState) {
    return FirebaseFirestore.instance
        .collection('places')
        .doc(placeID)
        .update({'checkState': checkState});
  }

  removeEntry(id) {
    return FirebaseFirestore.instance.collection('places').doc(id).delete();
  }

  //removeEntry with entry name
  removeEntryWithName(name) {
    return FirebaseFirestore.instance
        .collection('places')
        .where('name', isEqualTo: name)
        .get()
        .then((QuerySnapshot snapshot) {
      snapshot.docs.forEach((doc) {
        doc.reference.delete();
      });
    });
  }

  //stream gets all places from firestore
  Stream<List<Place>> getPlaces() {
    return FirebaseFirestore.instance.collection('places').snapshots().map(
        (snapshot) => snapshot.docs
            .map<Place>((doc) => Place.fromMap(doc.data(), doc.id))
            .toList());
  }

  //stream gets all lists from firestore
  Stream<List<Lists>> getLists() {
    return FirebaseFirestore.instance.collection('lists').snapshots().map(
        (snapshot) => snapshot.docs
            .map<Lists>((doc) => Lists.fromMap(doc.data(), doc.id))
            .toList());
  }

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
}
