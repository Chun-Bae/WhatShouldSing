//package
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
//lib
import 'firebase_options.dart';
import 'app/screens/login_page.dart';
import 'app/screens/main_page.dart';
import '../providers/state_provider.dart';
import '../providers/theme_provider.dart';
import '../providers/search_provider.dart';
import '../providers/nav_tap_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => UIState()),
        ChangeNotifierProvider(create: (context) => SongsState()),
        ChangeNotifierProvider(create: (context) => FavoritesState()),
        ChangeNotifierProvider(create: (context) => SearchState()),
        ChangeNotifierProvider(create: (context) => NavTapState()),        
      ],
      child: WhatShouldSing(),
    ),
  );
}

class WhatShouldSing extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '뭐부르지',
      debugShowCheckedModeBanner: false,
      home: MainPage(),
    );
  }
}
