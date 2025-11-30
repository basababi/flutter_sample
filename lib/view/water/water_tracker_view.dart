import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:fitness/common/colo_extention.dart';

class WaterTrackerView extends StatefulWidget {
  const WaterTrackerView({super.key});

  @override
  State<WaterTrackerView> createState() => _WaterTrackerViewState();
}

class _WaterTrackerViewState extends State<WaterTrackerView>
    with SingleTickerProviderStateMixin {
  double currentWater = 500; // ml
  final double maxWater = 2000;

  late AnimationController _animationController;
  late Animation<double> _waterAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    );

    _waterAnimation = Tween<double>(begin: 0, end: currentWater / maxWater)
        .animate(
          CurvedAnimation(
            parent: _animationController,
            curve: Curves.easeOutCubic,
          ),
        );

    _animationController.forward();
  }

  @override
  void didUpdateWidget(covariant WaterTrackerView oldWidget) {
    super.didUpdateWidget(oldWidget);
    _waterAnimation =
        Tween<double>(
          begin: _waterAnimation.value,
          end: currentWater / maxWater,
        ).animate(
          CurvedAnimation(
            parent: _animationController,
            curve: Curves.easeOutCubic,
          ),
        );
    _animationController.forward(from: 0);
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  String _getStatus() {
    if (currentWater >= 2000) return "Perfect";
    if (currentWater >= 1200) return "Good";
    if (currentWater >= 600) return "Poor";
    return "Dry";
  }

  Color _getStatusColor() {
    if (currentWater >= 2000) return Colors.cyan;
    if (currentWater >= 1200) return Colors.lightBlue;
    if (currentWater >= 600) return Colors.orange;
    return Colors.redAccent;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1E1E1E),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          "Таны хэрэглэсэн ус",
          style: GoogleFonts.notoSans(color: Colors.white, fontSize: 18),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Column(
          children: [
            const SizedBox(height: 40),

            Expanded(
              child: Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  Container(
                    width: 180,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.white24, width: 4),
                      borderRadius: BorderRadius.circular(90),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(86),
                      child: AnimatedBuilder(
                        animation: _waterAnimation,
                        builder: (context, child) {
                          return Align(
                            alignment: Alignment.bottomCenter,
                            child: Container(
                              height: 300 * _waterAnimation.value,
                              decoration: const BoxDecoration(
                                gradient: LinearGradient(
                                  begin: Alignment.bottomCenter,
                                  end: Alignment.topCenter,
                                  colors: [
                                    Color(0xFF00D4FF),
                                    Color(0xFF0099CC),
                                  ],
                                ),
                              ),
                              child: Stack(
                                children: [
                                  ...List.generate(8, (i) {
                                    return Positioned(
                                      left: 20 + i * 20,
                                      bottom: 20 + i * 30,
                                      child: Opacity(
                                        opacity: _waterAnimation.value,
                                        child: Container(
                                          width: 20 + i * 5,
                                          height: 20 + i * 5,
                                          decoration: const BoxDecoration(
                                            color: Colors.white24,
                                            shape: BoxShape.circle,
                                          ),
                                        ),
                                      ),
                                    );
                                  }),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),

                  // Усны хэмжээ текст
                  Positioned(
                    top: 60,
                    child: Column(
                      children: [
                        Text(
                          "${currentWater.toInt()}ml",
                          style: GoogleFonts.notoSans(
                            color: Colors.white,
                            fontSize: 36,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          _getStatus(),
                          style: GoogleFonts.notoSans(
                            color: _getStatusColor(),
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 40),

            // Усны тэмдэглэгээ (250ml, 500ml, гэх мэт)
            Column(
              children: [750, 500, 250, 0].map((level) {
                bool isActive = currentWater >= level;
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: Row(
                    children: [
                      Text(
                        "${level}ml",
                        style: GoogleFonts.notoSans(
                          color: isActive ? Colors.white : Colors.white38,
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Container(
                          height: 4,
                          decoration: BoxDecoration(
                            color: isActive ? Colors.cyan : Colors.white24,
                            borderRadius: BorderRadius.circular(2),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),

            const SizedBox(height: 50),

            // +250ml товч
            GestureDetector(
              onTap: () {
                setState(() {
                  currentWater = (currentWater + 250).clamp(0, maxWater);
                });
              },
              child: Container(
                width: 70,
                height: 70,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: TColor.primaryGradientColors,
                  ),
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: TColor.primaryColor2.withOpacity(0.5),
                      blurRadius: 20,
                      spreadRadius: 5,
                    ),
                  ],
                ),
                child: const Icon(
                  Icons.water_drop,
                  color: Colors.white,
                  size: 36,
                ),
              ),
            ),

            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}
