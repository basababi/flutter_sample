import 'package:fitness/view/on_boarding/on_boarding_gender.dart';
import 'package:fitness/view/on_boarding/on_boarding_age.dart';
import 'package:fitness/view/on_boarding/on_boarding_height.dart';
import 'package:fitness/view/on_boarding/on_boarding_weight.dart';
import 'package:fitness/view/on_boarding/on_boarding_goal.dart';
import 'package:fitness/view/login/signup_view.dart';
import 'package:flutter/material.dart';
import 'package:fitness/common/colo_extention.dart';

class OnBoardingFlow extends StatefulWidget {
  const OnBoardingFlow({super.key});

  @override
  State<OnBoardingFlow> createState() => _OnBoardingFlowState();
}

class _OnBoardingFlowState extends State<OnBoardingFlow> {
  final PageController _controller = PageController();
  int _currentIndex = 0;

  final List<Widget> _pages = const [
    GenderSelectionView(),
    AgeSelectionView(),
    HeightSelectionView(),
    WeightSelectionView(),
    GoalSelectionView(),
    SignUpView(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1E1E1E),
      body: Stack(
        children: [
          PageView(
            controller: _controller,
            physics: const NeverScrollableScrollPhysics(),
            onPageChanged: (i) => setState(() => _currentIndex = i),
            children: _pages,
          ),

          Positioned(
            bottom: 30,
            left: 25,
            right: 25,
            child: Row(
              children: [
                if (_currentIndex > 0) Expanded(child: _backButton()),
                if (_currentIndex > 0) const SizedBox(width: 15),
                Expanded(child: _continueButton()),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _backButton() => GestureDetector(
    onTap: () => _controller.previousPage(
      duration: const Duration(milliseconds: 300),
      curve: Curves.ease,
    ),
    child: Container(
      height: 50,
      decoration: BoxDecoration(
        color: Colors.grey[700],
        borderRadius: BorderRadius.circular(25),
      ),
      child: const Center(
        child: Text(
          "Back",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
        ),
      ),
    ),
  );

  Widget _continueButton() => GestureDetector(
    onTap: () {
      if (_currentIndex < _pages.length - 1) {
        _controller.nextPage(
          duration: const Duration(milliseconds: 300),
          curve: Curves.ease,
        );
      }
    },
    child: Container(
      height: 50,
      decoration: BoxDecoration(
        gradient: LinearGradient(colors: TColor.primaryGradientColors),
        borderRadius: BorderRadius.circular(25),
      ),
      child: const Center(
        child: Text(
          "Continue",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
        ),
      ),
    ),
  );
}
