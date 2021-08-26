import 'package:flutter/foundation.dart';
import 'package:surgery_support/models/enums.dart';

class CreatePatientViewmodel with ChangeNotifier {
  DateTime _dateOfBirth = DateTime.now();
  DateTime _selectedDiagnosisDate = DateTime.now();
  var _gender = Gender.male;

  void setDiagnosisDate(DateTime newDate) {
    _selectedDiagnosisDate = newDate;
    notifyListeners();
  }

  DateTime get selectedDiagnosisDate => _selectedDiagnosisDate;

  void setDateOfBirth(DateTime newDate) {
    _dateOfBirth = newDate;
    notifyListeners();
  }

  DateTime get dateOfBirth => _dateOfBirth;



  List<String> get categoryList => ["ORS", "Officer", "Family"];

  List<String> get procedureList => ["Upper GI", "Lower GI", "Cystoscopy"];

  List<String> get surgeryTypeList => ["Major", "Minor"];

  List<String> get priorityList => ["Normal", "High", "Low"];

  void setGender(Gender newState) {
    _gender = newState;
    notifyListeners();
  }

  Gender get gender => _gender;
}
