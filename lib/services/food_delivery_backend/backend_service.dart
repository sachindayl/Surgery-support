import 'package:app/services/food_delivery_backend/employees_routing.dart';

class BackendService {
  static final BackendService _instance = BackendService._internal();

  factory BackendService() {
    return _instance;
  }

  BackendService._internal();

  EmployeeRouting get employees => EmployeeRouting();
}
