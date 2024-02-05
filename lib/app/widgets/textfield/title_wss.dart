import 'package:flutter/material.dart';

class TitleWSS extends StatelessWidget {
  const TitleWSS({super.key});

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        style: TextStyle(
          fontSize: 24.0,
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
        children: <TextSpan>[
          TextSpan(
            text: '뭐부',
            style: TextStyle(
              fontSize: 36,
              fontWeight: FontWeight.bold,
            ),
          ),
          TextSpan(text: '르지'),
        ],
      ),
    );
  }
}
