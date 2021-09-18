enum DataState { initial, success, failed }

enum LoadingState { initial, loading, complete }

/// region actionType
enum ActionType { review, surgery, endoscopy }

extension ActionTypeString on String {
  ActionType get actionType {
    switch (this) {
      case 'surgery':
        return ActionType.surgery;
      case 'endoscopy':
        return ActionType.endoscopy;
      default:
        return ActionType.review;
    }
  }
}

extension ActionTypeExtension on ActionType {
  String get string {
    switch (this) {
      case ActionType.review:
        return 'review';
      case ActionType.surgery:
        return 'surgery';
      case ActionType.endoscopy:
        return 'endoscopy';
    }
  }
}

/// endRegion

/// region category

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
      case ServiceCategory.family:
        return 'family';
    }
  }
}

/// endregion
