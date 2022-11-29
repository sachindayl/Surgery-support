enum ServiceCategory { ors, officer, family }

extension CategoryString on String {
  ServiceCategory get category {
    switch (this) {
      case 'FAMILY':
        return ServiceCategory.family;
      case 'OFFICER':
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
        return 'ORS';
      case ServiceCategory.officer:
        return 'OFFICER';
      default:
        return 'FAMILY';
    }
  }
}