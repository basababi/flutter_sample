import 'package:fitness/view/on_boarding/on_boarding_view.dart'; // ← ЗӨВ
import 'package:flutter/material.dart';
import 'package:fitness/common/colo_extention.dart';
import 'package:fitness/common_widget/round_buttom.dart';
import 'dart:math' as math;

class StartedView extends StatelessWidget {
  const StartedView({super.key});

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;

    return Scaffold(
      body: Container(
        width: media.width,
        height: media.height,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: TColor.primaryGradientColors,
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Positioned(
              top: media.height * 0.18,
              child: Transform.rotate(
                angle: math.pi / 4,
                child: Image.asset(
                  "assets/img/p3.png",
                  width: media.width * 0.45,
                  fit: BoxFit.contain,
                ),
              ),
            ),

            Positioned(
              bottom: 60,
              left: 20,
              right: 20,
              child: RoundButtom(
                title: "Дараах",
                type: RoundButtomType.bgGradient,
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const OnBoardingView()),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
