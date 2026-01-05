import 'package:flutter/material.dart';

class OverviewPage extends StatelessWidget {
  const OverviewPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Overview')),
      body: const Center(
        child: Text('Overview Page', style: TextStyle(fontSize: 20)),
      ),
    );
  }
}
