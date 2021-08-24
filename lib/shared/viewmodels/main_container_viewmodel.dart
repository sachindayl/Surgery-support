import 'package:flutter/foundation.dart';

class MainContainerViewModel with ChangeNotifier {
  var _viewIndex = 0;

  void setViewIndex(int newIndex) {
    _viewIndex = newIndex;
    notifyListeners();
  }

  int get viewIndex => _viewIndex;
}