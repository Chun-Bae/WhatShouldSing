//package
import 'package:flutter/material.dart';
//lib
import '../../utils/colors.dart';

class LoginPageTextfield extends StatelessWidget {
  final String label;
  final bool obscureText;
  final TextEditingController? controller;

  const LoginPageTextfield(
      {super.key,
      required String this.label,
      required bool this.obscureText,
      required TextEditingController? this.controller});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        filled: true,
        fillColor: themeColors[0],
        hintText: label,
        hintStyle: TextStyle(color: Colors.black), // 라벨 텍스트 색상을 흰색으로 설정
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5.0),
          borderSide: BorderSide(
            color: Colors.white,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5.0),
          borderSide: BorderSide(
            color: themeColors[1], // 활성화되었지만 포커스가 없을 때의 테두리 색상
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5.0),
          borderSide: BorderSide(
            color: themeColors[1],
          ),
        ),
      ),
      obscureText: obscureText, // ***표시
    );
  }
}
