enum SurgeryType { none, major, minor }

extension SurgeryTypeString on String? {
  SurgeryType? get surgeryType {
    switch (this) {
      case 'MAJOR':
        return SurgeryType.major;
      case 'MINOR':
        return SurgeryType.minor;
      default:
        return SurgeryType.none;
    }
  }
}

extension SurgeryTypeExtension on SurgeryType? {
  String get string {
    switch (this) {
      case SurgeryType.major:
        return 'MAJOR';
      case SurgeryType.minor:
        return 'MINOR';
      default:
        return 'NONE';
    }
  }
}
