import 'package:flutter/foundation.dart';
import 'package:wardeleven/base/base_viewmodel_contract.dart';
import 'package:wardeleven/base/constants/constants.dart';
import 'package:wardeleven/base/failure_handler.dart';
import 'package:wardeleven/models/enums.dart';
import 'package:wardeleven/services/firebase/firebase_service.dart';

class LoginViewModel with ChangeNotifier implements BaseViewModelContract {
  var _isLoading = LoadingState.initial;
  FailureHandler? _failure;
  var _isLoggedIn = DataState.initial;
  var _isSignedOut = DataState.initial;

  Future<void> loginWithEmailPassword(String email, String password) async {
    try {
      var loggedIn = await FirebaseService()
          .auth
          .loginUserWithEmailAndPassword(email, password);
      setIsLoggedIn(loggedIn);
    } on FailureHandler catch (e) {
      setFailure(e);
    }
  }

  Future<void> signOutUser() async {
    try {
      var signedOut = await FirebaseService().auth.signOut();
      setSignedOut(signedOut);
    } on FailureHandler catch (e) {
      setFailure(e);
    }
  }

  @override
  FailureHandler? get failure => _failure;

  @override
  LoadingState get loadingState => _isLoading;

  DataState get isLoggedIn => _isLoggedIn;

  DataState get isSignedOut => _isSignedOut;

  @override
  void setFailure(FailureHandler failure) {
    _failure = _failure;
    notifyListeners();
  }

  @override
  void setLoadingState(LoadingState newState) {
    _isLoading = newState;
    notifyListeners();
  }

  void setIsLoggedIn(DataState newState) {
    _isLoggedIn = newState;
    notifyListeners();
  }

  void setSignedOut(DataState newState) {
    _isSignedOut = newState;
    notifyListeners();
  }

  void clearData() {
    _isLoading = LoadingState.initial;
    _failure = null;
    _isLoggedIn = DataState.initial;
    _isSignedOut = DataState.initial;
  }
}
