import 'package:fluttermanektechtask/model/RestaurantData.dart';

import 'database_creator.dart';

class RepositoryService {
  static Future<List<RestaurantData>> getAllRestaurants() async {
    final sql = '''SELECT * FROM ${DatabaseCreator.restaurantsTable}''';
    final data = await db.rawQuery(sql);

    List<RestaurantData> list = new List();

    for (final node in data) {
      final restaurant = RestaurantData.fromDatabaseJson(node);
      list.add(restaurant);
    }
    return list;
  }

  static Future<List<RestaurantData>> getRestaurants(offset) async {
    final sql = '''SELECT * FROM ${DatabaseCreator.restaurantsTable} ORDER BY ${DatabaseCreator.id} LIMIT 10 offset $offset''';
    final data = await db.rawQuery(sql);

    List<RestaurantData> list = new List();

    for (final node in data) {
      final restaurant = RestaurantData.fromDatabaseJson(node);
      list.add(restaurant);
    }
    return list;
  }

//  static Future<RestaurantData> getRestaurants(int id) async {
//    final sql = '''SELECT * FROM ${DatabaseCreator.restaurantsTable}
//      WHERE ${DatabaseCreator.id} == $id''';
//    final data = await db.rawQuery(sql);
//
//    final restaurant = RestaurantData.fromDatabaseJson(data[0]);
//    return restaurant;
//  }

  static Future<bool> addAllRestaurants(List<RestaurantData> list) async {
    for(RestaurantData model in list){
      addRestaurants(model);
    }
    return await true;
  }

  static Future<void> addRestaurants(RestaurantData restaurant) async {
    final sql = '''INSERT INTO ${DatabaseCreator.restaurantsTable}
    (
      ${DatabaseCreator.id},
      ${DatabaseCreator.name},
      ${DatabaseCreator.address},
      ${DatabaseCreator.description},
      ${DatabaseCreator.rating},
      ${DatabaseCreator.latitude},
      ${DatabaseCreator.longitude},
      ${DatabaseCreator.votes},
      ${DatabaseCreator.phone_numbers},
      ${DatabaseCreator.thumb},
      ${DatabaseCreator.photos_url}
    ) VALUES (?,?,?,?,?,?,?,?,?,?,?)''';
    List<dynamic> params = [
      restaurant.id,
      restaurant.name,
      restaurant.address,
      restaurant.description,
      restaurant.rating,
      restaurant.latitude,
      restaurant.longitude,
      restaurant.votes,
      restaurant.phoneNumbers,
      restaurant.thumb,
      restaurant.photos_url
    ];
    final result = await db.rawInsert(sql, params);
    DatabaseCreator.databaseLog('Add restaurant', sql, null, result, params);
  }


  static Future<void> deleteRestaurants(RestaurantData restaurant) async {
    final sql = '''UPDATE ${DatabaseCreator.restaurantsTable}
    WHERE ${DatabaseCreator.id} == ${restaurant.id}''';
    final result = await db.rawUpdate(sql);
    DatabaseCreator.databaseLog("Delete restaurant", sql, null, result);
  }

  static Future<int> restaurantsCount() async {
    final data = await db.rawQuery(
        '''SELECT COUNT(*) FROM ${DatabaseCreator.restaurantsTable}''');

    int count = data[0].values.elementAt(0);
    return count;
  }
}
