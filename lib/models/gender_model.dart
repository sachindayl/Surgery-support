enum Gender { male, female, other }

extension GenderString on String {
  Gender get gender {
    switch (this) {
      case 'MALE':
        return Gender.male;
      case 'FEMALE':
        return Gender.female;
      default:
        return Gender.other;
    }
  }
}

extension GenderExtension on Gender {
  String get string {
    switch (this) {
      case Gender.male:
        return 'MALE';
      case Gender.female:
        return 'FEMALE';
      default:
        return 'OTHER';
    }
  }
}
