import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:restudio_app/config/local_storage.dart';
import 'package:restudio_app/config/router.dart';
import 'package:restudio_app/config/theme.dart';
import 'package:restudio_app/injection_container.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  initInjection();

  LocalStorage();

  runApp(RestudioApp());
}

class RestudioApp extends StatelessWidget {
  final AppRouter router;

  RestudioApp({Key? key, AppRouter? appRouter})
      : router = appRouter ?? AppRouter(),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Restudio',
      debugShowCheckedModeBanner: false,
      theme: theme(),
      initialRoute: _getInitialRoute(),
      onGenerateRoute: router.generateRoute,
    );
  }

  /// Checks if the user is already logged and if he also has already choosen a location.
  /// Then the corresboning route to the current application status is returned.
  ///
  /// @return: eighter ROUTE_HOME (/), ROTE_WELCOME (welcome), ROUTE_CHOOSE_LOCATION (choose_location)
  String _getInitialRoute() {
    String initialRoute;

    if (FirebaseAuth.instance.currentUser == null) {
      initialRoute = ROUTE_WELCOME;

      SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(
          statusBarColor: Colors.white,
          statusBarIconBrightness: Brightness.dark,
          statusBarBrightness: Brightness.dark,
        ),
      );
    } else if (LocalStorage().getLocation().zip.isEmpty) {
      initialRoute = ROUTE_CHOOSE_LOCATION;

      SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(
          statusBarColor: Colors.white,
          statusBarIconBrightness: Brightness.dark,
          statusBarBrightness: Brightness.dark,
        ),
      );
    } else {
      initialRoute = ROUTE_HOME;

      SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(
          statusBarColor: theme().primaryColor,
          statusBarIconBrightness: Brightness.light,
          statusBarBrightness: Brightness.light,
        ),
      );
    }

    return initialRoute;
  }
}
