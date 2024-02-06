//package
import 'package:flutter/material.dart';

//lib
import 'list_page.dart';
import '../screens/join_page.dart';
import '../screens/loading_page.dart';
import '../utils/colors.dart';
import '../../services/auth_service.dart';
import '../widgets/textfield/title_wss.dart';
import '../widgets/logo/mike_logo.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  Future<void> _submitForm(BuildContext context) async {
    if (_formKey.currentState!.validate()) {
      // 모든 TextFormField의 검증이 성공했을 때 실행될 로직
      // 예: 로그인 요청, 데이터베이스 업데이트 등

      signInWithEmailAndPassword(
          email: _emailController.text,
          pw: _passwordController.text,
          navigateToLoading: () => _navigateToLoading(context));
    }
  }

  void _navigateToLoading(BuildContext context) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => LoadingPage()),
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
      MaterialPageRoute(builder: (context) => ListPage()),
    );
  }

  void _navigateToFind_PW(BuildContext context) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => ListPage()),
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: themeColors[2],
      body: Form(
        key: _formKey,
        child: Padding(
          padding: EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TitleWSS(),
              MikeLogo(x: -16, y: -75),
              SizedBox(height: 50),
              Container(
                width: double.infinity, // 또는 특정 너비
                child: _buildTextField(
                  label: '이메일',
                  obscureText: false,
                  controller: _emailController,
                ),
              ),
              SizedBox(height: 20),
              Container(
                width: double.infinity, // 또는 특정 너비
                child: _buildTextField(
                  label: '비밀번호',
                  obscureText: true,
                  controller: _passwordController,
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
                        onPressed: () => _submitForm(context),
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

  Widget _buildTextField(
      {required String label,
      required bool obscureText,
      required TextEditingController? controller}) {
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
