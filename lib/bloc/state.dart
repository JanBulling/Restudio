import 'package:meta/meta.dart';

@immutable
abstract class BlocState {}

class InitialState extends BlocState {}

class LoadingState extends BlocState {}

class ErrorState extends BlocState {
  final String message;

  ErrorState({required this.message});
}

class SuccessState extends BlocState {
  final Object? data;

  SuccessState([this.data]);
}
