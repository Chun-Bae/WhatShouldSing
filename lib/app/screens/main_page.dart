//package
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
//lib
import '../widgets/navigation/main_bar_drawer.dart';
import '../widgets/textfield/search_textfield.dart';
import '../widgets/appbar/main_appbar.dart';
import '../widgets/bottombar/list_tap_bar.dart';
import '../../providers/nav_tap_provider.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    final navTapState = Provider.of<NavTapState>(context);
    return Scaffold(
            //AppBar
      appBar: MainAppbar(
        bottom: navTapState.selectedIndex == 0 ? SearchTextfield() : null,
      ),
      drawer: MainAppDrawer(),
      backgroundColor: Colors.white,      
      body: navTapState.navIndex.elementAt(navTapState.selectedIndex),
      bottomNavigationBar: ListTapBar(),
    );
  }
}
