import 'package:flutter/material.dart';

class LandScreen extends StatefulWidget {
  const LandScreen({super.key});

  @override
  State<LandScreen> createState() => _LandScreenState();
}

class _LandScreenState extends State<LandScreen> {
  int progress = 0;
  bool isTilled = false;
  bool hasCrop = false;
  bool isHarvested = false;
  int coins = 0;

  void tillLand() async {
    if (isTilled) return;
    for (int i = 1; i <= 100; i++) {
      await Future.delayed(Duration(milliseconds: 20));
      setState(() => progress = i);
    }
    setState(() => isTilled = true);
  }

  void plantCrop() {
    if (isTilled && !hasCrop) {
      setState(() => hasCrop = true);
    }
  }

  void harvestCrop() {
    if (hasCrop) {
      setState(() {
        hasCrop = false;
        isHarvested = true;
      });
    }
  }

  void sellProduct() {
    if (isHarvested) {
      setState(() {
        coins += 50;
        isTilled = false;
        progress = 0;
        isHarvested = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("🧑‍🌾 أرض الزراعة")),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            Text("💰 النقود: $coins", style: TextStyle(fontSize: 20)),
            const SizedBox(height: 20),
            LinearProgressIndicator(
              value: progress / 100,
              backgroundColor: Colors.grey[300],
              color: Colors.brown,
              minHeight: 10,
            ),
            const SizedBox(height: 20),
            Container(
              height: 150,
              width: double.infinity,
              decoration: BoxDecoration(
                color: isHarvested
                    ? Colors.yellow
                    : (hasCrop ? Colors.green : (isTilled ? Colors.brown : Colors.grey[400])),
                borderRadius: BorderRadius.circular(12),
              ),
              alignment: Alignment.center,
              child: Text(
                isHarvested
                    ? "✅ جاهز للبيع"
                    : (hasCrop
                        ? "🌾 المحصول جاهز"
                        : (isTilled ? "🪴 مزروع" : "⛏️ غير محروت")),
                style: const TextStyle(fontSize: 22, color: Colors.white),
              ),
            ),
            const SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton.icon(
                  onPressed: tillLand,
                  icon: Icon(Icons.agriculture),
                  label: Text("حرث"),
                ),
                ElevatedButton.icon(
                  onPressed: plantCrop,
                  icon: Icon(Icons.grass),
                  label: Text("زرع"),
                ),
                ElevatedButton.icon(
                  onPressed: harvestCrop,
                  icon: Icon(Icons.scale),
                  label: Text("حصد"),
                ),
              ],
            ),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              onPressed: sellProduct,
              icon: Icon(Icons.store),
              label: Text("بيع المنتج"),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orange,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
