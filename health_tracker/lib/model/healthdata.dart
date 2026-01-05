import 'package:flutter/material.dart';

class HealthData extends ChangeNotifier {
  String _weight = '72';

  String get weight => _weight;

  void updateWeight(String newWeight) {
    _weight = newWeight;
    notifyListeners();
  }
}
