//package
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
//lib
import '../screens/login_page.dart';
import '../utils/colors.dart';
import '../utils/validator.dart';
import '../widgets/textfield/join_page_textfield.dart';
import '../widgets/button/join_page_button.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;
User? user;

class JoinPage extends StatefulWidget {
  @override
  _JoinPageState createState() => _JoinPageState();
}

class _JoinPageState extends State<JoinPage> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  String? _emailError; // 이메일 에러 메시지
  String? _confirmPasswordError;
  bool _isEmailValid = true; // 이메일 유효성 상태
  bool _isChecking = false; // 중복확인 중인지 상태

  Future<void> _submitForm() async {
    if (_formKey.currentState!.validate() && _confirmPasswordError == null) {
      // 모든 TextFormField의 검증이 성공했을 때 실행될 로직
      // 예: 로그인 요청, 데이터베이스 업데이트 등
      try {
        UserCredential userCredential = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(
                email: _emailController.text,
                password: _passwordController.text);

        user = userCredential.user!;
        if (user != null && !user!.emailVerified) {
          await user!.sendEmailVerification();
        }
      } catch (e) {
        
        print("회원가입 양식 제출 에러: $e");
      }
    }
    else{
      print("회원가입 양식이 틀렸습니다.");
    }
  }

  Future<void> _checkEmail() async {
    // 이메일 형식 검사
    if (!validateEmailFormat(_emailController.text)) {
      setState(() {
        _emailError = '유효하지 않은 이메일 형식입니다.';
      });
      return;
    }

    setState(() {
      _isChecking = true; // 중복확인 시작
      _emailError = null; // 에러 메시지 초기화
    });

    // 중복확인 로직 구현, 예를 들어 서버로 이메일 중복 확인 요청
    await Future.delayed(Duration(seconds: 1)); // 가정: 1초 후에 응답이 온다고 가정

    // 서버 응답에 따라 상태 업데이트
    setState(() {
      _isEmailValid = false; // 서버로부터 중복이라는 응답을 받았다고 가정
      _isChecking = false; // 중복확인 종료
    });
  }

  void _navigateToLogin(BuildContext context) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => LoginPage()),
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
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
              Row(
                children: <Widget>[
                  Expanded(
                    child: JoinPageTextfield(
                      label: '이메일 입력',
                      obscureText: false,
                      controller: _emailController,
                      validator: validateEmail,
                      errorText: _emailError,
                    ),
                  ),
                  SizedBox(width: 8),
                  _isChecking
                      ? CircularProgressIndicator() // 중복확인 중 로딩 표시
                      : ElevatedButton(
                          onPressed: _checkEmail,
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(3),
                            ),
                            primary: themeColors[3],
                            onPrimary: Colors.white,
                            minimumSize: Size(110, 50), // 버튼의 고정 크기
                          ),
                          child: _isChecking
                              ? CircularProgressIndicator()
                              : Text('중복확인'),
                        ),
                ],
              ),
              SizedBox(height: 20),
              Container(
                width: double.infinity, // 또는 특정 너비
                child: JoinPageTextfield(
                  label: '닉네임 입력',
                  obscureText: false,
                ),
              ),
              SizedBox(height: 20),
              Container(
                width: double.infinity, // 또는 특정 너비
                child: JoinPageTextfield(
                  label: '비밀번호 입력',
                  obscureText: true,
                  controller: _passwordController,
                  validator: validateLengthPassword,
                ),
              ),
              SizedBox(height: 20),
              Container(
                width: double.infinity, // 또는 특정 너비
                child: JoinPageTextfield(
                  label: '비밀번호 재확인',
                  obscureText: true,
                  controller: _confirmPasswordController,
                  errorText: _confirmPasswordError,
                  onChanged: (text) {
                    if (text != _passwordController.text) {
                      setState(() {
                        _confirmPasswordError = '비밀번호가 일치하지 않습니다.';
                      });
                    } else {
                      setState(() {
                        _confirmPasswordError = null;
                      });
                    }
                  },
                ),
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  JoinPageButton(
                    name: "가입하기",
                    onPressed: () => _submitForm(),
                  ),
                  JoinPageButton(
                    name: "가입취소",
                    onPressed: () => _navigateToLogin(context),
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
