import 'package:meta/meta.dart';
import 'package:mongo_dart/mongo_dart.dart';

@immutable
class Restaurant {
  final ObjectId id;
  final String name;
  final String description;
  final String category;
  final String address;
  final double latitude;
  final double longitude;
  final String phoneNumber;
  final String website;
  final List<String> tags;

  Restaurant({
    required this.id,
    required this.name,
    required this.description,
    required this.category,
    required this.address,
    required this.latitude,
    required this.longitude,
    required this.phoneNumber,
    required this.website,
    required this.tags,
  });

  factory Restaurant.fromJson(Map<String, dynamic> json) {
    Map<String, dynamic> addressJson = json["address"];
    String address = "${addressJson["street"] ?? ""}, ${addressJson["postal_code"] ?? ""} ${addressJson["city"] ?? ""}";

    return Restaurant(
      id: json["_id"] ?? "",
      name: json["name"] ?? "",
      description: json["description"] ?? "-",
      category: json["category"] ?? "-",
      address: address,
      latitude: json["location"]["latitude"] ?? 0,
      longitude: json["location"]["longitude"] ?? 0,
      phoneNumber: json["phone_number"] ?? "",
      website: json["website"] ?? "",
      tags: ((json["tags"] ?? []) as List).cast<String>(),
    );
  }
}
