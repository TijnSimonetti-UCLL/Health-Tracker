import 'package:flutter/material.dart';

class HealthData extends ChangeNotifier {
  String _weight = '72'; //stanbaard gewicht in kg
  String _heartRate = '68'; //standaard hartslag in bpm

  String get weight => _weight; //gewicht ophalen
  String get heartRate => _heartRate; //hartslag ophalen

  void updateWeight(String newWeight) {
    _weight = newWeight;
    notifyListeners();
  } //gewicht bijwerken en luisteraars op de hoogte stellen

  void updateHeartRate(String newHeartRate) {
    _heartRate = newHeartRate;
    notifyListeners();
  } //hartslag bijwerken en luisteraars op de hoogte stellen
}
