//package
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_naver_map/flutter_naver_map.dart';
//lib
import 'firebase_options.dart';
import 'app/screens/login_page.dart';
import '../providers/state_provider.dart';
import '../providers/theme_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try {
    await NaverMapSdk.instance.initialize(
        clientId: 'x843dugd4b',
        onAuthFailed: (error) {
          print('Auth failed: $error');
        });
  } catch (e) {
    print("********* 네이버맵 인증오류 : $e *********");
  }
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
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
      home: LoginPage(),
    );
  }
}
