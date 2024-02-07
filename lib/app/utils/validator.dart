// 이메일 형식 검사 함수
bool validateEmailFormat(String email) {
  String pattern =
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
  RegExp regExp = new RegExp(pattern);
  return regExp.hasMatch(email);
}

String? validateEmail(String? value) {
  final emailPattern = RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
  if (value == null || value.isEmpty || !emailPattern.hasMatch(value)) {
    return '알맞은 형식의 이메일 주소를 입력해주세요.';
  }
  return null; // null을 반환하면 에러가 없음을 의미합니다.
}

String? validateLengthPassword(String? value) {
  if (value == null || value.isEmpty) {
    return '비밀번호를 입력해주세요.';
  } else if (value.length < 8 && value.length < 16) {
    return '비밀번호는 8자 이상 15자 이내 이어야 합니다.';
  }
  // 여기에 추가적인 유효성 검사 로직을 구현할 수 있습니다.
  return null;
}


