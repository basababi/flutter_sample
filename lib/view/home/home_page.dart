import 'package:flutter/material.dart';
import 'home.dart';
import 'gym.dart';
import 'profile.dart';
import 'food.dart';
import 'package:fitness/common/colo_extention.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;

  // One navigator key per tab so each tab keeps its own navigation stack.
  final List<GlobalKey<NavigatorState>> _navigatorKeys = List.generate(
    4,
    (_) => GlobalKey<NavigatorState>(),
  );

  // Build the nested Navigator for a given index
  Widget _buildTabNavigator(int index) {
    return Navigator(
      key: _navigatorKeys[index],
      onGenerateRoute: (RouteSettings settings) {
        late Widget page;
        switch (index) {
          case 0:
            page = const HomeTab();
            break;
          case 1:
            page = const GymTab();
            break;
          case 2:
            page = const FoodTab();
            break;
          case 3:
            page = const ProfileTab();
            break;
          default:
            page = const HomeTab();
        }
        return MaterialPageRoute(builder: (_) => page, settings: settings);
      },
    );
  }

  void _selectTab(int index) {
    if (index == _currentIndex) {
      // If the user reselects the current tab, pop to first route
      _navigatorKeys[index].currentState?.popUntil((route) => route.isFirst);
    } else {
      setState(() => _currentIndex = index);
    }
  }

  Future<bool> _onWillPop() async {
    final NavigatorState currentNavigator =
        _navigatorKeys[_currentIndex].currentState!;
    if (currentNavigator.canPop()) {
      currentNavigator.pop();
      return false; // handled the pop
    }
    // If on a non-home tab and no more pages to pop, go to home tab first
    if (_currentIndex != 0) {
      setState(() => _currentIndex = 0);
      return false;
    }
    // Let system handle the back (exit app)
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        // Use IndexedStack to preserve each tab's state
        body: IndexedStack(
          index: _currentIndex,
          children: List.generate(4, (i) => _buildTabNavigator(i)),
        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _currentIndex,
          type: BottomNavigationBarType.fixed,
          backgroundColor: const Color(0xFF212329),
          selectedItemColor: TColor.primaryColor2,
          unselectedItemColor: Colors.white54,
          selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold),
          onTap: _selectTab,
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
      ),
    );
  }
}
