enum SurgeryType { none, major, minor }

extension SurgeryTypeString on String? {
  SurgeryType? get surgeryType {
    switch (this) {
      case 'major':
        return SurgeryType.major;
      case 'minor':
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
        return 'major';
      case SurgeryType.minor:
        return 'minor';
      default:
        return 'none';
    }
  }
}
