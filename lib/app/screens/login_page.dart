//package
import 'package:flutter/material.dart';

//lib
import 'list_page.dart';
import '../utils/colors.dart';
import '../screens/join_page.dart';
import '../screens/loading_page.dart';
import '../widgets/textfield/title_wss.dart';
import '../widgets/textfield/login_page_textfield.dart';
import '../widgets/logo/mike_logo.dart';
import '../widgets/button/login_page_button.dart';
import '../widgets/views/naver_map_widget.dart';
import '../../services/auth_service.dart';

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
      // 로그인 요청
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
      MaterialPageRoute(builder: (context) => NaverMapPage()),
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
                child: LoginPageTextfield(
                  label: '이메일',
                  obscureText: false,
                  controller: _emailController,
                ),
              ),
              SizedBox(height: 20),
              Container(
                width: double.infinity, // 또는 특정 너비
                child: LoginPageTextfield(
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
                      LoginPageButton(
                        name: "로그인",
                        onPressed: () => _submitForm(context),
                      ),
                      LoginPageButton(
                        name: "회원 가입",
                        onPressed: () => _navigateToJoin(context),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      LoginPageButton(
                        name: "아이디 찾기",
                        onPressed: () => _navigateToFind_ID(context),
                      ),
                      LoginPageButton(
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
}
