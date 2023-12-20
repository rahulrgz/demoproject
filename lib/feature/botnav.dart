import 'package:demoproject/core/global_variable/global_variable.dart';
import 'package:demoproject/core/theme/pallette.dart';
import 'package:demoproject/feature/homepage.dart';
import 'package:dot_navigation_bar/dot_navigation_bar.dart';
import 'package:flutter/material.dart';

class BottomNav extends StatefulWidget {
  const BottomNav({super.key});

  @override
  State<BottomNav> createState() => _BottomNavState();
}

class _BottomNavState extends State<BottomNav> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  final List<Widget> widgetOptions = <Widget>[
    HomeScreen(),
    Text("Likes Page"),
    Text("Search Page"),
    Text("Profile Page"),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Palette.bgColor,
      extendBody: false,
      body: widgetOptions[_selectedIndex],
      bottomNavigationBar: DotNavigationBar(
        marginR: EdgeInsets.only(left: w * 0.05, right: w * 0.05),
        borderRadius: w * 0.05,
        backgroundColor: Palette.primaryColor,
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.grey[400],
        onTap: _onItemTapped,
        items: [
          DotNavigationBarItem(
            icon: Icon(
              Icons.view_list_sharp,
              size: w * 0.05,
            ),
          ),
          DotNavigationBarItem(
            icon: Icon(
              Icons.description,
              size: w * 0.05,
            ),
          ),
          DotNavigationBarItem(
            icon: Icon(
              Icons.group_sharp,
              size: w * 0.05,
            ),
          ),
          DotNavigationBarItem(
            icon: Icon(
              Icons.edit_note_sharp,
              size: w * 0.05,
            ),
          ),
        ],
      ),
    );
  }
}
