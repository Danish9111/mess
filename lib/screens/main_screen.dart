import 'package:flutter/material.dart';
import 'package:mess/screens/profile_screen/admin_profile/admin_profile.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';
import 'dashboard_screen/dashboard_ui/dashboard_screen.dart';
import 'expense_screen.dart';
import 'package:mess/screens/meal_screen/main_meal.dart' as MealScreens;

class MainScreen extends StatelessWidget {
  final PersistentTabController navBarController =
      PersistentTabController(initialIndex: 0);
  final List<Widget> _screens = [
    const DashboardScreen(),
    const MealScreens.MealScreen(),
    const ExpensesScreen(),
    const AdminPanelScreen(),
  ];
  final List<PersistentBottomNavBarItem> _items = [
    PersistentBottomNavBarItem(
      icon: const Icon(Icons.home_rounded),
      title: 'Home',
      activeColorPrimary: Colors.lightBlueAccent,
      inactiveColorPrimary: Colors.grey,
    ),
    PersistentBottomNavBarItem(
      icon: const Icon(Icons.fastfood),
      title: 'Meal',
      activeColorPrimary: Colors.lightBlueAccent,
      inactiveColorPrimary: Colors.grey,
    ),
    PersistentBottomNavBarItem(
      icon: const Icon(Icons.monetization_on),
      title: 'Expense',
      activeColorPrimary: Colors.lightBlueAccent,
      inactiveColorPrimary: Colors.grey,
    ),
    PersistentBottomNavBarItem(
      icon: const Icon(Icons.person),
      title: 'Profile',
      activeColorPrimary: Colors.lightBlueAccent,
      inactiveColorPrimary: Colors.grey,
    ),
  ];

  MainScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return PersistentTabView(
      padding: const EdgeInsets.only(top: 20),
      context,
      navBarHeight: 70,
      controller: navBarController,
      screens: _screens,
      items: _items,
      navBarStyle: NavBarStyle.style8,
    );
  }
}
