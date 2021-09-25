import 'package:meta/meta.dart';
import '../../config/failure.dart';

@immutable
class Location {
  final String zip;
  final String city;
  final String district;
  final String state;
  final double latitude;
  final double longitude;

  Location({
    required this.zip,
    required this.city,
    required this.district,
    required this.state,
    required this.latitude,
    required this.longitude,
  });

  factory Location.fromJson(Map<String, dynamic> json) {
    try {
      final Map<String, dynamic> zipData = json["records"][0]["fields"];

      final double lat = zipData["geo_point_2d"][0];
      final double lng = zipData["geo_point_2d"][1];
      return Location(
        zip: zipData["name"],
        city: zipData["plz_name"],
        district: zipData["krs_name"],
        state: zipData["lan_name"],
        latitude: lat,
        longitude: lng,
      );
    } on RangeError catch (e) {
      throw Failure("Postleitzahl existiert nicht", e);
    } catch (e) {
      throw Failure("Konnte Postleitzahl-Daten nicht laden", e);
    }
  }
}
