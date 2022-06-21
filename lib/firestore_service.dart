import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  addEntry(restaurantName, restaurantAddress, restaurant, restaurantNumber,
      restaurantWebsite, restaurantPlaceId, restaurantOpeningHours) {
    return FirebaseFirestore.instance
        .collection('restaurants')
        .add({
      'restaurantName': restaurantName,
      'restaurantAddress': restaurantAddress,
      'restaurant': restaurant,
      'restaurantNumber': restaurantNumber,
      'restaurantWebsite': restaurantWebsite,
      'restaurantPlaceId': restaurantPlaceId,
      'restaurantOpeningHours': restaurantOpeningHours,
    });
  }
  removeEntry(id){
    return FirebaseFirestore.instance
        .collection('restaurants')
        .doc(id)
        .delete();
  }
  Stream<List<dynamic>> getRestaurants() {
    return FirebaseFirestore.instance
        .collection('restaurants')
        .snapshots()
        .map((snapshot) => snapshot.docs.map((doc) => doc.data()).toList());
  }
  editEntry(id, restaurantName, restaurantAddress, restaurant, restaurantNumber,
      restaurantWebsite, restaurantPlaceId, restaurantOpeningHours) {
    return FirebaseFirestore.instance
        .collection('restaurants')
        .doc(id)
        .update({
      'restaurantName': restaurantName,
      'restaurantAddress': restaurantAddress,
      'restaurant': restaurant,
      'restaurantNumber': restaurantNumber,
      'restaurantWebsite': restaurantWebsite,
      'restaurantPlaceId': restaurantPlaceId,
      'restaurantOpeningHours': restaurantOpeningHours,
    });
  }
}
