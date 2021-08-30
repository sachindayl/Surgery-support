import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:wardeleven/base/base_viewmodel_contract.dart';
import 'package:wardeleven/base/failure_handler.dart';
import 'package:wardeleven/models/enums.dart';
import 'package:wardeleven/models/patient_model.dart';
import 'package:wardeleven/services/firebase/firebase_service.dart';

class HomeViewModel with ChangeNotifier implements BaseViewModelContract {
  var _isLoading = LoadingState.initial;
  FailureHandler? _failure;
  DateTime _selectedDay = DateTime.now();
  DateTime _focusedDay = DateTime.now();
  List<PatientModel> _patients = [];

  Future<void> getMonthlyPatients() async {
    try {
      var patients = await FirebaseService().firestore
          .getPatientsForFocusedTimePeriod(_focusedDay);
      log(patients.toString(), name: "getMonthlyPatients");
      setPatients(patients);
    } on FailureHandler catch (e) {
      setFailure(e);
    }
  }


  void setSelectedDay(DateTime day) {
    _selectedDay = day;
    notifyListeners();
  }

  void setFocusedDay(DateTime day) {
    _focusedDay = day;
    getMonthlyPatients();
    notifyListeners();
  }

  void setPatients(List<PatientModel> patients) {
    _patients.clear();
    _patients = patients;
    notifyListeners();
  }

  Map<DateTime, List<PatientModel>> get calenderEvents {
    Map<DateTime, List<PatientModel>> calendarEventMap = {};

    _patients.map((patient) {
      var diagnosisDate = patient.diagnosis.date;
      var dailyPatients = _patients
          .where((e) =>
      diagnosisDate.day == _selectedDay.day &&
          diagnosisDate.month == _selectedDay.month &&
          diagnosisDate.year == _selectedDay.year).toList();
      return calendarEventMap[diagnosisDate] = dailyPatients;
    }).toList();

    // _patients.forEach((patient) {
    //   var dateFormat = DateFormat('dd/MM/yyyy').parse(patient.diagnosis.date);
    //   var dailyPatients = _patients.where((e) =>
    //    dateFormat.day == _selectedDay.day &&
    //       dateFormat.month == _selectedDay.month &&
    //       dateFormat.year == _selectedDay.year).toList();
    //   calendarEventMap[dateFormat] = dailyPatients;
    // });


    // var dateFormat = DateFormat('dd/MM/yyyy').format(_focusedDay);
    log(calendarEventMap.toString(), name: "calenderEvents");

    return calendarEventMap;
  }

  List<PatientModel> get todayHighPriorityPatients =>
      _patients.where((patient) =>
      patient.diagnosis.priority == 'High' &&
      patient.diagnosis.date.day == _selectedDay.day &&
          patient.diagnosis.date.month == _selectedDay.month &&
          patient.diagnosis.date.year == _selectedDay.year).toList();

  List<PatientModel> get todayOtherPatients =>
      _patients.where((patient) =>
      patient.diagnosis.priority != 'High' &&
          patient.diagnosis.date.day == _selectedDay.day &&
          patient.diagnosis.date.month == _selectedDay.month &&
          patient.diagnosis.date.year == _selectedDay.year).toList();

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
