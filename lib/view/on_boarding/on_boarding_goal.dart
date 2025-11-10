import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:fitness/common/colo_extention.dart';

class GoalSelectionView extends StatefulWidget {
  const GoalSelectionView({super.key});

  @override
  State<GoalSelectionView> createState() => _GoalSelectionViewState();
}

class _GoalSelectionViewState extends State<GoalSelectionView> {
  String? selectedGoal;

  final List<Map<String, String>> goals = [
    {
      "title": "Булчингаа томруулах",
      "icon": "assets/img/assets/img/muscle.png",
    },
    {"title": "Өөх шатаах", "icon": "assets/img/fire.png"},
    {"title": "Хүч нэмэх", "icon": "assets/img/strength.png"},
    {"title": "Сайхан галбир", "icon": "assets/img/shape.png"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1E1E1E),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 30),
          child: Column(
            children: [
              Text(
                "Та өөрийн зорилгоо сонгоно уу",
                textAlign: TextAlign.center,
                style: GoogleFonts.notoSans(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 40),

              Expanded(
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 15,
                    mainAxisSpacing: 15,
                    childAspectRatio: 1.8,
                  ),
                  itemCount: goals.length,
                  itemBuilder: (context, index) {
                    var goal = goals[index];
                    bool isSelected = selectedGoal == goal["title"];
                    return GestureDetector(
                      onTap: () => setState(() => selectedGoal = goal["title"]),
                      child: Container(
                        decoration: BoxDecoration(
                          gradient: isSelected
                              ? LinearGradient(
                                  colors: TColor.primaryGradientColors,
                                )
                              : null,
                          color: isSelected ? null : Colors.grey[800],
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(
                            color: isSelected
                                ? TColor.primaryColor1
                                : Colors.transparent,
                            width: 2,
                          ),
                        ),
                        child: Center(
                          child: Text(
                            goal["title"]!,
                            textAlign: TextAlign.center,
                            style: GoogleFonts.notoSans(
                              color: Colors.white,
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
