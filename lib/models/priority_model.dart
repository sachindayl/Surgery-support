enum Priority { low, medium, high }

extension PriorityString on String {
  Priority get priority {
    switch (this) {
      case 'LOW':
        return Priority.low;
      case 'MEDIUM':
        return Priority.medium;
      default:
        return Priority.high;
    }
  }
}

extension PriorityExtension on Priority {
  String get string {
    switch (this) {
      case Priority.low:
        return 'LOW';
      case Priority.medium:
        return 'MEDIUM';
      default:
        return 'HIGH';
    }
  }
}
