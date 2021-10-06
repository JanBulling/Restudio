import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:mongo_dart/mongo_dart.dart' as mongo;

class MongoDb {
  static mongo.Db? _db;
  static bool hasConnection = false;

  static Future<mongo.Db> getConntection() async {
    if (_db == null) {
      String userName = dotenv.env["MONGO_DB_USERNAME"] ?? "";
      String password = dotenv.env["MONGO_DB_PASSWORD"] ?? "";
      String cluster = dotenv.env["MONGO_DB_CLUSTER"] ?? "";
      String database = dotenv.env["MONGO_DB_DATABASE"] ?? "";

      String mongoConnectionUrl =
          "mongodb+srv://$userName:$password@$cluster.mongodb.net/$database?retryWrites=true&w=majority";

      _db = await mongo.Db.create(mongoConnectionUrl);

      hasConnection = true;

      return _db!;
    } else
      return _db!;
  }

  static mongo.Db instance() => _db!;
}
