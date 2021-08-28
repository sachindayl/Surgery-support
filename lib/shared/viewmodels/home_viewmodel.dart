import 'package:flutter/foundation.dart';

class HomeViewModel with ChangeNotifier {
  final Map<DateTime, List<String>> _events = {
    DateTime(2021, 8, 29): ["Test"]
  };

  Map<DateTime, List<String>> get events => _events;
}
