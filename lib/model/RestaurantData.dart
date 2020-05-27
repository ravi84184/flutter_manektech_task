class RestaurantData {
  String id;
  String name;
  String address;
  String description;
  String rating;
  String latitude;
  String longitude;
  String votes;
  String phoneNumbers;
  String photos_url;
  String thumb;


  RestaurantData.fromDatabaseJson(Map<String, dynamic> json) {
    id = json['id'].toString();
    name = json['name'];
    address = json['address'];
    description = json['description'];
    rating = json['rating'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    votes = json['votes'];
    phoneNumbers = json['phone_numbers'];
    photos_url = json['photos_url'];
    thumb = json['thumb']??"";
  }

  RestaurantData.fromAPIJson(Map<String, dynamic> json) {
    id = json['id'].toString();
    name = json['name'];
    address = json['location']['address']??""+json['location']['city']??"";
    description = json['timings'];
    rating = json['user_rating']['aggregate_rating']??"";
    votes = json['user_rating']['votes'];
    latitude = json['location']['latitude'];
    longitude = json['location']['longitude'];
    phoneNumbers = json['phone_numbers'];
    thumb = json['thumb'];
    photos_url = json['photos_url'];
  }
}
