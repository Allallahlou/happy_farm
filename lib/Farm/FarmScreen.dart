import 'package:flutter/material.dart';
import 'package:happy_farm/Land/LandScreen.dart';
import 'package:happy_farm/Plow/PlowScreen.dart';
import 'package:happy_farm/Store/StoreScreen.dart';

class FarmScreen extends StatefulWidget {
  const FarmScreen({super.key});

  @override
  State<FarmScreen> createState() => _FarmScreenState();
}

class _FarmScreenState extends State<FarmScreen> {
  int coins = 50;
  int food = 10;
  int totalCoins = 0;

  List<String> animals = ['goat', 'sheep'];

  void feedAnimal() {
    if (food > 0) {
      setState(() {
        food--;
        coins += 5; // تربح من الحيوان بعد إطعامه
      });
    }
  }

  void buyAnimal() {
    if (coins >= 30) {
      setState(() {
        coins -= 30;
        animals.add('sheep');
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("🐑 مزرعتي السعيدة")),
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [Text("🍖 الطعام: $food"), Text("💰 النقود: $coins")],
          ),
          Expanded(
            child: GridView.builder(
              itemCount: animals.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
              ),
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    Image.asset(
                      "assets/images/${animals[index]}.png",
                      height: 80,
                    ),
                    ElevatedButton(onPressed: feedAnimal, child: Text("إطعام")),
                  ],
                );
              },
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(onPressed: buyAnimal, child: Text("شراء خروف 🐑")),
              // داخل FarmScreen
              ElevatedButton(
                onPressed: () async {
                  final harvested = await Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => LandScreen()),
                  );

                  if (harvested != null && harvested is int && harvested > 0) {
                    final coins = await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => StoreScreen(crops: harvested),
                      ),
                    );

                    if (coins != null && coins is int) {
                      setState(() {
                        totalCoins += coins;
                      });
                    }
                  }
                },
                child: Text("🚜 الاشتغال في الأرض"),
              ),

              ElevatedButton(
                onPressed: () {
                  setState(() {
                    food += 5;
                  });
                },
                child: Text("شراء طعام 🍖"),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => PlowScreen()),
                  );
                },
                child: Text("🌾 حرث "),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
