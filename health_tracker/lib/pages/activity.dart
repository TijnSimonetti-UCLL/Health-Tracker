import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

//de classe die een activiteit voorstelt en welke informati nodig is
class ActivityItem {
  final IconData icon;
  final String title;
  final String info;
  final String date;
  final String calories;

  // info voor de this month sectie
  final int minutes;
  final double km;
  final int cal;

  ActivityItem({
    required this.icon,
    required this.title,
    required this.info,
    required this.date,
    required this.calories,

    required this.minutes,
    required this.km,
    required this.cal,
  });
}

//zorgt voor de functionaliteit van de activity pagina
class ActivityPage extends StatefulWidget {
  const ActivityPage({super.key});

  @override
  State<ActivityPage> createState() => _ActivityPageState();
}

//zorgt voor de layout van de activity pagina
class _ActivityPageState extends State<ActivityPage> {
  final List<ActivityItem> recentActivities = [
    //de voorbeelde activiteiten die al in de lijst staan als voorbeeld
    ActivityItem(
      icon: Icons.directions_run,
      title: 'Morning run',
      info: '03:24 • 5.2 KM',
      date: 'Today, 7:30 AM',
      calories: '310',
      minutes: 3,
      km: 5.2,
      cal: 310,
    ),
    ActivityItem(
      icon: Icons.pool,
      title: 'Pool Session',
      info: '28:15 • 1.2 KM',
      date: '2 days ago, 08:00 AM',
      calories: '280',
      minutes: 28,
      km: 1.2,
      cal: 280,
    ),
    ActivityItem(
      icon: Icons.directions_bike,
      title: 'Evening Bike Ride',
      info: '05:00 • 3.8 KM',
      date: '3 days ago, 5:30 PM',
      calories: '420',
      minutes: 5,
      km: 3.8,
      cal: 420,
    ),
  ];

  //----------------NIEUWE ACTIVITEIT TOEVOEGEN----------------//
  //dit zorgt ervoor dat je een nieuwe activiteit kan toevoegen
  void _addActivity(IconData icon, String typeName) async {
    final titleC = TextEditingController(text: typeName);
    final timeC = TextEditingController();
    final kmC = TextEditingController();
    final calC = TextEditingController();

    //hier is de dialoog die verschijnt wanneer je een nieuwe activiteit naar keuze toevoegt
    final ok = await showDialog<bool>(
      context: context,
      builder: (_) => AlertDialog(
        title: Text('Add $typeName'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: timeC,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: 'Minutes'),
            ),
            TextField(
              controller: kmC,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: 'Distance (km)'),
            ),
            TextField(
              controller: calC,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: 'Calories'),
            ),
          ],
        ),
        //dit zijn de knoppen die we gebruiken in vul in pagina
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Save'),
          ),
        ],
      ),
    );
    //als er op ok wordt gedrukt dan word de nieuwe activiteit toegevoegd aan de lijst
    if (ok != true) return;

    final minutes = int.tryParse(timeC.text.trim()) ?? 0;
    final km = double.tryParse(kmC.text.trim()) ?? 0.0;
    final cal = int.tryParse(calC.text.trim()) ?? 0;

    //hier word de info berekend en toegevoegd aan de lijst
    setState(() {
      recentActivities.insert(
        0,
        ActivityItem(
          icon: icon,
          title: titleC.text.trim().isEmpty ? typeName : titleC.text.trim(),
          info: '$minutes min • ${km.toStringAsFixed(1)} KM',
          date: 'Today',
          calories: '$cal',
          minutes: minutes,
          km: km,
          cal: cal,
        ),
      );
    });
  }

  //----------------OPBOUW PAGINA----------------//
  //hier bewerk je de layout van de activity pagina
  @override
  Widget build(BuildContext context) {
    //de lijst met maximaal 3 recente activiteiten die worden getoond
    final shownActivities = recentActivities.take(3).toList();
    final workouts = recentActivities.length;
    final totalMin = recentActivities.fold(0, (s, a) => s + a.minutes);
    final totalKm = recentActivities.fold(0.0, (s, a) => s + a.km);
    final totalCal = recentActivities.fold(0, (s, a) => s + a.cal);
    final hours = (totalMin / 60).toStringAsFixed(1);

    //hier begint de pagina layout
    return Scaffold(
      appBar: AppBar(title: const Text('Activity')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //wat er zichbaar is bovenaan de pagina
            GridView.count(
              crossAxisCount: 2,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              children: [
                ActivityTypeCard(
                  icon: Icons.directions_run,
                  label: 'Running',
                  onTap: () => _addActivity(Icons.directions_run, 'Running'),
                ),
                ActivityTypeCard(
                  icon: Icons.pool,
                  label: 'Swimming',
                  onTap: () => _addActivity(Icons.pool, 'Swimming'),
                ),
                ActivityTypeCard(
                  icon: Icons.directions_bike,
                  label: 'Biking',
                  onTap: () => _addActivity(Icons.directions_bike, 'Biking'),
                ),
                ActivityTypeCard(
                  icon: Icons.directions_walk,
                  label: 'Walking',
                  onTap: () => _addActivity(Icons.directions_walk, 'Walking'),
                ),
              ],
            ),

            //----------RECENT ACTIVITIES----------//
            //wat er zichbaar is midden van  de pagina
            const SizedBox(height: 24),
            const Text(
              'Recent Activities',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),

            //hier toon je maximaal 3 recente activiteiten
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.black12),
              ),
              child: Column(
                children: List.generate(
                  shownActivities.isEmpty ? 0 : shownActivities.length * 2 - 1,
                  (i) {
                    if (i.isOdd) return const Divider(height: 1);
                    final index = i ~/ 2;
                    final a = shownActivities[index];

                    //de info die bij elke recente activiteit hoort
                    return ActivityListItem(
                      icon: a.icon,
                      title: a.title,
                      info: a.info,
                      date: a.date,
                      calories: a.calories,
                      onDelete: () {
                        setState(() {
                          recentActivities.remove(a);
                        });
                      },
                    );
                  },
                ),
              ),
            ),

            //wat er zichbaar is in de THIS MONTH sectie onderaan de pagina
            const SizedBox(height: 24),
            const Text(
              'This Month',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            GridView.count(
              crossAxisCount: 2,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              //standard waarden voor de maandstatistieken
              children: [
                MonthStatCard(
                  value: '$workouts',
                  label: 'Workouts',
                  color: Colors.lightBlueAccent,
                ),
                MonthStatCard(
                  value: '$hours hrs',
                  label: 'Active Time',
                  color: Colors.lightGreenAccent,
                ),
                MonthStatCard(
                  value: '${totalKm.toStringAsFixed(1)} km',
                  label: 'Distance',
                  color: CupertinoColors.systemBrown,
                ),
                MonthStatCard(
                  value: '$totalCal',
                  label: 'Burned',
                  color: CupertinoColors.systemYellow,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

//----------------WIDGETS VOOR DE HELE ACTIVITY PAGINA----------------//
class ActivityTypeCard extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const ActivityTypeCard({
    super.key,
    required this.icon,
    required this.label,
    required this.onTap,
  });

  //hier wordt de layout van elke type beschikbare activiteit kaart opgebouwd
  @override
  Widget build(BuildContext context) {
    return Material(
      color: const Color(0xFFE5E5E5),
      borderRadius: BorderRadius.circular(14),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(14),
        child: SizedBox(
          height: 120,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 44),
              const SizedBox(height: 8),
              Text(label, style: const TextStyle(fontWeight: FontWeight.w600)),
            ],
          ),
        ),
      ),
    );
  }
}

//-----------RECENTE ACTIVITEIT ITEM WIDGET-----------//
//hier wordt de layout van elk item in de recente activiteiten lijst opgebouwd van wat er in de lijst staat
class ActivityListItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final String info;
  final String date;
  final String calories;
  final VoidCallback onDelete;

  const ActivityListItem({
    super.key,
    required this.icon,
    required this.title,
    required this.info,
    required this.date,
    required this.calories,
    required this.onDelete,
  });

  //-----------RECENTE ACTIVITEIT WIDGET-----------//
  //hier wordt de layout van elke recente activiteit opgebouwd
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
      //hier is de delete knop en de calorieën info
      trailing: SizedBox(
        width: 60,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            InkWell(onTap: onDelete, child: const Icon(Icons.close, size: 18)),
            const SizedBox(height: 4),
            Text(
              calories,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
            ),
          ],
        ),
      ),

      isThreeLine: true,
    );
  }
}

//-----------MAANDSTATISTIEKEN WIDGET-----------//
//hier wordt de layout van elke maandstatistiek opgebouwd
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

  //dit is de info die in elke maandstatistiek kaartje komt te staan
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
