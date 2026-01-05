import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../model/healthdata.dart'; // Make sure this file exists

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // Remove the local variable, we'll use HealthData instead

  void _editWeight(BuildContext context, String currentWeight) async {
    final controller = TextEditingController(text: currentWeight);

    final result = await showDialog<String>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Edit weight'),
          content: TextField(
            controller: controller,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(suffixText: 'kg'),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context), // cancel
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context, controller.text); // save
              },
              child: const Text('Save'),
            ),
          ],
        );
      },
    );

    if (result != null && result.isNotEmpty) {
      // update the shared state instead of local variable
      context.read<HealthData>().updateWeight(result);
    }
  }

  @override
  Widget build(BuildContext context) {
    // Use shared weight from HealthData
    final currentWeight = context.watch<HealthData>().weight;

    return Scaffold(
      appBar: AppBar(title: const Text('Welcome to Health Tracker 2')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Today',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),

            //de 4 kaarten//
            Row(
              children: [
                Expanded(
                  child: InkWell(
                    borderRadius: BorderRadius.circular(14),
                    onTap: () => _editWeight(context, currentWeight),
                    child: HomeInfoCard(
                      title: 'Current weight',
                      value: '$currentWeight kg',
                      icon: Icons.monitor_weight,
                      color: const Color(0xFFFFF3E6),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                const Expanded(
                  child: HomeInfoCard(
                    title: 'Heart rate',
                    value: '75 bpm',
                    icon: Icons.favorite,
                    color: Color(0xFFFFEEF2),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: const [
                Expanded(
                  child: HomeInfoCard(
                    title: 'BMI',
                    value: '22.5',
                    icon: Icons.calculate,
                    color: Color(0xFFEAF3FF),
                  ),
                ),
                SizedBox(width: 12),
                Expanded(
                  child: HomeInfoCard(
                    title: 'Calory intake',
                    value: '2000 kcal',
                    icon: Icons.local_fire_department,
                    color: Color(0xFFF3E8FF),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 24),

            const Text(
              'Daily Summary',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),

            //3 daily summary kaarten//
            Row(
              children: const [
                Expanded(
                  child: SmallSummaryCard(
                    title: 'Steps',
                    value: '8500',
                    icon: Icons.directions_walk,
                    color: Color(0xFFECFDF3),
                  ),
                ),
                SizedBox(width: 12),
                Expanded(
                  child: SmallSummaryCard(
                    title: 'Active',
                    value: '43 min',
                    icon: Icons.timer,
                    color: Color(0xFFEAF3FF),
                  ),
                ),
                SizedBox(width: 12),
                Expanded(
                  child: SmallSummaryCard(
                    title: 'Kcal',
                    value: '367',
                    icon: Icons.local_fire_department,
                    color: Color(0xFFE6FFFB),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

/* ========== Reusable widgets ========== */

class HomeInfoCard extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;
  final Color color;

  const HomeInfoCard({
    super.key,
    required this.title,
    required this.value,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: Colors.black12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: Colors.black87),
          const Spacer(),
          Text(title, style: const TextStyle(color: Colors.black54)),
          const SizedBox(height: 6),
          Text(
            value,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}

class SmallSummaryCard extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;
  final Color color;

  const SmallSummaryCard({
    super.key,
    required this.title,
    required this.value,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: Colors.black12),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 22),
          const SizedBox(height: 6),
          Text(value, style: const TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 2),
          Text(
            title,
            style: const TextStyle(fontSize: 12, color: Colors.black54),
          ),
        ],
      ),
    );
  }
}
