import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../config/failure.dart';
import '../data/services/auth_service.dart';

import 'state.dart';

class PasswordResetSuccessful extends State {
  final String email;

  PasswordResetSuccessful({required this.email});
}

class UserLoggedIn extends State {
  final User user;

  UserLoggedIn({required this.user});
}

/// Auth Cubit
/// This class is for state management. To use this cubit, wrap the parent-widget in a
/// `BlocProvider` widget. Then call either `BlocConsumer`, `BlocListener`, or `BlocBuilder`.
/// To access the functions of this cubit, call `BlocProvider.of<AuthCubit>(context).();`
class AuthCubit extends Cubit<State> {
  final AuthService _service;

  AuthCubit(this._service) : super(Initial());

  ///This method calles the [signUpUser] method of the [AuthService]. If the registration
  ///was successful, the [UserLoggedIn]-State is emited with the current user as payload.
  ///
  ///If an error occured anywhere in the process, the [Error]-State is emitted with an readable error-message
  ///as payload.
  void signUpUser(String email, String password, String name) {
    emit(Loading());

    _service.signUp(email, password, name).then((user) => emit(UserLoggedIn(user: user))).catchError((err) {
      print(err);

      if (err is Failure)
        emit(Error(message: err.message));
      else
        emit(Error(message: err.toString()));
    });
  }

  ///This method calles the [logIn] method of the [AuthService]. If the logIn
  ///was successful, the [UserLoggedIn]-State is emited with the current user as payload.
  ///
  ///If an error occured anywhere in the process, the [Error]-State is emitted with an readable error-message
  ///as payload.
  void loginUser(String email, String password) {
    emit(Loading());

    _service.logIn(email, password).then((user) => emit(UserLoggedIn(user: user))).catchError((err) {
      print(err);

      if (err is Failure)
        emit(Error(message: err.message));
      else
        emit(Error(message: err.toString()));
    });
  }

  ///This method calles the [signInAnonymously] method of the [AuthService]. If the anonymous login
  ///was successful, the [UserLoggedIn]-State is emited with the current user as payload.
  ///
  ///If an error occured anywhere in the process, the [Error]-State is emitted with an readable error-message
  ///as payload.
  void signInAnonymously() {
    emit(Loading());

    _service.signInAnonymously().then((user) => emit(UserLoggedIn(user: user))).catchError((err) {
      print(err.toString());

      if (err is Failure)
        emit(Error(message: err.message));
      else
        emit(Error(message: err.toString()));
    });
  }

  /// This method calls the [resetPassword] method of the [AuthService]. If an email was sent successfully
  /// to the given email address, the [PasswordResetSuccessful]-State is emitted with the current email.
  ///
  /// If an error occured anywhere in the process, the [Error]-State is emitted with an readable error-message
  /// as payload.
  void resetPassword(String email) {
    emit(Loading());

    _service.resetPassword(email).then((value) => emit(PasswordResetSuccessful(email: email))).catchError((err) {
      print(err.toString());

      if (err is Failure)
        emit(Error(message: err.message));
      else
        emit(Error(message: err.toString()));
    });
  }
}
