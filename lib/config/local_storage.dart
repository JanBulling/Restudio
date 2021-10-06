import 'package:restudio_app/data/models/location.dart';
import 'package:restudio_app/main.dart';

class LocalStorage {
  static void safeLocation(Location location) {
    prefs.setString(Location.zipKey, location.zip);
    prefs.setString(Location.cityKey, location.city);
    prefs.setString(Location.districtKey, location.district);
    prefs.setString(Location.stateKey, location.state);
    prefs.setDouble(Location.latitudeKey, location.latitude);
    prefs.setDouble(Location.longitudeKey, location.longitude);
  }

  static Location getLocation() {
    return Location(
      zip: prefs.getString(Location.zipKey) ?? "",
      city: prefs.getString(Location.cityKey) ?? "",
      district: prefs.getString(Location.districtKey) ?? "",
      state: prefs.getString(Location.stateKey) ?? "",
      latitude: prefs.getDouble(Location.latitudeKey) ?? 0.0,
      longitude: prefs.getDouble(Location.longitudeKey) ?? 0.0,
    );
  }
}
