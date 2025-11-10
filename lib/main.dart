// main.dart
import 'package:fitness/view/on_boarding/started_view.dart';
import 'package:flutter/material.dart';
import 'package:fitness/common/colo_extention.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fitness',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: TColor.primaryColor2,
        scaffoldBackgroundColor: TColor.whiteColor,
        fontFamily: "Poppins",
      ),
      home: const StartedView(),
    );
  }
}
