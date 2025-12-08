import 'package:flutter/material.dart';
import 'categorydetailpage.dart';
import 'package:google_fonts/google_fonts.dart';
import '../gym_tab/yoga.dart';
import '../gym_tab/fitness.dart';
import '../gym_tab/cardio.dart';
import '../gym_tab/pilates.dart';

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

  void _openCategory(String? title, Map<String, String> cat) {
    if (title == null) return;

    if (title == 'Yoga') {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => YogaPage()),
      );
    } else if (title == 'Fitness') {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => FitnessPage()),
      );
    } else if (title == 'Cardio') {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => CardioPage()),
      );
    } else if (title == 'Pilates') {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => PilatesPage()),
      );
    } else {
      // fallback to generic detail page
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => CategoryDetailPage(category: cat),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1E1E1E),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF1E1E1E), Color(0xFF1E1E1E)],
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
                // --- Ангилал Text ---
                Text(
                  "Ангилал",
                  style: GoogleFonts.poppins(
                    color: Colors.white,
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1,
                    shadows: [
                      Shadow(
                        blurRadius: 6,
                        color: Colors.black.withOpacity(0.6),
                        offset: const Offset(1, 2),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 10),

                // --- Grid ---
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
                      onTap: () => _openCategory(cat["title"], cat),
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

                // 🔥 TodayWorkouts background
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: const Color(0xFF5b5b5b),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: const Color(0xB5b5b5b5)),
                  ),
                  child: Column(
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
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
