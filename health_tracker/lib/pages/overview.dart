import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../model/healthdata.dart';

class OverviewPage extends StatefulWidget {
  const OverviewPage({super.key});

  @override
  State<OverviewPage> createState() => _OverviewPageState();
}

class _OverviewPageState extends State<OverviewPage> {
  int _tabIndex = 0;
  final _tabs = const ['Weight', 'Heart', 'Calories', 'Sleep'];

  // dit moet dynamisch worden
  //voorlopig vaste waardes
  double weightKg = 50.5;
  double waterL = 1.5;
  double sleepHours = 7.5;

  String getWeightTip(double kg) {
    if (kg < 60) {
      return "You may want to eat a bit more to support a healthy weight.";
    }
    if (kg <= 80) {
      return "Your weight is within a healthy range. Keep up the good work!";
    }
    return "You may want to slightly reduce your food intake to improve your health.";
  }

  String getWaterTip(double liters) {
    if (liters < 1) {
      return "You could benefit from drinking a bit more water today.";
    }
    if (liters <= 3) return "You are well hydrated. Great job!";
    return "You may be drinking a bit too much water. Try to keep it balanced.";
  }

  String getSleepTip(double hours) {
    if (hours < 6) {
      return "You didn't get enough sleep. Try to rest more tonight.";
    }
    if (hours <= 9) return "You had a healthy amount of sleep. Well done!";
    return "You may have slept a bit too much. Keeping a regular sleep schedule can help.";
  }

  //-----------------BUILD METHOD------------------//
  @override
  Widget build(BuildContext context) {
    final currentWeight = context.watch<HealthData>().weight;
    final currentHeartRate = context.watch<HealthData>().heartRate;

    //final health = context.watch<HealthData>();

    // final currentWeight = health.weight;
    // final currentWater = health.waterIntake;
    // final currentSleep = health.sleepHours;

    //final weightTip = getWeightTip(currentWeight);
    // final waterTip = getWaterTip(currentWater);
    // final sleepTip = getSleepTip(currentSleep);

    //final weightTip = getWeightTip(weightKg);
    final weightTip = getWeightTip(double.tryParse(currentWeight) ?? 0);
    final waterTip = getWaterTip(waterL);
    final sleepTip = getSleepTip(sleepHours);

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(16, 14, 16, 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Health Details',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 4),
              const Text(
                'Detailed summary of your health information',
                style: TextStyle(color: Colors.black),
              ),

              const SizedBox(height: 18),

              Row(
                children: [
                  Expanded(
                    child: MetricCard(
                      title: 'Heart rate',
                      value: '$currentHeartRate BPM',
                      color: const Color(0xFFE53935),
                      textColor: Colors.white,
                    ),
                  ),

                  const SizedBox(width: 12),
                  Expanded(
                    child: MetricCard(
                      title: 'Weight',
                      value: '$currentWeight kg',
                      color: Color(0xFFD6A437),
                      textColor: Colors.black,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(
                    child: MetricCard(
                      title: 'Water intake',
                      value: '${waterL.toStringAsFixed(1)}L',
                      color: const Color(0xFF3B5BDB),
                      textColor: Colors.white,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: MetricCard(
                      title: 'Sleep',
                      value: '${sleepHours.toStringAsFixed(1)}/8h',
                      color: const Color(0xFF8E24AA),
                      textColor: Colors.white,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 16),

              const SizedBox(height: 14),

              const SizedBox(height: 18),

              // tips op basis van je waardes
              Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: const Color(0xFFF2F2F2),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Health Tips',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),

                    TipTile(title: 'Weight', subtitle: weightTip),
                    const SizedBox(height: 10),

                    TipTile(title: 'Water', subtitle: waterTip),
                    const SizedBox(height: 10),

                    TipTile(title: 'Sleep', subtitle: sleepTip),
                    const SizedBox(height: 10),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

//de vakjes

class MetricCard extends StatelessWidget {
  final String title;
  final String value;
  final Color color;
  final Color textColor;

  const MetricCard({
    super.key,
    required this.title,
    required this.value,
    required this.color,
    required this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 86,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(color: textColor, fontWeight: FontWeight.w700),
          ),
          const Spacer(),
          Text(
            value,
            style: TextStyle(
              color: textColor,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}

class TipTile extends StatelessWidget {
  final String title;
  final String subtitle;

  const TipTile({super.key, required this.title, required this.subtitle});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFFE6E6E6),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: const TextStyle(fontWeight: FontWeight.w700)),
          const SizedBox(height: 4),
          Text(subtitle, style: const TextStyle(color: Colors.black)),
        ],
      ),
    );
  }
}
