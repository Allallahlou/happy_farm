import 'dart:async';
import 'package:flutter/material.dart';

class LandScreen extends StatefulWidget {
  const LandScreen({super.key});

  @override
  State<LandScreen> createState() => _LandScreenState();
}

class _LandScreenState extends State<LandScreen> {
  int progress = 0;
  bool isPlowed = false;
  bool isPlanted = false;
  bool isGrown = false;
  int crops = 0;

  void plowLand() {
    if (!isPlowed && progress < 100) {
      setState(() {
        progress += 10;
        if (progress >= 100) {
          isPlowed = true;
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("✅ الأرض أصبحت محروثة!")),
          );
        }
      });
    }
  }

  void plantCrop() {
    if (isPlowed && !isPlanted) {
      setState(() {
        isPlanted = true;
      });
      Timer(Duration(seconds: 10), () {
        setState(() {
          isGrown = true;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("🌾 المحصول جاهز للحصاد!")),
        );
      });
    }
  }

  void harvest() {
    if (isGrown) {
      setState(() {
        crops += 5;
        progress = 0;
        isPlowed = false;
        isPlanted = false;
        isGrown = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("✅ تم حصد المحصول!")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("🌾 الأرض")),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Text("حالة الحرث: $progress%", style: TextStyle(fontSize: 18)),
            LinearProgressIndicator(value: progress / 100),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: plowLand,
              child: Text("🔨 حرث الأرض"),
            ),
            if (isPlowed && !isPlanted)
              ElevatedButton(
                onPressed: plantCrop,
                child: Text("🌱 غرس المحصول"),
              ),
            if (isPlanted && !isGrown)
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("⏳ المحصول ينمو... انتظر 10 ثواني"),
              ),
            if (isGrown)
              ElevatedButton(
                onPressed: harvest,
                child: Text("🔪 حصاد المحصول"),
              ),
            SizedBox(height: 30),
            Text("📦 المحصول: $crops", style: TextStyle(fontSize: 20)),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context, crops); // نرجع المحصول
              },
              child: Text("🏪 الرجوع وبيع المحصول"),
            ),
          ],
        ),
      ),
    );
  }
}
