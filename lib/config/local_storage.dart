import 'package:restudio_app/data/models/location.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalStorage {
  static final LocalStorage _instance = LocalStorage._privateConstructor();

  factory LocalStorage() {
    return _instance;
  }

  late SharedPreferences _prefs;

  LocalStorage._privateConstructor() {
    SharedPreferences.getInstance().then((prefs) {
      _prefs = prefs;
      print("Preferences initialized");
    });
  }

  void safeLocation(Location location) {
    _prefs.setString(Location.zipKey, location.zip);
    _prefs.setString(Location.cityKey, location.city);
    _prefs.setString(Location.districtKey, location.district);
    _prefs.setString(Location.stateKey, location.state);
    _prefs.setDouble(Location.latitudeKey, location.latitude);
    _prefs.setDouble(Location.longitudeKey, location.longitude);
  }

  Location getLocation() {
    return Location(
      zip: _prefs.getString(Location.zipKey) ?? "",
      city: _prefs.getString(Location.cityKey) ?? "",
      district: _prefs.getString(Location.districtKey) ?? "",
      state: _prefs.getString(Location.stateKey) ?? "",
      latitude: _prefs.getDouble(Location.latitudeKey) ?? 0.0,
      longitude: _prefs.getDouble(Location.longitudeKey) ?? 0.0,
    );
  }
}
