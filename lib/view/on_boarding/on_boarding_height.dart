import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:fitness/common/colo_extention.dart';

class HeightSelectionView extends StatefulWidget {
  const HeightSelectionView({super.key});

  @override
  State<HeightSelectionView> createState() => _HeightSelectionViewState();
}

class _HeightSelectionViewState extends State<HeightSelectionView> {
  int height = 175;

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
                "Та өөрийн өндрийг оруулна уу",
                textAlign: TextAlign.center,
                style: GoogleFonts.notoSans(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 40),

              Expanded(
                child: Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        "$height",
                        style: GoogleFonts.notoSans(
                          color: TColor.primaryColor2,
                          fontSize: 72,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        "cm",
                        style: GoogleFonts.notoSans(
                          color: Colors.white70,
                          fontSize: 18,
                        ),
                      ),
                      const SizedBox(height: 30),
                      SliderTheme(
                        data: SliderThemeData(
                          thumbShape: const RoundSliderThumbShape(
                            enabledThumbRadius: 16,
                          ),
                          overlayShape: const RoundSliderOverlayShape(
                            overlayRadius: 32,
                          ),
                          activeTrackColor: TColor.primaryColor2,
                          inactiveTrackColor: Colors.grey[700],
                          thumbColor: TColor.primaryColor1,
                        ),
                        child: Slider(
                          min: 120,
                          max: 220,
                          value: height.toDouble(),
                          onChanged: (val) =>
                              setState(() => height = val.round()),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
