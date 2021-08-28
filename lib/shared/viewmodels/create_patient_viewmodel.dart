import 'package:flutter/foundation.dart';
import 'package:surgery_support/models/enums.dart';
import 'package:surgery_support/models/patient_model.dart';

class CreatePatientViewmodel with ChangeNotifier {
  var _gender = Gender.male;
  var _categoryIndex = 0;
  var _genderIndex = 0;
  var _newPatient = PatientModel.newInstance();

  List<String> get categoryList => ["ORS", "Officer", "Family"];

  List<String> get procedureList => ["Upper GI", "Lower GI", "Cystoscopy"];

  List<String> get surgeryTypeList => ["Major", "Minor"];

  List<String> get priorityList => ["Normal", "High", "Low"];

  List<String> get genderList => ["Male", "Female", "Other"];

  void setGender(Gender newState) {
    _gender = newState;
    notifyListeners();
  }

  void setGenderIndex(int index) {
    _genderIndex = index;
    notifyListeners();
  }

  Gender get gender => _gender;
  int get genderIndex => _genderIndex;

  void setCategory(int newIndex) {
    _categoryIndex = newIndex;
    _newPatient.personalInfo.category = categoryList[newIndex];
    notifyListeners();
  }

  int get categoryIndex => _categoryIndex;

  void setNewPatientDetails(PatientModel newState) {
    _newPatient = newState;
    notifyListeners();
  }

  PatientModel get newPatient => _newPatient;
}
