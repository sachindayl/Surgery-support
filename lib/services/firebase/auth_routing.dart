class AuthRouting {
  static final AuthRouting _instance = AuthRouting._internal();

  factory AuthRouting() {
    return _instance;
  }

  AuthRouting._internal();
}