import 'package:flutter/material.dart';
import '../screens/main_page.dart';
import '../screens/join_page.dart';
import 'package:what_should_sing/utils/colors.dart';

class LoginPage extends StatelessWidget {
  void _navigateToHome(BuildContext context) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => KaraokeListScreen()),
    );
  }
  void _navigateToJoin(BuildContext context) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => JoinPage()),
    );
  }
    void _navigateToFind_ID(BuildContext context) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => KaraokeListScreen()),
    );
  }
      void _navigateToFind_PW(BuildContext context) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => KaraokeListScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: themeColors[2],
      body: Padding(
        padding: EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            RichText(
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
            ),
            Transform.translate(
              offset: Offset(-16, -75), // x축은 16, y축을 75으로 이동
              child: Image.asset(
                'assets/images/mike.png', // <a href="https://www.flaticon.com/kr/free-icons/" title="노래방 아이콘">노래방 아이콘  제작자: Iconjam - Flaticon</a>
                width: 37,
                height: 37,
              ),
            ),
            SizedBox(height: 50),
            Container(
              width: double.infinity, // 또는 특정 너비
              child: _buildTextField(
                label: '이메일',
                obscureText: false,
              ),
            ),
            SizedBox(height: 20),
            Container(
              width: double.infinity, // 또는 특정 너비
              child: _buildTextField(
                label: '비밀번호',
                obscureText: true,
              ),
            ),
            SizedBox(height: 20),
            Column(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    _buildLoginFunctionButton(
                      name: "로그인",
                      onPressed: () => _navigateToHome(context),
                    ),
                    _buildLoginFunctionButton(
                      name: "회원 가입",
                      onPressed: () => _navigateToJoin(context),
                    ),
                  ],
                ),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    _buildLoginFunctionButton(
                      name: "아이디 찾기",
                      onPressed: () => {},
                    ),
                    _buildLoginFunctionButton(
                      name: "비밀번호 찾기",
                      onPressed: () => {},
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
        
      ),
    );
  }

  Widget _buildLoginFunctionButton(
      {required String name, VoidCallback? onPressed}) {
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

  Widget _buildTextField({required String label, required bool obscureText}) {
    return TextField(
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
