import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:fitness/common/colo_extention.dart';
import 'package:fitness/view/water/water_tracker_view.dart';
import 'package:fitness/common_widget/qr_overlay.dart';

class HomeTab extends StatefulWidget {
  const HomeTab({super.key});

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  bool showQR = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1E1E1E),
      body: SafeArea(
        child: Stack(
          children: [
            SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            showQR = true;
                          });
                        },
                        child: Container(
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: TColor.primaryGradientColors,
                            ),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: const Icon(
                            Icons.fitness_center,
                            color: Colors.white,
                            size: 28,
                          ),
                        ),
                      ),
                      const SizedBox(width: 15),
                      Text(
                        "WOLVES",
                        style: GoogleFonts.notoSans(
                          color: TColor.primaryColor2,
                          fontSize: 24,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      const Spacer(),
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.notifications_none,
                          color: Colors.white70,
                          size: 28,
                        ),
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.more_vert,
                          color: Colors.white70,
                          size: 28,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 25),

                  // MARK: Эрүүл мэндийн оноо
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: TColor.primaryGradientColors,
                      ),
                      borderRadius: BorderRadius.circular(25),
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 90,
                          height: 90,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            gradient: const LinearGradient(
                              colors: [
                                Color(0xFF5A4FF3),
                                Color.fromARGB(255, 196, 189, 223),
                              ],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                          ),
                          alignment: Alignment.center,
                          child: Text(
                            "78",
                            style: GoogleFonts.notoSans(
                              color: Colors.white,
                              fontSize: 32,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Эрүүл мэндийн оноо",
                                style: GoogleFonts.notoSans(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 6),
                              Text(
                                "Өнөөдрийн цуглуулж\nчадсан оноо",
                                style: GoogleFonts.notoSans(
                                  color: const Color.fromARGB(
                                    179,
                                    224,
                                    213,
                                    213,
                                  ),
                                  fontSize: 14,
                                  height: 1.2,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 25),

                  // MARK: Калори + Ус
                  Row(
                    children: [
                      Expanded(
                        child: _infoCard(
                          icon: Icons.local_fire_department,
                          value: "720",
                          unit: "Cal",
                          title: "Өнөөдөр шатаасан",
                          gradient: const [
                            Color(0xFFFF6B6B),
                            Color(0xFFFF8E8E),
                          ],
                        ),
                      ),
                      const SizedBox(width: 15),
                      Expanded(
                        child: GestureDetector(
                          onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const WaterTrackerView(),
                            ),
                          ),
                          child: _infoCard(
                            icon: Icons.water_drop,
                            value: "500",
                            unit: "ml",
                            title: "Ус уусан",
                            gradient: const [
                              Color(0xFF6B66FF),
                              Color(0xFF8E8AFF),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 30),
                  Text(
                    "Өнөөдрийн төлөвлөгөө",
                    style: GoogleFonts.notoSans(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 15),

                  // Calendar
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: List.generate(7, (i) {
                      final days = ["Да", "Мя", "Лх", "Пү", "Ба", "Бя", "Ня"];
                      final bool isToday = i == 3;
                      return Column(
                        children: [
                          Text(
                            days[i],
                            style: GoogleFonts.notoSans(
                              color: isToday
                                  ? TColor.primaryColor2
                                  : Colors.white54,
                              fontSize: 12,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Container(
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                              color: isToday
                                  ? TColor.primaryColor2
                                  : Colors.transparent,
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(
                                color: isToday
                                    ? TColor.primaryColor2
                                    : Colors.white24,
                              ),
                            ),
                            child: Center(
                              child: Text(
                                "${18 + i}",
                                style: GoogleFonts.notoSans(
                                  color: isToday
                                      ? Colors.white
                                      : Colors.white70,
                                  fontWeight: isToday
                                      ? FontWeight.bold
                                      : FontWeight.normal,
                                ),
                              ),
                            ),
                          ),
                        ],
                      );
                    }),
                  ),

                  const SizedBox(height: 25),

                  _workoutCard(
                    time: "09:00",
                    title: "Хөл/бөгс дасгал",
                    sets: "4x15",
                    color: const Color(0xFF9C6BFF),
                  ),
                  const SizedBox(height: 15),
                  _workoutCard(
                    time: "14:00",
                    title: "Кардио",
                    sets: "30 мин",
                    color: const Color(0xFFFF6B6B),
                  ),

                  const SizedBox(
                    height: 100,
                  ), // Bottom bar-тай хальж орохгүй байх
                ],
              ),
            ),

            // === QR OVERLAY ===
            if (showQR)
              QROverlay(
                onClose: () {
                  setState(() => showQR = false);
                },
              ),
          ],
        ),
      ),
    );
  }

  // MARK: Info Card
  Widget _infoCard({
    required IconData icon,
    required String value,
    required String unit,
    required String title,
    required List<Color> gradient,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(colors: gradient),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: Colors.white, size: 32),
          const SizedBox(height: 12),
          Text(
            value,
            style: GoogleFonts.notoSans(
              color: Colors.white,
              fontSize: 32,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            unit,
            style: GoogleFonts.notoSans(color: Colors.white70, fontSize: 14),
          ),
          const SizedBox(height: 8),
          Text(
            title,
            style: GoogleFonts.notoSans(color: Colors.white, fontSize: 13),
          ),
        ],
      ),
    );
  }

  // MARK: Workout Card
  Widget _workoutCard({
    required String time,
    required String title,
    required String sets,
    required Color color,
  }) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: color.withOpacity(0.15),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: color.withOpacity(0.4)),
      ),
      child: Row(
        children: [
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(15),
            ),
            child: const Icon(Icons.fitness_center, color: Colors.white),
          ),
          const SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  time,
                  style: GoogleFonts.notoSans(
                    color: Colors.white54,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  title,
                  style: GoogleFonts.notoSans(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              sets,
              style: GoogleFonts.notoSans(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
