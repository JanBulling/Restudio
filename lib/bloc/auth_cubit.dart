import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:restudio_app/bloc/state.dart';
import 'package:restudio_app/config/failure.dart';
import 'package:restudio_app/data/services/auth_service.dart';

class PasswordResetSuccessfulState extends SuccessState {
  final String email;

  PasswordResetSuccessfulState({required this.email}) : super(email);
}

class UserLoggedInState extends SuccessState {
  final User user;

  UserLoggedInState({required this.user}) : super(user);
}

/// Auth Cubit
/// This class is for state management. To use this cubit, wrap the parent-widget in a
/// `BlocProvider` widget. Then call either `BlocConsumer`, `BlocListener`, or `BlocBuilder`.
/// To access the functions of this cubit, call `BlocProvider.of<AuthCubit>(context).();`
class AuthCubit extends Cubit<BlocState> {
  final AuthService _service;

  AuthCubit(this._service) : super(InitialState());

  ///This method calles the [signUpUser] method of the [AuthService]. If the registration
  ///was successful, the [UserLoggedIn]-State is emited with the current user as payload.
  ///
  ///If an error occured anywhere in the process, the [Error]-State is emitted with an readable error-message
  ///as payload.
  void signUpUser({required String email, required String password, required String name}) {
    emit(LoadingState());

    _service.signUp(email, password, name).then((user) => emit(UserLoggedInState(user: user))).catchError((err) {
      print(err);

      if (err is Failure)
        emit(ErrorState(message: err.message));
      else
        emit(ErrorState(message: err.toString()));
    });
  }

  ///This method calles the [logIn] method of the [AuthService]. If the logIn
  ///was successful, the [UserLoggedIn]-State is emited with the current user as payload.
  ///
  ///If an error occured anywhere in the process, the [Error]-State is emitted with an readable error-message
  ///as payload.
  void loginUser({required String email, required String password}) {
    emit(LoadingState());

    _service.logIn(email, password).then((user) => emit(UserLoggedInState(user: user))).catchError((err) {
      print(err);

      if (err is Failure)
        emit(ErrorState(message: err.message));
      else
        emit(ErrorState(message: err.toString()));
    });
  }

  ///This method calles the [signInAnonymously] method of the [AuthService]. If the anonymous login
  ///was successful, the [UserLoggedIn]-State is emited with the current user as payload.
  ///
  ///If an error occured anywhere in the process, the [Error]-State is emitted with an readable error-message
  ///as payload.
  void signInAnonymously() {
    emit(LoadingState());

    _service.signInAnonymously().then((user) => emit(UserLoggedInState(user: user))).catchError((err) {
      print(err.toString());

      if (err is Failure)
        emit(ErrorState(message: err.message));
      else
        emit(ErrorState(message: err.toString()));
    });
  }

  /// This method calls the [resetPassword] method of the [AuthService]. If an email was sent successfully
  /// to the given email address, the [PasswordResetSuccessful]-State is emitted with the current email.
  ///
  /// If an error occured anywhere in the process, the [Error]-State is emitted with an readable error-message
  /// as payload.
  void resetPassword({required String email}) {
    emit(LoadingState());

    _service.resetPassword(email).then((value) => emit(PasswordResetSuccessfulState(email: email))).catchError((err) {
      print(err.toString());

      if (err is Failure)
        emit(ErrorState(message: err.message));
      else
        emit(ErrorState(message: err.toString()));
    });
  }
}
