import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '/../screens/loading_page.dart';

import '../providers/state_provider.dart';
import '../providers/theme_provider.dart';


void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => UIState()),
        ChangeNotifierProvider(create: (context) => SongsState()),
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
      home: LoadingPage(),
    );
  }
}
