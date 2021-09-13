enum DataState { initial, success, failed }

enum LoadingState { initial, loading, complete }

enum ActionType { review, surgery, endoscopy }

extension ActionTypeString on String {
  ActionType get topic {
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
