//package
import 'package:flutter/material.dart';
//lib
import '../../utils/colors.dart';

class ListTapBar extends StatefulWidget {
  const ListTapBar({super.key});

  @override
  State<ListTapBar> createState() => _ListTapBarState();
}

class _ListTapBarState extends State<ListTapBar> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.view_list),
          label: '전체보기',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.favorite_outline),
          activeIcon: Icon(Icons.favorite, color: themeColors[3]),
          label: '관심목록',
        ),
      ],
      currentIndex: _selectedIndex, // active tab index
      selectedItemColor: themeColors[3], // active item color
      onTap: _onItemTapped, // function to handle item tap
    );
  }
}
