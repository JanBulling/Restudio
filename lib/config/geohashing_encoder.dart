import 'package:restudio_app/config/failure.dart';

String createGeoHash(double latitude, double longitude, int precisionLevel) {
  String geoHash = "";

  int bit = 0;
  bool evenBit = true;
  int hashValue = 0; // index for the BASE32-Map
  double maxLatitude = 90, minLatitude = -90;
  double maxLongitude = 180, minLonngitude = -180;

  while (geoHash.length < precisionLevel) {
    if (evenBit) {
      // E-W - longitude
      double lngMid = (maxLongitude + minLonngitude) / 2;
      if (longitude > lngMid) {
        hashValue = (hashValue << 1) + 1;
        minLonngitude = lngMid;
      } else {
        hashValue = (hashValue << 1) + 0;
        maxLongitude = lngMid;
      }
    } else {
      // N-S - latitude
      double latMid = (maxLatitude + minLatitude) / 2;
      if (latitude > latMid) {
        hashValue = (hashValue << 1) + 1;
        minLatitude = latMid;
      } else {
        hashValue = (hashValue << 1) + 0;
        maxLatitude = latMid;
      }
    }

    evenBit = !evenBit;

    if (++bit == 5) {
      //5 bits give a character of the geohash
      geoHash += _base32CharAt(hashValue);
      bit = 0;
      hashValue = 0;
    }
  }

  return geoHash;
}

/// List of the geoHashes adjacent at the north, south, east and west
/// Order: n, e, s, w
///
/// return: List (size: 4) of geohases
List<String> neighbourHashes(String geoHash) {
  return [
    _adjacentGeoHash(geoHash, "n"),
    _adjacentGeoHash(geoHash, "e"),
    _adjacentGeoHash(geoHash, "s"),
    _adjacentGeoHash(geoHash, "w"),
  ];
}

/// List of all the adjacent geoHashes from the center-has
/// Order: n, ne, e, se, s, sw, w, nw
///
/// return: List (size: 8) of geohashes
List<String> allNeighbourHashes(String geoHash) {
  return [
    _adjacentGeoHash(geoHash, "n"),
    _adjacentGeoHash(_adjacentGeoHash(geoHash, "n"), "e"),
    _adjacentGeoHash(geoHash, "e"),
    _adjacentGeoHash(_adjacentGeoHash(geoHash, "s"), "e"),
    _adjacentGeoHash(geoHash, "s"),
    _adjacentGeoHash(_adjacentGeoHash(geoHash, "s"), "w"),
    _adjacentGeoHash(geoHash, "w"),
    _adjacentGeoHash(_adjacentGeoHash(geoHash, "n"), "w"),
  ];
}

String _adjacentGeoHash(String geoHash, String direction) {
  geoHash = geoHash.toLowerCase();
  direction = direction.toLowerCase();

  if (geoHash.length == 0) throw Failure("Invalid GeoHash");
  if ("nsew".indexOf(direction) == -1) throw Failure("Invalid direction");

  const neighbour = {
    "n": ["p0r21436x8zb9dcf5h7kjnmqesgutwvy", "bc01fg45238967deuvhjyznpkmstqrwx"],
    "s": ["14365h7k9dcfesgujnmqp0r2twvyx8zb", "238967debc01fg45kmstqrwxuvhjyznp"],
    "e": ["bc01fg45238967deuvhjyznpkmstqrwx", "p0r21436x8zb9dcf5h7kjnmqesgutwvy"],
    "w": ["238967debc01fg45kmstqrwxuvhjyznp", "14365h7k9dcfesgujnmqp0r2twvyx8zb"],
  };

  const borders = {
    "n": ["prxz", "bcfguvyz"],
    "s": ["028b", "0145hjnp"],
    "e": ["bcfguvyz", "prxz"],
    "w": ["0145hjnp", "028b"],
  };

  String lastCharacter = geoHash[geoHash.length - 1];
  String parent = geoHash.substring(0, geoHash.length - 2);

  int type = geoHash.length % 2;

  if (borders[direction]![type].indexOf(lastCharacter) != -1 && parent != "") {
    parent = _adjacentGeoHash(parent, direction);
  }

  return parent + _base32CharAt(neighbour[direction]![type].indexOf(lastCharacter));
}

String _base32CharAt(int index) {
  return '0123456789bcdefghjkmnpqrstuvwxyz'[index];
}
