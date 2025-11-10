import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:fitness/common/colo_extention.dart';

class GenderSelectionView extends StatefulWidget {
  const GenderSelectionView({super.key});

  @override
  State<GenderSelectionView> createState() => _GenderSelectionViewState();
}

class _GenderSelectionViewState extends State<GenderSelectionView> {
  String? selectedGender;

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
                "Та өөрийн хүйсийг сонгоно уу",
                textAlign: TextAlign.center,
                style: GoogleFonts.notoSans(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 40),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _genderBtn("Male", "assets/img/male.png", "male"),
                  _genderBtn("Female", "assets/img/female.png", "female"),
                ],
              ),
              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _genderBtn(String label, String icon, String value) {
    bool selected = selectedGender == value;
    return GestureDetector(
      onTap: () => setState(() => selectedGender = value),
      child: Column(
        children: [
          Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: selected ? TColor.primaryColor2 : Colors.grey[800],
              border: Border.all(
                color: selected ? TColor.primaryColor1 : Colors.transparent,
                width: 3,
              ),
            ),
            child: Image.asset(
              icon,
              width: 20,
              height: 20,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            label,
            style: GoogleFonts.notoSans(
              color: selected ? TColor.primaryColor2 : Colors.white70,
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }
}
