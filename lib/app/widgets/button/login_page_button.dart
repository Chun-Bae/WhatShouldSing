//package
import 'package:flutter/material.dart';
//lib
import '../../utils/colors.dart';

class LoginPageButton extends StatelessWidget {
  final String name;
  final VoidCallback? onPressed;
  const LoginPageButton(
      {super.key, required String this.name, required VoidCallback? this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: EdgeInsets.only(right: 4),
        child: ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(3),
            ),
            primary: themeColors[3],
            onPrimary: Colors.white,
            minimumSize: Size(double.infinity, 45), // 여기서 50은 버튼의 높이
          ),
          child: Text(name),
        ),
      ),
    );
  }
}
