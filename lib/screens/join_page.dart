import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../screens/login_page.dart';
import '../utils/colors.dart';

final FirebaseAuth _auth =FirebaseAuth.instance;
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
  bool _isEmailValid = true; // 이메일 유효성 상태
  bool _isChecking = false; // 중복확인 중인지 상태

  Future<void> _submitForm() async {
    if (_formKey.currentState!.validate()) {
      // 모든 TextFormField의 검증이 성공했을 때 실행될 로직
      // 예: 로그인 요청, 데이터베이스 업데이트 등
      try {
        
        UserCredential userCredential =
            await FirebaseAuth.instance.createUserWithEmailAndPassword(
                email: _emailController.text,
                password: _passwordController.text);

        user = userCredential.user!;        
        if(user != null && !user!.emailVerified){
          await user!.sendEmailVerification();
        }

        // 사용자 등록 성공 처리
      } catch (e) {
        // 에러 처리
      }
    }
  }

  // 이메일 형식 검사 함수
  bool _validateEmailFormat(String email) {
    String pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regExp = new RegExp(pattern);
    return regExp.hasMatch(email);
  }

  Future<void> _checkEmail() async {
    // 이메일 형식 검사
    if (!_validateEmailFormat(_emailController.text)) {
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

  String? _validateEmail(String? value) {
    final emailPattern = RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
    if (value == null || value.isEmpty || !emailPattern.hasMatch(value)) {
      return '알맞은 형식의 이메일 주소를 입력해주세요.';
    }
    return null; // null을 반환하면 에러가 없음을 의미합니다.
  }

  void _navigateToLogin(BuildContext context) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => LoginPage()),
    );
  }

  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return '비밀번호를 입력해주세요.';
    } else if (value.length < 8 && value.length < 16) {
      return '비밀번호는 8자 이상 15자 이내 이어야 합니다.';
    }
    // 여기에 추가적인 유효성 검사 로직을 구현할 수 있습니다.
    return null;
  }

  String? _validateConfirmPassword(String? value) {
    if (_passwordController.text != value) {
      return '비밀번호가 일치하지 않습니다.';
    }
    return null;
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
                    child: _buildTextField(
                      label: '이메일 입력',
                      obscureText: false,
                      controller: _emailController,
                      validator: _validateEmail,
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
                child: _buildTextField(
                  label: '닉네임 입력',
                  obscureText: false,
                ),
              ),
              SizedBox(height: 20),
              Container(
                width: double.infinity, // 또는 특정 너비
                child: _buildTextField(
                  label: '비밀번호 입력',
                  obscureText: true,
                  controller: _passwordController,
                  validator: _validatePassword,
                ),
              ),
              SizedBox(height: 20),
              Container(
                width: double.infinity, // 또는 특정 너비
                child: _buildTextField(
                  label: '비밀번호 재확인',
                  obscureText: true,
                  controller: _confirmPasswordController,
                  validator: _validateConfirmPassword,
                ),
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  _buildLoginFunctionButton(
                    name: "가입하기",
                    onPressed: () => _submitForm(),
                  ),
                  _buildLoginFunctionButton(
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

  Widget _buildTextField({
    required String label,
    required bool obscureText,
    TextEditingController? controller,
    String? Function(String?)? validator,
    String? errorText,
  }) {
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
    );
  }
}
