import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:fitness/common/colo_extention.dart';

class WeightSelectionView extends StatefulWidget {
  const WeightSelectionView({super.key});

  @override
  State<WeightSelectionView> createState() => _WeightSelectionViewState();
}

class _WeightSelectionViewState extends State<WeightSelectionView> {
  late FixedExtentScrollController _controller;
  int selectedWeight = 65;

  @override
  void initState() {
    super.initState();

    _controller = FixedExtentScrollController(initialItem: selectedWeight - 30);
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
                "Та өөрийн жинээ оруулна уу",
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

                    NotificationListener<ScrollNotification>(
                      onNotification: (notification) {
                        if (notification is ScrollUpdateNotification) {
                          final index = _controller.selectedItem;
                          setState(() {
                            selectedWeight = index + 30;
                          });
                        }
                        return false;
                      },
                      child: SizedBox(
                        height: 200,
                        child: ListWheelScrollView.useDelegate(
                          controller: _controller,
                          itemExtent: 60,
                          physics: const FixedExtentScrollPhysics(),
                          perspective: 0.002,
                          diameterRatio: 1.8,
                          onSelectedItemChanged: (index) {
                            setState(() {
                              selectedWeight = index + 30;
                            });
                          },
                          childDelegate: ListWheelChildBuilderDelegate(
                            builder: (context, index) {
                              if (index < 0) return null;
                              final weight = index + 30;
                              final isSelected = weight == selectedWeight;

                              return Center(
                                child: AnimatedContainer(
                                  duration: const Duration(milliseconds: 200),
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 20,
                                  ),
                                  decoration: BoxDecoration(
                                    color: isSelected
                                        ? TColor.primaryColor2
                                        : Colors.transparent,
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                  child: Text(
                                    "$weight",
                                    style: GoogleFonts.notoSans(
                                      color: isSelected
                                          ? Colors.white
                                          : Colors.white70,
                                      fontSize: isSelected ? 32 : 24,
                                      fontWeight: isSelected
                                          ? FontWeight.bold
                                          : FontWeight.normal,
                                    ),
                                  ),
                                ),
                              );
                            },
                            childCount: 121,
                          ),
                        ),
                      ),
                    ),

                    Positioned(
                      right: 80,
                      top: 200,
                      child: Text(
                        "kg",
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
                "$selectedWeight kg",
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
