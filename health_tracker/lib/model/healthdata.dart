import 'package:flutter/material.dart';

class HealthData extends ChangeNotifier {
  String _weight = '72';
  String _heartRate = '68';

  String get weight => _weight;
  String get heartRate => _heartRate;

  void updateWeight(String newWeight) {
    _weight = newWeight;
    notifyListeners();
  }

  void updateHeartRate(String newHeartRate) {
    _heartRate = newHeartRate;
    notifyListeners();
  }
}
