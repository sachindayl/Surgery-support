import 'package:firebase_auth/firebase_auth.dart';
import 'package:wardeleven/base/error_handler.dart';
import 'package:wardeleven/base/failure_handler.dart';
import 'package:wardeleven/models/enums.dart';

class AuthRouting {
  static final AuthRouting _instance = AuthRouting._internal();

  factory AuthRouting() {
    return _instance;
  }

  AuthRouting._internal();

  final _errorHandler = ErrorHandler();

  ///signs in user with email and password
  Future<DataState> loginUserWithEmailAndPassword(
      String email, String password) async {
    try {
      var userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      var name = userCredential.user?.displayName;
      var emailAddress = userCredential.user?.email;
      return DataState.success;
    } on FirebaseAuthException catch (e) {
      _errorHandler.handleFirebaseError(e);
    } on Exception catch (e) {
      _errorHandler.handleError(e);
    }
    throw FailureHandler('unexpected error occurred');
  }

  Future<String?> get accessToken async =>
      await FirebaseAuth.instance.currentUser?.getIdToken(true);

  Future<DataState> signOut() async {
    // await emptyStoredUserData();
    try {
      await FirebaseAuth.instance.signOut();
      return DataState.success;
    } on FirebaseAuthException catch (e) {
      _errorHandler.handleFirebaseError(e);
    } on Exception catch (e) {
      _errorHandler.handleError(e);
    }
    throw FailureHandler('unexpected error occurred');
  }
}
