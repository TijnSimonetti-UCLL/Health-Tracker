import 'package:flutter/material.dart';

class HealthData extends ChangeNotifier {
  String _weight = '72'; //stanbaard gewicht in kg
  String _heartRate = '78'; //standaard hartslag in bpm
  String _waterIntake = '1.5'; //standaard water in namen in L
  String _sleepHours = '7.5'; // standaard slaap in uren/h

  String get weight => _weight; //gewicht ophalen
  String get heartRate => _heartRate; //hartslag ophalen
  String get waterIntake => _waterIntake;
  String get sleepHours => _sleepHours;

  void updateWeight(String newWeight) {
    _weight = newWeight;
    notifyListeners();
  } //gewicht bijwerken en luisteraars op de hoogte stellen

  void updateHeartRate(String newHeartRate) {
    _heartRate = newHeartRate;
    notifyListeners();
  } //hartslag bijwerken en luisteraars op de hoogte stellen

  void updateWaterIntake(String newWater) {
    _waterIntake = newWater;
    notifyListeners();
  }

  void updateSleepHours(String newSleep) {
    _sleepHours = newSleep;
    notifyListeners();
  }
}

// import 'package:flutter/material.dart';

// class HealthData extends ChangeNotifier {
//   String _weight = '72';
//   // String _waterIntake = '1.5';
//   // String _sleepHours = '7.5';

//   String get weight => _weight;
//   // String get waterIntake => _waterIntake;
//   // String get sleepHours => _sleepHours;

//   void updateWeight(String newWeight) {
//     _weight = newWeight;
//     notifyListeners();
//   }
//   // void updateWaterIntake(String newWater) {
//   //   _waterIntake = newWater;
//   //   notifyListeners();
//   // }
//   // void updateSleepHours(String newSleep) {
//   //   _sleepHours = newSleep;
//   //   notifyListeners();
//   // }
// }