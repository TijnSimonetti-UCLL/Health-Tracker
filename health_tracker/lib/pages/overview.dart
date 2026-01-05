import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../model/healthdata.dart'; // import your shared state

class OverviewPage extends StatefulWidget {
  const OverviewPage({super.key});

  @override
  State<OverviewPage> createState() => _OverviewPageState();
}

class _OverviewPageState extends State<OverviewPage> {
  int _tabIndex = 0;

  final _tabs = const ['Weight', 'Heart', 'Calories', 'Sleep'];

  @override
  Widget build(BuildContext context) {
    // <-- Get the current weight from shared state
    final currentWeight = context.watch<HealthData>().weight;

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(16, 14, 16, 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
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

              // 2x2 metric cards
              Row(
                children: [
                  const Expanded(
                    child: MetricCard(
                      title: 'Heart rate',
                      value: '72 BPM',
                      color: Color(0xFFE53935), // rood
                      textColor: Colors.white,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: MetricCard(
                      title: 'Weight',
                      value: '$currentWeight kg', // <-- dynamic weight
                      color: const Color(0xFFD6A437), // goud
                      textColor: Colors.black,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Row(
                children: const [
                  Expanded(
                    child: MetricCard(
                      title: 'Water intake',
                      value: '1.5L',
                      color: Color(0xFF3B5BDB), // blauw
                      textColor: Colors.white,
                    ),
                  ),
                  SizedBox(width: 12),
                  Expanded(
                    child: MetricCard(
                      title: 'Sleep',
                      value: '7.5/8h',
                      color: Color(0xFF8E24AA), // paars
                      textColor: Colors.white,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 16),

              // // Tabs (segment control)
              // ... your commented code remains
              const SizedBox(height: 14),

              // // Chart placeholder
              // ... your commented code remains
              const SizedBox(height: 18),

              // Health tips
              Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: const Color(0xFFF2F2F2),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      'Health Tips',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 10),

                    TipTile(
                      title: 'Increase water intake',
                      subtitle: 'Try to drink at least 2.5L per day',
                    ),
                    SizedBox(height: 10),
                    TipTile(
                      title: 'Great sleep pattern!',
                      subtitle: 'Keep maintaining 7-8h of sleep',
                    ),
                    SizedBox(height: 10),
                    TipTile(
                      title: 'Consider more cardio',
                      subtitle: '30 mins of cardio helps reach weight goal',
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
          Text(subtitle, style: const TextStyle(color: Colors.black54)),
        ],
      ),
    );
  }
}
