import 'package:flutter/material.dart';
import 'package:flutter_naver_map/flutter_naver_map.dart';

class NaverMapPage extends StatelessWidget {
  const NaverMapPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: NaverMap(
          options: const NaverMapViewOptions(),
          onMapReady: (controller) {
            print("네이버 맵 로딩됨!");
          },
        ),
      ),
    );
  }
}
