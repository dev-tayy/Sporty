import 'package:firebase_auth/firebase_auth.dart';
import 'exception_handler.dart';

class AuthenticationService {
  FirebaseAuth _auth = FirebaseAuth.instance;
  late AuthResultStatus _status;

  Future<AuthResultStatus> logIn({
    required String email,
    required String password,
  }) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);

      _status = AuthResultStatus.successful;
    } catch (e) {
      print('Exception @login: $e');
      _status = AuthExceptionHandler.handleException(e);
    }
    return _status;
  }

  Future<AuthResultStatus> createAccount({
    required String email,
    required String password,
    required String username,
  }) async {
    try {
      UserCredential newUser = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      _auth.currentUser!.updateDisplayName(username);

      newUser.user!.sendEmailVerification();

      _status = AuthResultStatus.successful;
    } catch (e) {
      print('Exception @createAccount: $e');
      _status = AuthExceptionHandler.handleException(e);
    }
    return _status;
  }

  Future<AuthResultStatus> resetPassword({required String email}) async {
    await _auth
        .sendPasswordResetEmail(email: email)
        .then((value) => _status = AuthResultStatus.successful)
        .catchError((e) => _status = AuthExceptionHandler.handleException(e));

    return _status;
  }

  Future<void> logout() async {
    await _auth.signOut();
  }
}
