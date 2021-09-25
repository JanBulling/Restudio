import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:kiwi/kiwi.dart';
import 'package:restudio_app/data/services/auth_service.dart';
import 'package:restudio_app/data/services/location_service.dart';

KiwiContainer inject = KiwiContainer();

void initInjection() {
  //+ extern singletons
  inject.registerSingleton<FirebaseAuth>((c) => FirebaseAuth.instance);
  inject.registerSingleton<Dio>((c) => Dio());

  //+ register services and repositories
  // AuthService for performing firebase authentication
  inject.registerFactory<AuthService>(
    (c) => AuthService(c.resolve<FirebaseAuth>()),
  );
  // LocationService for getting the approximate location from a zip code
  inject.registerFactory<LocationService>(
    (c) => LocationService(c.resolve<Dio>()),
  );
}
