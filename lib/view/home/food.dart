// lib/view/food/food_tab.dart
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:fitness/common/colo_extention.dart';
import 'package:percent_indicator/percent_indicator.dart';

class FoodTab extends StatefulWidget {
  const FoodTab({super.key});

  @override
  State<FoodTab> createState() => _FoodTabState();
}

class _FoodTabState extends State<FoodTab> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  final todayMeal = {
    "image": "assets/img/breakfast.jpg",
    "name": "Өндөг талх хахахахах",
    "protein": "18г",
    "fat": "12г",
    "carbs": "45г",
    "calories": "420",
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1E1E1E),
      body: SafeArea(
        child: Column(
          children: [
            // MARK: Top Tabs
            Container(
              margin: const EdgeInsets.fromLTRB(20, 10, 20, 10),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.1),
                borderRadius: BorderRadius.circular(30),
              ),
              child: TabBar(
                controller: _tabController,
                labelColor: Colors.white,
                unselectedLabelColor: Colors.white54,
                tabs: const [
                  Tab(text: "All"),
                  Tab(text: "Breakfast"),
                  Tab(text: "Lunch"),
                ],
              ),
            ),

            // MARK: Today Header
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: [
                  IconButton(
                    icon: const Icon(
                      Icons.arrow_back_ios,
                      color: Colors.white70,
                      size: 20,
                    ),
                    onPressed: () {},
                  ),
                  Expanded(
                    child: Text(
                      "Today",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.notoSans(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(
                      Icons.calendar_today,
                      color: Colors.white70,
                      size: 24,
                    ),
                    onPressed: () {},
                  ),
                  IconButton(
                    icon: const Icon(
                      Icons.arrow_forward_ios,
                      color: Colors.white70,
                      size: 20,
                    ),
                    onPressed: () {},
                  ),
                ],
              ),
            ),

            const SizedBox(height: 15),

            // MARK: БҮХ АГУУЛГЫГ SCROLL ХИЙХ БОЛОМЖТОЙ БОЛГОНО
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    // MARK: Today's Meal Card
                    Container(
                      height: 220,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(24),
                        image: DecorationImage(
                          image: AssetImage(todayMeal["image"]!),
                          fit: BoxFit.cover,
                          colorFilter: ColorFilter.mode(
                            Colors.black.withOpacity(0.5),
                            BlendMode.dstATop,
                          ),
                        ),
                      ),
                      child: Stack(
                        children: [
                          Positioned(
                            bottom: 20,
                            left: 20,
                            right: 20,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  todayMeal["name"]!,
                                  style: GoogleFonts.notoSans(
                                    color: Colors.white,
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 10),
                                Row(
                                  children: [
                                    _macroChip(
                                      "Өндөг",
                                      const Color(0xFFFFD700),
                                    ),
                                    const SizedBox(width: 12),
                                    _macroChip("Шош", Colors.blue),
                                    const SizedBox(width: 12),
                                    _macroChip("Талх", const Color(0xFFD2691E)),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 30),

                    // MARK: Calories Circle
                    Container(
                      padding: const EdgeInsets.all(28),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.08),
                        borderRadius: BorderRadius.circular(28),
                      ),
                      child: Column(
                        children: [
                          Text(
                            "Calories",
                            style: GoogleFonts.notoSans(
                              color: Colors.white70,
                              fontSize: 16,
                            ),
                          ),
                          const SizedBox(height: 20),
                          CircularPercentIndicator(
                            radius: 90,
                            lineWidth: 18,
                            percent: 420 / 2000, // динамикаар өөрчлөгдөнө
                            center: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  "420",
                                  style: GoogleFonts.notoSans(
                                    color: Colors.white,
                                    fontSize: 36,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  "Cals",
                                  style: GoogleFonts.notoSans(
                                    color: Colors.white70,
                                    fontSize: 16,
                                  ),
                                ),
                              ],
                            ),
                            progressColor: TColor.primaryColor2,
                            backgroundColor: Colors.white.withOpacity(0.15),
                            circularStrokeCap: CircularStrokeCap.round,
                          ),
                          const SizedBox(height: 25),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              _macroRow(
                                "Нүүрс ус",
                                "45г",
                                const Color(0xFF6B66FF),
                              ),
                              _macroRow(
                                "Уураг",
                                "18г",
                                const Color(0xFF00D4FF),
                              ),
                              _macroRow("Өөх", "12г", const Color(0xFFFF6B6B)),
                            ],
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 35),

                    // MARK: Add Button
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            "Хоол",
                            style: GoogleFonts.notoSans(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            backgroundColor: TColor.primaryColor2,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 30,
                              vertical: 14,
                            ),
                          ),
                          child: Text(
                            "Add",
                            style: GoogleFonts.notoSans(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 100),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _macroChip(String text, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: color.withOpacity(0.3),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: color.withOpacity(0.5)),
      ),
      child: Text(
        text,
        style: GoogleFonts.notoSans(
          color: Colors.white,
          fontSize: 13,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  Widget _macroRow(String label, String value, Color color) {
    return Column(
      children: [
        Text(
          label,
          style: GoogleFonts.notoSans(color: Colors.white70, fontSize: 14),
        ),
        const SizedBox(height: 6),
        Text(
          value,
          style: GoogleFonts.notoSans(
            color: color,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
