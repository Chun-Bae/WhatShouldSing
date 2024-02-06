//package
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;

Future<void> signInWithEmailAndPassword(
    {required String email,
    required String pw,
    VoidCallback? navigateToLoading}) async {
  try {
    await _auth.signInWithEmailAndPassword(email: email, password: pw);
    navigateToLoading!();
  } on FirebaseAuthException catch (e) {
    if (e.code == 'user-not-found') {
      print('No user found for that email.');
    } else if (e.code == 'wrong-password') {
      print('Wrong password provided for that user.');
    } else if (e.code == "too-many-requests") {
      print('요청 수가 최대 허용치를 초과합니다.');
    } else {
      print(e);
    }
  }
}
