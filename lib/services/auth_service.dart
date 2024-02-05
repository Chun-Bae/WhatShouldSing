
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

// firestore 데이터 베이스
final FirebaseFirestore db = FirebaseFirestore.instance; 
// 현재 로그인한 user
User? currentUser = FirebaseAuth.instance.currentUser; 
// users 컬렉션
final String usersCollection = 'users';
// 현재 사용자의 UID
final String userId = FirebaseAuth.instance.currentUser?.uid ?? ""; 
// 현재 user의 songs 컬렉션 정보
final CollectionReference songsCollection = db.collection(usersCollection).doc(userId).collection('songs');