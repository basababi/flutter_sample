import 'package:flutter/material.dart';
import 'categorydetailpage.dart';
import '/common/colo_extention.dart';
import 'package:google_fonts/google_fonts.dart';

class GymTab extends StatefulWidget {
  const GymTab({super.key});

  @override
  State<GymTab> createState() => _GymTabState();
}

class _GymTabState extends State<GymTab> {
  final List<Map<String, String>> categories = const [
    {
      "title": "Yoga",
      "image": "assets/img/yoga.jpg",
      "description": "Биеийн уян хатан байдлыг сайжруулна.",
    },
    {
      "title": "Fitness",
      "image": "assets/img/fitness.jpg",
      "description": "Биеийн хүч, булчингийн хөгжилд зориулагдсан.",
    },
    {
      "title": "Cardio",
      "image": "assets/img/cardio.jpg",
      "description": "Зүрх судасны эрүүл мэндийг дэмжинэ.",
    },
    {
      "title": "Pilates",
      "image": "assets/img/pilates.jpg",
      "description": "Булчин ба тэнцвэрийн дасгал.",
    },
  ];

  final List<Map<String, dynamic>> todayWorkouts = [
    {"name": "10 минутын халаалт", "done": false},
    {"name": "15 минутын cardio", "done": false},
    {"name": "20 минутын yoga сунгалт", "done": false},
    {"name": "30 минутын fitness дасгал", "done": false},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: TColor.grayColor,
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [TColor.blackColor, TColor.grayColor],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // --- Grid хэсэг ---
                GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: categories.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4,
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 12,
                    childAspectRatio: 1,
                  ),
                  itemBuilder: (context, index) {
                    final cat = categories[index];
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                CategoryDetailPage(category: cat),
                          ),
                        );
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              blurRadius: 4,
                              offset: const Offset(2, 2),
                            ),
                          ],
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(12),
                              child: Image.asset(
                                cat["image"]!,
                                width: 45,
                                height: 45,
                                fit: BoxFit.cover,
                              ),
                            ),
                            const SizedBox(height: 6),
                            Text(
                              cat["title"]!,
                              style: const TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.bold,
                                color: Color.fromARGB(255, 14, 0, 86),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),

                const SizedBox(height: 25),
                const Text(
                  "Өнөөдөр",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 30,
                    fontFamily: 'Arial',
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),

                Column(
                  children: todayWorkouts.map((item) {
                    return Card(
                      color: Colors.white,
                      margin: const EdgeInsets.symmetric(vertical: 6),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: CheckboxListTile(
                        title: Text(
                          item["name"],
                          style: TextStyle(
                            color: item["done"]
                                ? Colors.grey
                                : const Color.fromARGB(255, 14, 0, 86),
                            decoration: item["done"]
                                ? TextDecoration.lineThrough
                                : TextDecoration.none,
                          ),
                        ),
                        value: item["done"],
                        onChanged: (value) {
                          setState(() {
                            item["done"] = value!;
                          });
                        },
                      ),
                    );
                  }).toList(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
