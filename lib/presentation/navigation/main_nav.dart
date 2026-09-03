import 'package:flutter/material.dart';
import '../../core/utils/app_strings.dart';
import '../screens/dashboard/dashboard_screen.dart';
import '../screens/students/students_screen.dart';
import '../screens/classes/classes_screen.dart';
import '../screens/transactions/transactions_screen.dart';
import '../screens/settings/settings_screen.dart';

/// Simple global key based navigation helper to jump tabs from anywhere.
class MainNav extends StatefulWidget {
  const MainNav({super.key});

  static final GlobalKey<MainNavState> navKey = GlobalKey<MainNavState>();

  static void switchTab(BuildContext context, int index) {
    navKey.currentState?.setTab(index);
  }

  @override
  State<MainNav> createState() => MainNavState();
}

class MainNavState extends State<MainNav> {
  int _index = 0;

  final _screens = const [
    DashboardScreen(),
    StudentsScreen(),
    ClassesScreen(),
    TransactionsScreen(),
    SettingsScreen(),
  ];

  void setTab(int i) => setState(() => _index = i);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(index: _index, children: _screens),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _index,
        onTap: setTab,
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
            icon: const Icon(Icons.dashboard_rounded),
            label: AppStrings.t(context, 'dashboard'),
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.people_alt_rounded),
            label: AppStrings.t(context, 'students'),
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.school_rounded),
            label: AppStrings.t(context, 'classes_nav'),
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.swap_vert_rounded),
            label: AppStrings.t(context, 'transactions'),
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.settings_rounded),
            label: AppStrings.t(context, 'settings'),
          ),
        ],
      ),
    );
  }
}
