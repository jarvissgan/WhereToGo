class CreateEntry {
  Map<String, dynamic> json;
  String formattedAddress = '',
      formattedPhoneNumber = '',
      name = '',
      placeId = '',
      website = '';

  List<dynamic> openingHours = [];
  List<dynamic> photos = [];
  double rating = 0;

  CreateEntry(this.json);

  //returns details of location
  String extractAddress() {
    return json['result']['formatted_address'] as String;
  }

  String extractPhone() {
    return json['result']['formatted_phone_number'] as String;
  }

  String extractName() {
    return json['result']['name'] as String;
  }

  double extractRating() {
    return json['result']['rating'] as double;
  }

  String extractPlaceId() {
    return json['result']['place_id'] as String;
  }

  String extractWebsite() {
    return json['result']['website'] as String;
  }

  List<dynamic> extractOpeningHours() {
    return json['result']['opening_hours']['weekday_text'] as List<dynamic>;
  }

  List<dynamic> extractPhotos() {
    //do future work to get multiple photos
    return json['result']['photos'] as List<dynamic>;
  }
}
