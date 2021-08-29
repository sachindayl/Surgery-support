import 'dart:async';
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:wardeleven/models/patient_model.dart';

class FirestoreRouting {
  static final FirestoreRouting _instance = FirestoreRouting._internal();

  factory FirestoreRouting() {
    return _instance;
  }

  FirestoreRouting._internal();

  var patientsCollection = FirebaseFirestore.instance.collection('patients');

  Future<void> createPatient(PatientModel patient) async {
    patientsCollection
        .add(patient.toJson())
        .then((value) => log("Patient created.", name: "createPatient"))
        .catchError(
            (error) => log("Patient create error.", name: "createPatient"));
  }

  // QuerySnapshot eventsQuery = await ref
  //     .where("time", isGreaterThan: new DateTime.now().millisecondsSinceEpoch)
  //     .where("food", isEqualTo: true)
  //     .getDocuments();

  // Future<PatientModel> getPatients() {
  //   patientsCollection.snapshots();
  // }

  Future<void> deletePatient(String id) async {
    await patientsCollection.doc(id).delete().then((value) => log("Patient deleted.", name: "createPatient"));
  }
}
