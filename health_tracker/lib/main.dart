import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'navigation/bottom_nav_bar.dart';
import 'model/healthdata.dart'; // new file for shared weight

void main() {
  runApp(
    ChangeNotifierProvider(create: (_) => HealthData(), child: const MyApp()),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: BottomNavBar(),
    );
  }
}
