import 'package:fitness/view/on_boarding/on_boarding_flow.dart'; // ← ШИНЭ
import 'package:flutter/material.dart';
import 'package:fitness/common/colo_extention.dart';
import 'package:fitness/common_widget/on_boarding_page.dart';

class OnBoardingView extends StatefulWidget {
  const OnBoardingView({super.key});

  @override
  State<OnBoardingView> createState() => _OnBoardingViewState();
}

class _OnBoardingViewState extends State<OnBoardingView> {
  final PageController controller = PageController();

  final List<Map<String, String>> pageArr = [
    {
      "title": "Шаргуу хөдөлмөр",
      "subtitle": "Шилдэг үр дүнгийн үндэс бол тэвчээр.",
      "image": "assets/img/p2.jpg",
    },
    {
      "title": "Эрүүл, эрч хүчтэй бай",
      "subtitle": "Өдөр бүрийн жижиг ахиц том ялалт руу хөтөлнө!",
      "image": "assets/img/p3.jpg",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: TColor.whiteColor,
      body: PageView.builder(
        controller: controller,
        itemCount: pageArr.length,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          return OnBoardingPage(
            p0bj: pageArr[index],
            controller: controller,
            index: index,
            total: pageArr.length,
            onLastPage: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (_) => const OnBoardingFlow()),
              );
            },
          );
        },
      ),
    );
  }
}
