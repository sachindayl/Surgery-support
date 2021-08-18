class StorageRouting {
  static final StorageRouting _instance = StorageRouting._internal();

  factory StorageRouting() {
    return _instance;
  }

  StorageRouting._internal();
}