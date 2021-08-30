import 'package:flutter/foundation.dart';
import 'package:wardeleven/base/failure_handler.dart';
import 'package:wardeleven/models/enums.dart';
import 'package:wardeleven/models/patient_model.dart';
import 'package:wardeleven/services/firebase/firebase_service.dart';

class CreatePatientViewmodel with ChangeNotifier {
  var _categoryIndex = 0;
  var _genderIndex = 0;
  var _priorityIndex = 0;
  var _newPatient = PatientModel.newInstance();
  var _isPatientCreated = DataState.initial;
  var _isPatientUpdated = DataState.initial;
  var _isLoading = LoadingState.initial;
  FailureHandler? _failure;

  // region Getters
  List<String> get categoryList => ["ORS", "Officer", "Family"];

  List<String> get procedureList => ["Upper GI", "Lower GI", "Cystoscopy"];

  List<String> get surgeryTypeList => ["Major", "Minor"];

  List<String> get priorityList => ["Low", "Medium", "High"];

  List<String> get genderList => ["Male", "Female", "Other"];

  int get genderIndex => _genderIndex;

  int get priorityIndex => _priorityIndex;

  int get categoryIndex => _categoryIndex;

  PatientModel get newPatient => _newPatient;

  DataState get isPatientCreated => _isPatientCreated;

  DataState get isPatientUpdated => _isPatientUpdated;

  LoadingState get isLoading => _isLoading;

  FailureHandler? get failure => _failure;

  // endregion

  // region Setters

  void setGenderIndex(int index) {
    _genderIndex = index;
    notifyListeners();
  }

  void setPriorityIndex(int index) {
    _priorityIndex = index;
    notifyListeners();
  }

  void setNewPatientDetails(PatientModel newState) {
    _newPatient = newState;
    notifyListeners();
  }

  void setCategory(int newIndex) {
    _categoryIndex = newIndex;
    _newPatient.personalInfo.category = categoryList[newIndex];
    notifyListeners();
  }

  setPatientCreated(DataState newState) {
    _isPatientCreated = newState;
    notifyListeners();
  }

  setPatientUpdated(DataState newState) {
    _isPatientUpdated = newState;
    notifyListeners();
  }

  setLoading(LoadingState newState) {
    _isLoading = newState;
    notifyListeners();
  }

  void setFailure(FailureHandler failure) {
    _failure = failure;
    notifyListeners();
  }

  void clearPatientData() {
    _newPatient = PatientModel.newInstance();
    _isLoading = LoadingState.initial;
    _isPatientCreated = DataState.initial;
    _isPatientUpdated = DataState.initial;
    _categoryIndex = 0;
    _genderIndex = 0;
    _priorityIndex = 0;
    _failure = null;
  }

  // endregion

  // region Network calls
  Future<void> createPatient() async {
    try {
      var isPatientCreated =
          await FirebaseService().firestore.createPatient(_newPatient);
      setPatientCreated(isPatientCreated);
    } on FailureHandler catch (e) {
      setFailure(e);
    }
  }

  Future<void> updatePatient() async {
    try {
      var isPatientUpdated =
          await FirebaseService().firestore.updatePatient(_newPatient);
      setPatientUpdated(isPatientUpdated);
    } on FailureHandler catch (e) {
      setFailure(e);
    }
  }
//endregion
}
