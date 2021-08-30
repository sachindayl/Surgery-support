import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:wardeleven/base/error_handler.dart';
import 'package:wardeleven/models/enums.dart';
import 'package:wardeleven/models/patient_model.dart';

class FirestoreRouting {
  static final FirestoreRouting _instance = FirestoreRouting._internal();

  factory FirestoreRouting() {
    return _instance;
  }

  FirestoreRouting._internal();

  final _patientsCollection = FirebaseFirestore.instance.collection('patients');
  final _errorHandler = ErrorHandler();

  Future<DataState> createPatient(PatientModel patient) async {
    return _patientsCollection.add(patient.toJson()).then((value) {
      log("Patient created.", name: "createPatient");
      return DataState.success;
    }).catchError((error) {
      log("Patient create error.", name: "createPatient");
      _errorHandler.handleError(error);
    });
  }

  Future<List<PatientModel>> getPatients() async {
    return await _patientsCollection
        .get()
        .then((QuerySnapshot query) => query.docs.map((item) {
              log(item.data().toString(), name: "getPatients");
              var json = jsonEncode(item.data());
              return PatientModel.fromJson(jsonDecode(json));
            }).toList())
        .catchError((error) {
      log(error.toString(), name: "getPatients");
      _errorHandler.handleError(error);
    });
  }

  Future<List<PatientModel>> getPatientsForFocusedTimePeriod(
      DateTime focusedDay) async {
    var monthPriorEvents =
        DateTime(focusedDay.year, focusedDay.month - 1, focusedDay.day);
    return await _patientsCollection
        .where('diagnosis.date',
            isGreaterThanOrEqualTo: monthPriorEvents.toIso8601String())
        .get()
        .then((QuerySnapshot query) => query.docs.map((item) {
              var json = jsonEncode(item.data());
              return PatientModel.fromJson(jsonDecode(json));
            }).toList())
        .catchError((error) {
      log(error.toString(), name: "getPatientsForFocusedTimePeriod");
      _errorHandler.handleError(error);
    });
  }

  Future<void> deletePatient(String id) async {
    await _patientsCollection
        .doc(id)
        .delete()
        .then((value) => log("Patient deleted.", name: "createPatient"));
  }
}
