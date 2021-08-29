import 'dart:async';
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

  // QuerySnapshot eventsQuery = await ref
  //     .where("time", isGreaterThan: new DateTime.now().millisecondsSinceEpoch)
  //     .where("food", isEqualTo: true)
  //     .getDocuments();

  // Future<PatientModel> getPatients() {
  //   patientsCollection.snapshots();
  // }

  Future<void> deletePatient(String id) async {
    await _patientsCollection
        .doc(id)
        .delete()
        .then((value) => log("Patient deleted.", name: "createPatient"));
  }
}
