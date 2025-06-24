import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';
import 'screens/dashboard_screen.dart';
import 'screens/mealScreen.dart';
import 'screens/expense_screen.dart';
import 'screens/profile_screen.dart';

class MainScreen extends StatelessWidget {
  final PersistentTabController navBarController =
      PersistentTabController(initialIndex: 0);
  final List<Widget> _screens = [
    DashboardScreen(),
    MealScreen(),
    ExpenseScreen(),
    ProfileScreen(),
  ];
  final List<PersistentBottomNavBarItem> _items = [
    PersistentBottomNavBarItem(
      icon: Icon(Icons.home_rounded),
      title: 'Home',
      activeColorPrimary: Colors.lightBlueAccent,
      inactiveColorPrimary: Colors.grey,
    ),
    PersistentBottomNavBarItem(
      icon: Icon(Icons.fastfood),
      title: 'Meal',
      activeColorPrimary: Colors.lightBlueAccent,
      inactiveColorPrimary: Colors.grey,
    ),
    PersistentBottomNavBarItem(
      icon: Icon(Icons.monetization_on),
      title: 'Expense',
      activeColorPrimary: Colors.lightBlueAccent,
      inactiveColorPrimary: Colors.grey,
    ),
    PersistentBottomNavBarItem(
      icon: Icon(Icons.person),
      title: 'Profile',
      activeColorPrimary: Colors.lightBlueAccent,
      inactiveColorPrimary: Colors.grey,
    ),
  ];
  @override
  Widget build(BuildContext context) {
    return PersistentTabView(
      padding: EdgeInsets.only(top: 20),
      context,
      navBarHeight: 70,
      controller: navBarController,
      screens: _screens,
      items: _items,
      navBarStyle: NavBarStyle.style8,
    );
  }
}
