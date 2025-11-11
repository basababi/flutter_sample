import 'package:flutter/material.dart';

class FoodTab extends StatelessWidget {
  const FoodTab({super.key});

  final List<Map<String, String>> foodList = const [
    // {"name": "Salad", "image": "lib/assets/img/salad.png"},
    //{"name": "Chicken", "image": "lib/assets/img/chicken.png"},
    //{"name": "Smoothie", "image": "lib/assets/img/smoothie.png"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Food')),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: foodList.length,
        itemBuilder: (context, index) {
          final food = foodList[index];
          return Card(
            margin: const EdgeInsets.symmetric(vertical: 8),
            child: ListTile(
              leading: Image.asset(food["image"]!, width: 50, height: 50),
              title: Text(food["name"]!),
            ),
          );
        },
      ),
    );
  }
}
