import 'package:flutter/material.dart';

const String ROUTE_HOME = "/";

const String ROUTE_WELCOME = "welcome";
const String ROUTE_SIGNIN = "/signin";
const String ROUTE_FORGOT_PASSWORD = "/login/forgot_password";
const String ROUTE_SIGNUP = "/signup";

const String ROUTE_CHOOSE_LOCATION = "choose_location";
const String ROUTE_CHANGE_LOCATION = "change_location";

class AppRouter {
  Route? generateRoute(RouteSettings settings) {
    print("Navigate to ${settings.name}");

    switch (settings.name) {
      default:
        return null;
    }
  }
}

class NoAnimationMaterialPageRoute<T> extends MaterialPageRoute {
  NoAnimationMaterialPageRoute({
    required WidgetBuilder builder,
    RouteSettings? settings,
    bool maintainState = false,
    bool fullscreenDialog = false,
  }) : super(
          builder: builder,
          settings: settings,
          maintainState: maintainState,
          fullscreenDialog: fullscreenDialog,
        );

  @override
  Duration get transitionDuration => const Duration(milliseconds: 0);

  @override
  Widget buildTransitions(_, __, ___, Widget child) {
    return child;
  }
}
