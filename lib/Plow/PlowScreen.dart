// lib/screens/PlowScreen.dart
import 'package:flutter/material.dart';

class Plot {
  bool isPlowed;
  String? animal;

  Plot({this.isPlowed = false, this.animal});
}

class PlowScreen extends StatefulWidget {
  const PlowScreen({super.key});

  @override
  State<PlowScreen> createState() => _PlowScreenState();
}

class _PlowScreenState extends State<PlowScreen> {
  List<Plot> plots = List.generate(9, (index) => Plot());
  int coins = 100;

  void plowPlot(int index) {
    if (!plots[index].isPlowed && coins >= 5) {
      setState(() {
        plots[index].isPlowed = true;
        coins -= 5;
      });
    }
  }

  void placeAnimal(int index, String animalType) {
    if (plots[index].isPlowed && plots[index].animal == null && coins >= 30) {
      setState(() {
        plots[index].animal = animalType;
        coins -= 30;
      });
    }
  }

  void _showAnimalChoice(int index) {
    showModalBottomSheet(
        context: context,
        builder: (_) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: Image.asset("assets/images/sheep.png", height: 30),
                title: Text("خروف 🐑"),
                onTap: () {
                  Navigator.pop(context);
                  placeAnimal(index, "sheep");
                },
              ),
              ListTile(
                leading: Image.asset("assets/images/goat.png", height: 30),
                title: Text("معزة 🐐"),
                onTap: () {
                  Navigator.pop(context);
                  placeAnimal(index, "goat");
                },
              ),
            ],
          );
        });
  }

  Widget buildPlot(int index) {
    final plot = plots[index];

    return GestureDetector(
      onTap: () {
        if (!plot.isPlowed) {
          plowPlot(index);
        } else if (plot.animal == null) {
          _showAnimalChoice(index);
        }
      },
      child: Container(
        margin: EdgeInsets.all(6),
        decoration: BoxDecoration(
          color: plot.animal != null
              ? Colors.transparent
              : plot.isPlowed
                  ? Colors.brown[300]
                  : Colors.green[300],
          border: Border.all(color: Colors.black),
        ),
        child: Center(
          child: plot.animal != null
              ? Image.asset("assets/images/${plot.animal}.png", height: 50)
              : Text(plot.isPlowed ? "محروث" : "غير محروث"),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("🌱 حرث الأرض"), backgroundColor: Colors.green),
      body: Column(
        children: [
          SizedBox(height: 10),
          Text("💰 رصيدك: $coins", style: TextStyle(fontSize: 18)),
          Expanded(
            child: GridView.builder(
              itemCount: plots.length,
              padding: EdgeInsets.all(12),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3),
              itemBuilder: (_, index) => buildPlot(index),
            ),
          ),
        ],
      ),
    );
  }
}
