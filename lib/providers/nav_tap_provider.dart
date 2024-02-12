//package
import 'package:flutter/material.dart';
//lib
import '../app/screens/list_page.dart';
import '../app/screens/favorite_page.dart';

class NavTapState with ChangeNotifier {
  int selectedIndex = 0;
  final List<Widget> navIndex = [
    ListPage(),
    FavoritePage(),
    Scaffold(body: Text("3"),),
    Scaffold(body: Text("4"),),
  ];

  void onNavTapped(int index) {
    this.selectedIndex = index;
    notifyListeners();
  }

}
