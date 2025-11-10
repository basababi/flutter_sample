import 'package:flutter/material.dart';
import 'package:fitness/common/colo_extention.dart';
import 'package:google_fonts/google_fonts.dart';

class OnBoardingPage extends StatelessWidget {
  final Map<String, String> p0bj;
  final PageController controller;
  final int index;
  final int total;
  final VoidCallback? onLastPage;

  const OnBoardingPage({
    super.key,
    required this.p0bj,
    required this.controller,
    required this.index,
    required this.total,
    this.onLastPage,
  });

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;

    return Stack(
      fit: StackFit.expand,
      children: [
        Image.asset(p0bj["image"]!, fit: BoxFit.cover),
        Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            width: media.width,
            height: media.height * 0.28,
            decoration: const BoxDecoration(
              color: Color(0xFF333131),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(35),
                topRight: Radius.circular(35),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 25),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    p0bj["title"]!,
                    textAlign: TextAlign.center,
                    style: GoogleFonts.notoSans(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    p0bj["subtitle"]!,
                    textAlign: TextAlign.center,
                    style: GoogleFonts.notoSans(
                      fontSize: 14,
                      color: Colors.white70,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(total, (i) {
                      return AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        margin: const EdgeInsets.symmetric(horizontal: 4),
                        width: i == index ? 20 : 6,
                        height: 6,
                        decoration: BoxDecoration(
                          color: i == index
                              ? TColor.primaryColor2
                              : Colors.white30,
                          borderRadius: BorderRadius.circular(3),
                        ),
                      );
                    }),
                  ),
                  GestureDetector(
                    onTap: () {
                      if (index < total - 1) {
                        controller.nextPage(
                          duration: const Duration(milliseconds: 500),
                          curve: Curves.easeInOut,
                        );
                      } else {
                        onLastPage?.call();
                      }
                    },
                    child: Container(
                      width: media.width * 0.5,
                      height: 45,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: TColor.primaryGradientColors,
                        ),
                        borderRadius: BorderRadius.circular(25),
                      ),
                      alignment: Alignment.center,
                      child: const Text(
                        "Дараах",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
