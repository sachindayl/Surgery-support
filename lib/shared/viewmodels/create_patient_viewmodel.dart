import 'package:flutter/foundation.dart';

class CreatePatientViewmodel with ChangeNotifier {

  DateTime _selectedDiagnosisDate = DateTime.now();

  void setDiagnosisDate(DateTime newDate) {
    _selectedDiagnosisDate = newDate;
    notifyListeners();
  }

  DateTime get selectedDiagnosisDate => _selectedDiagnosisDate;

}