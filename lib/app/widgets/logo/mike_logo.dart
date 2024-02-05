import 'package:flutter/material.dart';

class MikeLogo extends StatelessWidget {
  final double x;
  final double y;
  
  const MikeLogo({
    super.key,
    required this.x,
    required this.y,
  });
  
  @override
  Widget build(BuildContext context) {
    return Transform.translate(
      offset: Offset(x, y), // x축은 0, y축을 -10으로 이동
      child: Image.asset(
        'assets/images/mike.png', // <a href="https://www.flaticon.com/kr/free-icons/" title="노래방 아이콘">노래방 아이콘  제작자: Iconjam - Flaticon</a>
        width: 37,
        height: 37,
      ),
    );
  }
}
