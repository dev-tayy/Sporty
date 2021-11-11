import 'package:flutter/material.dart';
import 'package:sporty/providers/app_provider.dart';
import 'package:provider/provider.dart';
import 'package:sporty/screens/buddies_screen.dart';
import 'package:sporty/screens/discover_screen.dart';
import 'package:sporty/screens/profile_screen.dart';
import 'package:sporty/screens/settings_screen.dart';

class HomeScreen extends StatelessWidget {
  static String id = "home_screen";
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<AppProvider>(
      builder: (context, model, child) => Scaffold(
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: const Color(0xFF121212),
          //fixedColor: const Color(0xFF121212),
          showSelectedLabels: true,
          showUnselectedLabels: false,

          unselectedItemColor: Colors.white,
          selectedItemColor: Colors.orange,
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.account_box),
              label: 'Profile',
              backgroundColor: const Color(0xFF121212),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.people),
              label: 'Buddies',
              backgroundColor: const Color(0xFF121212),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.search),
              label: 'Discover',
              backgroundColor: const Color(0xFF121212),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.settings),
              backgroundColor: const Color(0xFF121212),
              label: 'Settings',
            ),
          ],
          onTap: model.toggle,
          currentIndex: model.currentIndex,
        ),
        body: IndexedStack(
          children: [
            ProfileScreen(),
            BuddiesScreen(),
            DiscoverScreen(),
            SettingsScreen()
          ],
          index: model.currentIndex,
        ),
      ),
    );
  }
}
