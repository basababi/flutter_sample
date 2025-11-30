import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'home.dart';
import 'gym.dart';
import 'profile.dart';
import 'food.dart';
import 'package:fitness/common/colo_extention.dart';

class HomePage extends StatefulWidget {
  final String name;
  final String email;

  const HomePage({super.key, required this.name, required this.email});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;
  late List<Widget> _pages;

  @override
  void initState() {
    super.initState();
    _pages = [
      const HomeTab(),
      const GymTab(),
      const FoodTab(),
      ProfileTab(name: widget.name, email: widget.email),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex],
      // lib/view/home/home_page.dart (зөвхөн өнгө засагдсан)
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        type: BottomNavigationBarType.fixed,
        backgroundColor: const Color(0xFF212329),
        selectedItemColor: TColor.primaryColor2,
        unselectedItemColor: Colors.white54,
        selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold),
        onTap: (index) => setState(() => _currentIndex = index),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            label: "Нvvр",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.fitness_center),
            label: "Дасгал",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.restaurant_menu),
            label: "Хоол",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            label: "Профайл",
          ),
        ],
      ),
    );
  }
}
