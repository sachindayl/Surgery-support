import 'package:app/services/firebase/auth_routing.dart';
import 'package:app/services/firebase/storage_routing.dart';

class FirebaseService {
  static final FirebaseService _instance = FirebaseService._internal();

  factory FirebaseService() {
    return _instance;
  }

  FirebaseService._internal();

  AuthRouting get auth => AuthRouting();
  StorageRouting get storage => StorageRouting();
}
