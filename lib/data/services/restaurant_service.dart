import 'package:mongo_dart/mongo_dart.dart';
import 'package:restudio_app/config/failure.dart';
import 'package:restudio_app/config/local_storage.dart';
import 'package:restudio_app/config/singletons/mongo_db_init.dart';
import 'package:restudio_app/data/models/restaurant.dart';

class RestaurantService {
  /// Returns a list of the newest added restaurants (at most [limit])
  /// in the area of [radius]-km around the approximate location of the user
  ///
  /// it executes the following queries on the database:
  ///
  /// Filter:
  /// {location: {$near: {
  ///     $maxDistance: 30000,
  ///     $geometry: {type: "Point", coordinates: [48.62321917876288, 10.170864341137598]}
  /// }}}
  ///
  /// Sort:
  /// {added: -1}
  ///
  Future<List<Restaurant>> getNewRestaurants([int limit = 6, double radius = 30]) async {
    try {
      final safedLocation = LocalStorage.getLocation();
      final location = {
        "type": "Point",
        "coordinates": [safedLocation.latitude, safedLocation.longitude]
      };

      final _db = await MongoDb.getConntection();
      await _db.open();

      final SelectorBuilder query =
          where.near("location", location, radius * 1000).sortBy("added", descending: true).limit(limit);

      final result = await _db.collection("restaurants").find(query).toList();

      await _db.close();

      final restaurants = result.map((restaurant) => Restaurant.fromJson(restaurant)).toList();

      return restaurants;
    } catch (err) {
      throw Failure("Fehler beim Abrufen der Restaurants", err);
    }
  }

  Future<Restaurant> getRestaurantById(ObjectId id) async {
    try {
      final _db = await MongoDb.getConntection();
      await _db.open();

      final result = await _db.collection("restaurants").findOne(where.id(id));

      await _db.close();

      final restaurant = Restaurant.fromJson(result ?? {});

      return restaurant;
    } catch (err) {
      throw Failure("Fehler beim Abrufen des Restaurants", err);
    }
  }

  Future<List<Restaurant>> searchRestaurantByName(String name, [int limit = 10, double radius = 30]) async {
    try {
      final safedLocation = LocalStorage.getLocation();
      final location = {
        "type": "Point",
        "coordinates": [safedLocation.latitude, safedLocation.longitude]
      };

      final _db = await MongoDb.getConntection();
      await _db.open();

      final SelectorBuilder query = where
          .near("location", location, radius * 1000)
          .match("name", ".*$name.*", caseInsensitive: true, dotAll: true)
          .limit(limit);

      final result = await _db.collection("restaurants").find(query).toList();

      print(result);

      await _db.close();

      final restaurants = result.map((restaurant) => Restaurant.fromJson(restaurant)).toList();

      return restaurants;
    } catch (err) {
      throw Failure("Fehler bei der Restaurant-Suche", err);
    }
  }
}
