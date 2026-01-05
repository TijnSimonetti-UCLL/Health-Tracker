import 'package:flutter/material.dart';

class OverviewPage extends StatefulWidget {
  const OverviewPage({super.key});

  @override
  State<OverviewPage> createState() => _OverviewPageState();
}

class _OverviewPageState extends State<OverviewPage> {
  int _tabIndex = 0;
  final _tabs = const ['Weight', 'Heart', 'Calories', 'Sleep'];

  // ✅ Voorlopig hardcoded — later maak je dit aanpasbaar
  double weightKg = 50.5;
  double waterL = 1.5;
  double sleepHours = 7.5;

  String getWeightTip(double kg) {
    if (kg < 60) return "je moet misschien iets meer eten";
    if (kg <= 80) return "je gewicht zit goed blijf zo doorgaan";
    return "je moet iets minder eten";
  }

  String getWaterTip(double liters) {
    if (liters < 1) return "je kan wel een beetje meer water drinken";
    if (liters <= 3) return "je bent goed gehydrateerd";
    return "je bent misschien een beetje te veel water aan het drinken";
  }

  String getSleepTip(double hours) {
    if (hours < 6) return "je hebt te weinig geslapen";
    if (hours <= 9) return "je hebt voldoende slaap gehad";
    return "je hebt misschien te veel geslapen";
  }

  @override
  Widget build(BuildContext context) {
    final weightTip = getWeightTip(weightKg);
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
                style: TextStyle(color: Colors.black54),
              ),

              const SizedBox(height: 18),

              // 2x2 metric cards (nu ook met de variabelen ingevuld)
              Row(
                children: [
                  const Expanded(
                    child: MetricCard(
                      title: 'Heart rate',
                      value: '72 BPM',
                      color: Color(0xFFE53935),
                      textColor: Colors.white,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: MetricCard(
                      title: 'Weight',
                      value: '${weightKg.toStringAsFixed(1)} kg',
                      color: const Color(0xFFD6A437),
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

              const SizedBox(height: 14),

              const SizedBox(height: 18),

              // ✅ Health tips nu afhankelijk van values
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
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 10),

                    TipTile(
                      title: 'Weight',
                      subtitle: weightTip,
                    ),
                    const SizedBox(height: 10),

                    TipTile(
                      title: 'Water',
                      subtitle: waterTip,
                    ),
                    const SizedBox(height: 10),

                    TipTile(
                      title: 'Sleep',
                      subtitle: sleepTip,
                    ),
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

/* ============ Reusable widgets ============ */

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
            style: TextStyle(
              color: textColor.withOpacity(0.95),
              fontWeight: FontWeight.w700,
            ),
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

  const TipTile({
    super.key,
    required this.title,
    required this.subtitle,
  });

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
          Text(subtitle, style: const TextStyle(color: Colors.black54)),
        ],
      ),
    );
  }
}
