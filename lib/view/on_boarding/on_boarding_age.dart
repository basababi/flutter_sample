import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:fitness/common/colo_extention.dart';

class AgeSelectionView extends StatefulWidget {
  const AgeSelectionView({super.key});

  @override
  State<AgeSelectionView> createState() => _AgeSelectionViewState();
}

class _AgeSelectionViewState extends State<AgeSelectionView> {
  late FixedExtentScrollController _controller;
  int selectedAge = 25;

  @override
  void initState() {
    super.initState();
    _controller = FixedExtentScrollController(initialItem: selectedAge - 1);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

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
                "Та өөрийн насаа оруулна уу",
                textAlign: TextAlign.center,
                style: GoogleFonts.notoSans(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 40),

              Expanded(
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Positioned(
                      top: 180,
                      child: Container(
                        width: 100,
                        height: 70,
                        decoration: BoxDecoration(
                          border: Border(
                            top: BorderSide(
                              color: TColor.primaryColor2.withOpacity(0.5),
                              width: 2,
                            ),
                            bottom: BorderSide(
                              color: TColor.primaryColor2.withOpacity(0.5),
                              width: 2,
                            ),
                          ),
                        ),
                      ),
                    ),

                    SizedBox(
                      height: 220,
                      child: ListWheelScrollView.useDelegate(
                        controller: _controller,
                        itemExtent: 70,
                        physics: const FixedExtentScrollPhysics(),
                        perspective: 0.002,
                        diameterRatio: 1.8,
                        onSelectedItemChanged: (index) {
                          setState(() {
                            selectedAge = index + 1;
                          });
                        },
                        childDelegate: ListWheelChildBuilderDelegate(
                          builder: (context, index) {
                            if (index < 0) return null;
                            final age = index + 1;
                            final isSelected = age == selectedAge;

                            return Center(
                              child: AnimatedContainer(
                                duration: const Duration(milliseconds: 200),
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 24,
                                ),
                                decoration: BoxDecoration(
                                  color: isSelected
                                      ? TColor.primaryColor2
                                      : Colors.transparent,
                                  borderRadius: BorderRadius.circular(35),
                                ),
                                child: Text(
                                  "$age",
                                  style: GoogleFonts.notoSans(
                                    color: isSelected
                                        ? Colors.white
                                        : Colors.white70,
                                    fontSize: isSelected ? 36 : 26,
                                    fontWeight: isSelected
                                        ? FontWeight.bold
                                        : FontWeight.normal,
                                  ),
                                ),
                              ),
                            );
                          },
                          childCount: 100,
                        ),
                      ),
                    ),

                    Positioned(
                      right: 60,
                      top: 200,
                      child: Text(
                        "нас",
                        style: GoogleFonts.notoSans(
                          color: Colors.white70,
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              Text(
                "$selectedAge нас",
                style: GoogleFonts.notoSans(
                  color: TColor.primaryColor2,
                  fontSize: 48,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }
}
