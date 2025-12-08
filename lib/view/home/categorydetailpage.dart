import 'package:flutter/material.dart';

class CategoryDetailPage extends StatelessWidget {
  final Map<String, String> category;

  const CategoryDetailPage({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(category["title"]!),
        backgroundColor: const Color(0xFF212329),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Image.asset(category["image"]!, width: 200, height: 200),
            const SizedBox(height: 20),
            Text(
              category["description"]!,
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context); // Буцах
              },
              child: const Text("Буцах"),
            ),
          ],
        ),
      ),
    );
  }
}
