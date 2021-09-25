import 'package:meta/meta.dart';

@immutable
abstract class State {}

class Initial extends State {}

class Loading extends State {}

class Error extends State {
  final String message;

  Error({required this.message});
}
