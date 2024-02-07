//import
import 'package:flutter/material.dart';
//lib
import '../../utils/colors.dart';

class JoinPageTextfield extends StatelessWidget {
  String label;
  bool obscureText;
  TextEditingController? controller;
  String? Function(String?)? validator;
  String? errorText;
  void Function(String)? onChanged;

  JoinPageTextfield({
    super.key,
    required String this.label,
    required bool this.obscureText,
    TextEditingController? this.controller,
    String? Function(String?)? this.validator,
    String? this.errorText,
    void Function(String)? this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        filled: true,
        fillColor: themeColors[0],
        hintText: label,
        hintStyle: TextStyle(
            color: const Color.fromARGB(255, 70, 70, 70)), // 라벨 텍스트 색상을 흰색으로 설정
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

        //// Email 전용
        errorText: errorText,
      ),
      obscureText: obscureText, // ***표시
      validator: validator,
      onChanged: onChanged,
    );
  }
}
