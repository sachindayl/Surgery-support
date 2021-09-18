enum ServiceCategory { ors, officer, family }

extension CategoryString on String {
  ServiceCategory get category {
    switch (this) {
      case 'family':
        return ServiceCategory.family;
      case 'officer':
        return ServiceCategory.officer;
      default:
        return ServiceCategory.ors;
    }
  }
}

extension CategoryExtension on ServiceCategory {
  String get string {
    switch (this) {
      case ServiceCategory.ors:
        return 'ors';
      case ServiceCategory.officer:
        return 'officer';
      default:
        return 'family';
    }
  }
}