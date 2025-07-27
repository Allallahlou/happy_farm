import 'package:flutter/material.dart';

class StoreScreen extends StatelessWidget {
  final int crops;

  const StoreScreen({super.key, required this.crops});

  @override
  Widget build(BuildContext context) {
    int coinsEarned = crops * 5;

    return Scaffold(
      appBar: AppBar(title: Text("🏪 محل البيع")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("📦 المحصول: $crops", style: TextStyle(fontSize: 22)),
            Text("💰 ستحصل على: $coinsEarned درهم", style: TextStyle(fontSize: 22)),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context, coinsEarned);
              },
              child: Text("✅ بيع"),
            )
          ],
        ),
      ),
    );
  }
}
