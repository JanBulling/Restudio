import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:restudio_app/data/models/location.dart';
import '../../config/failure.dart';

class LocationService {
  LocationService(this._dio);

  final Dio _dio;

  final String _baseUrl = "https://public.opendatasoft.com/api/records/1.0/search";
  final String _urlArgs = "?dataset=georef-germany-postleitzahl&lang=de&rows=1";

  Future<Location> getLocation(String zip) async {
    final url = _baseUrl + _urlArgs + "&q=$zip";

    print("Making get-request to $url");

    try {
      final urlEncode = Uri.encodeFull(url);

      final response = await _dio.get(urlEncode);

      if (response.statusCode == 200)
        return Location.fromJson(jsonDecode(response.data));
      else
        throw Failure(
          "Fehler beim Abrufen der Postleitzahl.",
          "Status code: ${response.statusCode}, body: ${response.data}",
        );
    } on DioError catch (err) {
      throw Failure("Fehler beim Abrufen der Postleitzahl.", err);
    } on SocketException catch (err) {
      throw Failure("Keine Verbindung möglich.", err);
    } on Failure {
      rethrow;
    } catch (err) {
      throw Failure("Etwas ist schief gelaufen. Bitte versuchen Sie es erneut.", err);
    }
  }
}
