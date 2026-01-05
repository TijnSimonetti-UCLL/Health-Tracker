import 'package:flutter/material.dart';

class ActivityPage extends StatelessWidget {
  const ActivityPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Activity')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //Types beschikbare activiteiten//
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

            const SizedBox(height: 2),

            //Titel recente activiteiten//
            const Text(
              'Recent Activities',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 12),

            //Lijst met recente activiteiten//
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.black12),
              ),
              child: Column(
                children: const [
                  ActivityListItem(
                    icon: Icons.directions_run,
                    title: 'Morning run',
                    info: '03:24 • 5.2 KM',
                    date: 'Today, 7:30 AM',
                    calories: '310',
                  ),
                  Divider(height: 1),
                  ActivityListItem(
                    icon: Icons.pool,
                    title: 'Pool Session',
                    info: '28:15 • 1.2 KM',
                    date: '2 days ago, 08:00 AM',
                    calories: '280',
                  ),
                  Divider(height: 1),
                  ActivityListItem(
                    icon: Icons.directions_bike,
                    title: 'Evening Bike Ride',
                    info: '05:00 • 3.8 KM',
                    date: '3 days ago, 5:30 PM',
                    calories: '420',
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // This month titel
            const Text(
              'This Month',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 12),

            // Maand statistieken
            GridView.count(
              crossAxisCount: 2,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              children: const [
                MonthStatCard(
                  value: '32',
                  label: 'Workouts',
                  color: Color(0xFFEAF3FF),
                ),
                MonthStatCard(
                  value: '18.5 hrs',
                  label: 'Active Time',
                  color: Color(0xFFECFDF3),
                ),
                MonthStatCard(
                  value: '142 km',
                  label: 'Distance',
                  color: Color(0xFFFFF3E6),
                ),
                MonthStatCard(
                  value: '7,850',
                  label: 'Burned',
                  color: Color(0xFFFFEEF2),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

/* =======================
   Kleine herbruikbare widgets
   ======================= */

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

class ActivityListItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final String info;
  final String date;
  final String calories;

  const ActivityListItem({
    super.key,
    required this.icon,
    required this.title,
    required this.info,
    required this.date,
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
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(info, style: const TextStyle(fontSize: 12)),
          Text(date, style: const TextStyle(fontSize: 11)),
        ],
      ),
      trailing: Text(
        calories,
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
      isThreeLine: true,
    );
  }
}

class MonthStatCard extends StatelessWidget {
  final String value;
  final String label;
  final Color color;

  const MonthStatCard({
    super.key,
    required this.value,
    required this.label,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            value,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 6),
          Text(label, style: const TextStyle(color: Colors.black54)),
        ],
      ),
    );
  }
}
