class EmployeeRouting {
  static final EmployeeRouting _instance = EmployeeRouting._internal();

  factory EmployeeRouting() {
    return _instance;
  }

  EmployeeRouting._internal();
}