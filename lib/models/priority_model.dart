enum Priority { low, medium, high }

extension PriorityString on String {
  Priority get priority {
    switch (this) {
      case 'low':
        return Priority.low;
      case 'medium':
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
        return 'low';
      case Priority.medium:
        return 'medium';
      default:
        return 'high';
    }
  }
}
