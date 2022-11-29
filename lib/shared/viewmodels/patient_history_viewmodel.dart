import 'package:flutter/foundation.dart';
import 'package:wardeleven/base/base_viewmodel_contract.dart';
import 'package:wardeleven/base/constants/constants.dart';
import 'package:wardeleven/base/failure_handler.dart';
import 'package:wardeleven/models/enums.dart';
import 'package:wardeleven/models/patient_model.dart';
import 'package:wardeleven/services/firebase/firebase_service.dart';

class PatientHistoryViewModel
    with ChangeNotifier
    implements BaseViewModelContract {
  FailureHandler? _failure;
  var _isLoading = LoadingState.initial;
  List<PatientModel> _patients = [];
  var _searchTerm = Constants.emptyString;

  Future<void> getPatients() async {
    try {
      var patients = await FirebaseService().firestore.getPatients();
      setPatients(patients);
    } on FailureHandler catch (e) {
      setFailure(e);
    }
  }

  void setPatients(List<PatientModel> patients) {
    _patients = patients;
    notifyListeners();
  }

  void setSearchTerm(String newTerm) {
    _searchTerm = newTerm.toLowerCase();
    notifyListeners();
  }

  List<PatientModel> get patientsList => _patients
      .where((element) =>
          element.personalInfo.name.firstName.toLowerCase().contains(_searchTerm) ||
          element.personalInfo.name.lastName.toLowerCase().contains(_searchTerm) ||
          element.personalInfo.registrationNo.toLowerCase().contains(_searchTerm))
      .toList();

  @override
  FailureHandler? get failure => _failure;

  @override
  LoadingState get loadingState => _isLoading;

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
}
