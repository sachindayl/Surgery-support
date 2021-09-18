
import 'package:flutter/foundation.dart';
import 'package:wardeleven/base/base_viewmodel_contract.dart';
import 'package:wardeleven/base/failure_handler.dart';
import 'package:wardeleven/models/enums.dart';
import 'package:wardeleven/models/patient_model.dart';
import 'package:wardeleven/models/priority_model.dart';
import 'package:wardeleven/services/firebase/firebase_service.dart';

class HomeViewModel with ChangeNotifier implements BaseViewModelContract {
  var _isLoading = LoadingState.initial;
  FailureHandler? _failure;
  DateTime _selectedDay = DateTime.now();
  DateTime _focusedDay = DateTime.now();
  List<PatientModel> _patients = [];

  Future<void> getMonthlyPatients() async {
    try {
      var patients = await FirebaseService()
          .firestore
          .getPatientsForFocusedTimePeriod(_focusedDay);
      setPatients(patients);
    } on FailureHandler catch (e) {
      setFailure(e);
    }
  }

  void setSelectedDay(DateTime day) {
    _selectedDay = day;
    notifyListeners();
  }

  DateTime get selectedDay => _selectedDay;

  void setFocusedDay(DateTime day) {
    _focusedDay = day;
    getMonthlyPatients();
    notifyListeners();
  }

  DateTime get focusedDay => _focusedDay;

  void setPatients(List<PatientModel> patients) {
    _patients.clear();
    _patients = patients;
    notifyListeners();
  }

  Map<DateTime, List<PatientModel>> get calenderEvents {
    Map<DateTime, List<PatientModel>> calendarEventMap = {};

    for (var patient in _patients) {
      calendarEventMap[patient.diagnosis.date] = _patients
          .where((element) => element.diagnosis.date == patient.diagnosis.date)
          .toList();
    }

    return calendarEventMap;
  }

  List<PatientModel> get todayHighPriorityPatients => _patients
      .where((patient) =>
          patient.diagnosis.priority == Priority.high &&
          patient.diagnosis.date.day == _selectedDay.day &&
          patient.diagnosis.date.month == _selectedDay.month &&
          patient.diagnosis.date.year == _selectedDay.year)
      .toList();

  List<PatientModel> get todayOtherPatients => _patients
      .where((patient) =>
          patient.diagnosis.priority != Priority.high &&
          patient.diagnosis.date.day == _selectedDay.day &&
          patient.diagnosis.date.month == _selectedDay.month &&
          patient.diagnosis.date.year == _selectedDay.year)
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
