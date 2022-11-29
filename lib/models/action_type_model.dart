enum ActionType { review, surgery, endoscopy }

extension ActionTypeString on String {
  ActionType get actionType {
    switch (this) {
      case 'SURGERY':
        return ActionType.surgery;
      case 'ENDOSCOPY':
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
        return 'REVIEW';
      case ActionType.surgery:
        return 'SURGERY';
      case ActionType.endoscopy:
        return 'ENDOSCOPY';
      default:
        return 'REVIEW';
    }
  }
}