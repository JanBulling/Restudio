import 'package:meta/meta.dart';

import 'package:restudio_app/config/failure.dart';

@immutable
class Location {
  static final String zipKey = "prefs_location_zip";
  static final String cityKey = "prefs_location_city";
  static final String districtKey = "prefs_location_district";
  static final String stateKey = "prefs_location_state";
  static final String latitudeKey = "prefs_location_latitude";
  static final String longitudeKey = "prefs_location_longitude";

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
      throw Failure("Diese Postleitzahl existiert nicht", e);
    } catch (e) {
      throw Failure("Konnte Standort-Daten nicht laden", e);
    }
  }
}


/* *********** RAW JSON RESPONSE *************************

{
    "nhits": 2,
    "parameters": {
        "dataset": "georef-germany-postleitzahl",
        "timezone": "UTC",
        "q": "89542",
        "rows": 1,
        "start": 0,
        "format": "json",
        "lang": "de"
    },
    "records": [
        {
            "datasetid": "georef-germany-postleitzahl",
            "recordid": "c807faf08bf4499680678290faa4a8bcaa76f84d",
            "fields": {
                "plz_name_long": "89542 Herbrechtingen",
                "lan_code": "08",
*               "name": "89542",
                "geometry": {
                    "type": "Polygon",
                    "coordinates": []
                },
*               "lan_name": "Baden-Württemberg",
                "geo_point_2d": [
*                   48.6290122702,
*                   10.1557839572
                ],
*               "krs_name": "Landkreis Heidenheim",
                "plz_code": "89542",
                "krs_code": "08135",
*               "plz_name": "Herbrechtingen"
            },
            "geometry": {
                "type": "Point",
                "coordinates": [
                    10.1557839572,
                    48.6290122702
                ]
            },
            "record_timestamp": "2020-09-16T14:54:18.126000+00:00"
        }
    ]
}

*/