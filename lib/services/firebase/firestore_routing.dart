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

  final _patientsCollection = FirebaseFirestore.instance
      .collection('patients')
      .withConverter<PatientModel>(
        fromFirestore: (snapshot, _) => PatientModel.fromJson(snapshot.data()!),
        toFirestore: (patient, _) => patient.toJson(),
      );

  final _errorHandler = ErrorHandler();

  Future<DataState> createPatient(PatientModel patient) async {
    return _patientsCollection.add(patient).then((value) {
      log("Patient created.", name: "createPatient");
      return DataState.success;
    }).catchError((error) {
      log("Patient create error.", name: "createPatient");
      _errorHandler.handleError(error);
    });
  }

  Future<DataState> updatePatient(PatientModel patient) async {
    return _patientsCollection.doc(patient.id).set(patient).then((value) {
      log("Patient updated.", name: "updatePatient");
      return DataState.success;
    }).catchError((error) {
      log("Patient update error.", name: "updatePatient");
      _errorHandler.handleError(error);
    });
  }

  Future<List<PatientModel>> getPatients() async {
    return await _patientsCollection
        .get()
        .then((QuerySnapshot query) => query.docs.map((item) {
              var json = jsonEncode(item.data());
              log(item.id, name: "getPatients");
              var patient = PatientModel.fromJson(jsonDecode(json));
              patient.id = item.id;
              return patient;
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
              var patient = PatientModel.fromJson(jsonDecode(json));
              patient.id = item.id;
              return patient;
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
