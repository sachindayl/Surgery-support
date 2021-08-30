enum Gender { male, female, other }

extension GenderString on String {
  Gender get gender {
    switch (this) {
      case 'male':
        return Gender.male;
      case 'female':
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
        return 'male';
      case Gender.female:
        return 'female';
      default:
        return 'other';
    }
  }
}
