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

// import 'package:flutter/material.dart';

// class HealthData extends ChangeNotifier {
//   String _weight = '72';
//   // String _waterInTake = '1.5';
//   // String _sleepHours = '7.5';

//   String get weight => _weight;
//   // String get waterInTake => _waterInTake;
//   // String get sleepHours => _sleepHours;

//   void updateWeight(String newWeight) {
//     _weight = newWeight;
//     notifyListeners();
//   }
//   // void updateWaterInTake(String newWater) {
//   //   _waterInTake = newWater;
//   //   notifyListeners();
//   // }
//   // void updateSleepHours(String newSleep) {
//   //   _sleepHours = newSleep;
//   //   notifyListeners();
//   // }
// }