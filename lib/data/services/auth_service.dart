import 'package:firebase_auth/firebase_auth.dart';
import '../../../config/failure.dart';

class AuthService {
  AuthService(this._auth) {
    print("Initialize [AuthService]");
  }

  final FirebaseAuth _auth;

  /// This method tries to login tothe account with the given email and the password.
  ///
  /// if an error occures or if the given data is in a wrong format, an [AuthException] is
  /// thrown.
  ///
  /// On success, the [User] is returned.
  ///
  /// At a later point in time, the currently logged in [User] can be retrieved synchronously
  /// with "final User user = FirebaseAuth.instance.currentUser;". If no user is signed in, `null` is returned.
  Future<User> logIn(String email, String password) async {
    //if (!validateEmail(email)) throw new AuthException("Bitte geben Sie eine gültige E-Mail Adresse an.", null);

    try {
      final credential = await _auth.signInWithEmailAndPassword(email: email.trim(), password: password.trim());
      final user = credential.user;

      if (user == null) throw new Failure("Die Anmeldung konnte nicht durchgeführt werden. Haben Sie Internet?");

      return user;
    } on FirebaseAuthException catch (err) {
      switch (err.code) {
        case 'invalid-email':
          throw new Failure("Bitte geben Sie eine gültige E-Mail Adresse an", err);
        case 'user-disabled':
          throw new Failure("Dieser Benutzer ist zur Zeit gesperrt. Bitte wenden Sie sich an den Support", err);
        case 'user-not-found':
          throw new Failure("Es existiert kein Account mit dieser E-Mail Adresse", err);
        case 'wrong-password':
          throw new Failure("Das Passwort war nicht korrekt", err);
        default:
          throw new Failure("Etwas ist schief gelaufen. Bitte vesuchen Sie es erneut", err);
      }
    } catch (err) {
      throw new Failure("Die Anmeldung konnte nicht durchgeführt werden. Haben Sie Internet?", err);
    }
  }

  /// This method sends a password-reset-email to the given email address.
  ///
  /// if an error occures or if the given data is in a wrong format, an [AuthException] is
  /// thrown.
  ///
  /// On success, [void] is returned
  Future<void> resetPassword(String email) async {
    //if (!validateEmail(email)) throw new AuthException("Bitte geben Sie eine gültige E-Mail Adresse an.", null);

    try {
      await _auth.sendPasswordResetEmail(email: email);
    } on FirebaseAuthException catch (err) {
      switch (err.code) {
        case 'invalid-email':
          throw new Failure("Bitte geben Sie eine gültige E-Mail Adresse an", err);
        case 'user-not-found':
          throw new Failure("Es existiert kein Account mit dieser E-Mail Adresse", err);
        default:
          throw new Failure("Etwas ist schief gelaufen. Bitte vesuchen Sie es erneut", err);
      }
    } catch (err) {
      throw new Failure("Passwort konnte nicht zurückgesetzt werden. Haben Sie Internet?", err);
    }
  }

  /// This method tries to create a new firebase user with the given email and the password.
  /// Then it assosiates the name of the user with the firebase user.
  ///
  /// if an error occures or if the given data is in a wrong format, an [AuthException] is
  /// thrown.
  ///
  /// On success, the [User] is returned.
  ///
  /// At a later point in time, the currently logged in [User] can be retrieved synchronously
  /// with "final User user = FirebaseAuth.instance.currentUser;". If no user is signed in, `null` is returned.
  Future<User> signUp(String email, String password, String name) async {
    //if (!validateEmail(email)) throw new AuthException("Bitte geben Sie eine gültige E-Mail Adresse an.", null);
    //if (!validatePassword(password)) throw new AuthException("Das Passwort muss mindestens 6 Zeichen lang sein", null);
    if (name.trim().isEmpty) throw new Failure("Bitte geben Sie ihren Namen ein");

    try {
      final credential = await _auth.createUserWithEmailAndPassword(email: email.trim(), password: password.trim());
      final user = credential.user;

      if (user == null) throw new Failure("Die Anmeldung konnte nicht durchgeführt werden. Haben Sie Internet?", null);

      await user.updateDisplayName(name);

      return user;
    } on FirebaseException catch (err) {
      switch (err.code) {
        case 'invalid-email':
          throw new Failure("Bitte geben Sie eine gültige E-Mail Adresse an", err);
        case 'email-already-in-use':
          throw new Failure("Es existiert bereits ein Account mit dieser E-Mail Adresse", err);
        case 'weak-password':
          throw new Failure("Bitte verwenden Sie ein stärkeres Passwort", err);
        case 'operation-not-allowed':
          throw new Failure("Es konnte kein Account angelget werden. Bitte wernden Sie sich an den Support", err);
        default:
          throw new Failure("Etwas ist schief gelaufen. Bitte vesuchen Sie es erneut", err);
      }
    } catch (err) {
      throw new Failure("Die Anmeldung konnte nicht durchgeführt werden. Haben Sie Internet?", err);
    }
  }

  /// This method tries to create a new anonymous firebase user.
  /// The user is marked as anonymous. So "user.isAnonymous" returns true.
  ///
  /// if an error occures or if the given data is in a wrong format, an [AuthException] is
  /// thrown.
  ///
  /// On success, the [User] is returned.
  ///
  /// At a later point in time, the currently logged in [User] can be retrieved synchronously
  /// with "final User user = FirebaseAuth.instance.currentUser;". If no user is signed in, `null` is returned.
  Future<User> signInAnonymously() async {
    try {
      final credential = await _auth.signInAnonymously();
      final user = credential.user;

      if (user == null) throw new Failure("Die Anmeldung konnte nicht durchgeführt werden. Haben Sie Internet?");

      return user;
    } on FirebaseException catch (err) {
      switch (err.code) {
        case 'operation-not-allowed':
          throw new Failure("Es konnte kein Account angelget werden. Bitte wernden Sie sich an den Support", err);
        default:
          throw new Failure("Etwas ist schief gelaufen. Bitte vesuchen Sie es erneut", err);
      }
    } catch (err) {
      throw new Failure("Die Anmeldung konnte nicht durchgeführt werden. Haben Sie Internet?", err);
    }
  }

  Future<void> signOut() async {
    try {
      await _auth.signOut();
    } catch (err) {
      throw new Failure("Benutzer konnte nicht abgemeldet werden. Haben Sie Internet?", err);
    }
  }
}
