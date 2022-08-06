import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:jarlist/models/list.dart';
import 'package:jarlist/models/tag.dart';
import 'package:jarlist/services/auth_service.dart';

import '../models/place.dart';

class FirestoreService {
  // String uid = FirestoreService.uid;
  String idPlace =
      FirebaseFirestore.instance.collection('places').doc().id.toString();

  // String idLists = FirebaseFirestore.instance.collection('users').doc().collection('lists').doc().id.toString();

  String getIDPlace(uid) {
    return FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .collection('places')
        .doc()
        .id
        .toString();
  }

  String getIDList(uid) {
    return FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .collection('lists')
        .doc()
        .id
        .toString();
  }

  String getIDTag(uid) {
    return FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .collection('tags')
        .doc()
        .id
        .toString();
  }

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

    AuthService authService = AuthService();
    String uid = authService.getCurrentUserUID();
    String id = getIDPlace(uid);

    return FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .collection('places')
        .doc(id)
        .set({
      'id': id,
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

  addList(String listName) {
    AuthService authService = AuthService();
    String uid = authService.getCurrentUserUID();

    String id = getIDList(uid);

    return FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .collection('lists')
        .doc(id)
        .set({
      'id': id,
      'listName': listName,
    });
  }

  changeCheckState(documentID, checkState) {
    AuthService authService = AuthService();
    String uid = authService.getCurrentUserUID();
    String id = getIDPlace(uid);

    return FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .collection('places')
        .doc(documentID)
        .update({'checkState': checkState});
  }

  // removeEntry(id) {
  //   AuthService authService = AuthService();
  //   String uid = authService.getCurrentUserUID();
  //
  //   return FirebaseFirestore.instance
  //       .collection('users')
  //       .doc(uid)
  //       .collection('places')
  //       .doc(id).delete();
  // }

  //removeEntry with documentID
  removeEntryWithDocumentID(documentID) {
    AuthService authService = AuthService();
    String uid = authService.getCurrentUserUID();

    return FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .collection('places')
        .doc(documentID)
        .delete();
  }

  //removeList with documentID
  removeListWithDocumentID(documentID) {
    AuthService authService = AuthService();
    String uid = authService.getCurrentUserUID();

    return FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .collection('lists')
        .doc(documentID)
        .delete();
  }

  //stream gets all places from firestore
  Stream<List<Place>> getPlaces() {
    AuthService authService = AuthService();
    String uid = authService.getCurrentUserUID();

    return FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .collection('places')
        .get()
        .asStream()
        .map(
          (snapshot) => snapshot.docs
              .map((doc) => Place.fromMap(doc.data(), doc.id))
              .toList(),
        );
  }

  //stream gets all lists from firestore
  Stream<List<Lists>> getLists() {
    AuthService authService = AuthService();
    String uid = authService.getCurrentUserUID();

    return FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .collection('lists')
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map<Lists>((doc) => Lists.fromMap(doc.data(), doc.id))
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
    AuthService authService = AuthService();
    String uid = authService.getCurrentUserUID();

    return FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .collection('tags')
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map<Tag>((doc) => Tag.fromMap(doc.data(), doc.id))
            .toList());
  }

  String idTags =
      FirebaseFirestore.instance.collection('tags').doc().id.toString();

  createTag(String tagName) {
    AuthService authService = AuthService();
    String uid = authService.getCurrentUserUID();

    String id = getIDTag(uid);

    return FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .collection('tags')
        .doc(id)
        .set({
      'tagName': tagName,
    });
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
    AuthService authService = AuthService();
    String uid = authService.getCurrentUserUID();

    return FirebaseFirestore.instance.collection('users').doc(uid).collection('places').doc(getIDPlace(uid)).update({
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
    AuthService authService = AuthService();
    String uid = authService.getCurrentUserUID();

    // print(uid + 'UID');
    return FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
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

  //creates user in firestore and related collections
  createUser(String id, String email, String name) {

    return FirebaseFirestore.instance.collection('users').doc(id).set({
      'id': id,
      'email': email,
      'name': name,
    });

  }
  onUserCreated(uid){
    FirebaseFirestore.instance.collection('users').doc(uid).collection('places').doc().set({});
    FirebaseFirestore.instance.collection('users').doc(uid).collection('lists').doc().set({});
    FirebaseFirestore.instance.collection('users').doc(uid).collection('tags').doc().set({});
  }
  deleteCreated(uid){
    //deletes blank entries
    FirebaseFirestore.instance.collection('users').doc(uid).collection('places').doc().get().then((snapshot){
      if(snapshot.exists){
        snapshot.reference.delete();
      }
    });
    FirebaseFirestore.instance.collection('users').doc(uid).collection('lists').doc().get().then((snapshot){
      if(snapshot.exists){
        snapshot.reference.delete();
      }

    });
    FirebaseFirestore.instance.collection('users').doc(uid).collection('tags').doc().get().then((snapshot){
      if(snapshot.exists){
        snapshot.reference.delete();
      }
    });
  }

  //deletes user from firestore and related collections
  deleteUser(String id) {
    return FirebaseFirestore.instance.collection('users').doc(id).delete();
  }

}
