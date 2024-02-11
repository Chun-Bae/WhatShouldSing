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
      type: BottomNavigationBarType.fixed,
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
        BottomNavigationBarItem(
          icon: Icon(Icons.search_rounded),
          label: '노래 번호 검색',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.map_rounded),
          label: '근처 노래방',
        ),
      ],
      currentIndex: _selectedIndex, // active tab index
      selectedItemColor: themeColors[3], // active item color
      onTap: _onItemTapped, // function to handle item tap
    );
  }
}
