import 'package:firebase_auth/firebase_auth.dart';
import 'package:wardeleven/base/constants/network_constants.dart';
import 'package:wardeleven/base/error_handler.dart';
import 'package:wardeleven/base/failure_handler.dart';
import 'package:wardeleven/models/login_user_details_model.dart';
import 'package:wardeleven/models/response/login_user_response_model.dart';

class AuthRouting {
  static final AuthRouting _instance = AuthRouting._internal();

  factory AuthRouting() {
    return _instance;
  }

  AuthRouting._internal();

  final _errorHandler = ErrorHandler();

  ///signs in user with email and password
  Future<LoginUserResponseModel> loginUserWithEmailAndPassword(
      String email, String password) async {
    try {
      var userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      var name = userCredential.user?.displayName;
      var emailAddress = userCredential.user?.email;
      return LoginUserResponseModel(
          internalCode: NetworkConstants.successCode,
          message: 'User logged in.',
          userData: LoginUserDetailsModel(name, emailAddress));
    } on FirebaseAuthException catch (e) {
      _errorHandler.handleFirebaseError(e);
    } on Exception catch (e) {
      _errorHandler.handleError(e);
    }
    throw FailureHandler('unexpected error occurred');
  }

  Future<String?> get accessToken async =>
      await FirebaseAuth.instance.currentUser?.getIdToken(true);
}
