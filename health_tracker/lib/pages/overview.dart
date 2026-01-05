import 'package:flutter/material.dart';

class OverviewPage extends StatelessWidget {
  const OverviewPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Overview')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Activities',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 4),
            const Text(
              'Track your workouts and stay active',
              style: TextStyle(color: Colors.black54),
            ),

            const SizedBox(height: 16),

            // Weekly goals
            Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: const Color(0xFFE5E5E5),
                borderRadius: BorderRadius.circular(14),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    'Weekly Goals',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 12),

                  GoalProgress(label: 'Workouts: 8/12', value: 8, max: 12),
                  SizedBox(height: 10),

                  GoalProgress(label: 'Minutes: 245/300', value: 245, max: 300),
                  SizedBox(height: 10),

                  GoalProgress(
                    label: 'Calories: 1850/2500',
                    value: 1850,
                    max: 2500,
                  ),
                ],
              ),
            ),

            const SizedBox(height: 18),

            // Activity types
            GridView.count(
              crossAxisCount: 2,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              children: const [
                ActivityTypeCard(icon: Icons.directions_run, label: 'Running'),
                ActivityTypeCard(icon: Icons.pool, label: 'Swimming'),
                ActivityTypeCard(icon: Icons.directions_bike, label: 'Biking'),
                ActivityTypeCard(icon: Icons.directions_walk, label: 'Walking'),
              ],
            ),

            const SizedBox(height: 24),

            const Text(
              'Recent Activities',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),

            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.black12),
              ),
              child: Column(
                children: const [
                  ActivityItem(
                    icon: Icons.directions_run,
                    title: 'Morning run',
                    info: '03:24 • 5.2 KM',
                    calories: '310',
                  ),
                  Divider(height: 1),
                  ActivityItem(
                    icon: Icons.pool,
                    title: 'Pool Session',
                    info: '28:15 • 1.2 KM',
                    calories: '280',
                  ),
                  Divider(height: 1),
                  ActivityItem(
                    icon: Icons.directions_bike,
                    title: 'Evening Bike Ride',
                    info: '05:00 • 3.8 KM',
                    calories: '420',
                  ),
                  Divider(height: 1),
                  ActivityItem(
                    icon: Icons.directions_walk,
                    title: 'Park Walk',
                    info: '05:00 • 3.8 KM',
                    calories: '180',
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/* ================= Widgets ================= */

class GoalProgress extends StatelessWidget {
  final String label;
  final double value;
  final double max;

  const GoalProgress({
    super.key,
    required this.label,
    required this.value,
    required this.max,
  });

  @override
  Widget build(BuildContext context) {
    final progress = value / max;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontSize: 12)),
        const SizedBox(height: 6),
        ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: LinearProgressIndicator(
            value: progress.clamp(0, 1),
            minHeight: 10,
            backgroundColor: const Color(0xFFF2F2F2),
            valueColor: const AlwaysStoppedAnimation(Color(0xFF4338CA)),
          ),
        ),
      ],
    );
  }
}

class ActivityTypeCard extends StatelessWidget {
  final IconData icon;
  final String label;

  const ActivityTypeCard({super.key, required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFE5E5E5),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 34),
          const SizedBox(height: 8),
          Text(label, style: const TextStyle(fontWeight: FontWeight.w600)),
        ],
      ),
    );
  }
}

class ActivityItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final String info;
  final String calories;

  const ActivityItem({
    super.key,
    required this.icon,
    required this.title,
    required this.info,
    required this.calories,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: const Color(0xFFF2F2F2),
        child: Icon(icon),
      ),
      title: Text(title, style: const TextStyle(fontWeight: FontWeight.w600)),
      subtitle: Text(info, style: const TextStyle(fontSize: 12)),
      trailing: Text(
        calories,
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
    );
  }
}
