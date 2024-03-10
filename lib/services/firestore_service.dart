//package
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

//lib
import '../models/song_info.dart';

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
final CollectionReference favoritesCollection = db.collection(usersCollection).doc(userId).collection('favorites');

Future<List<String>> fetchFavorites() async {
  List<String> favorites = [];
  
  try {    
    QuerySnapshot querySnapshot = await favoritesCollection.get();

    for (var doc in querySnapshot.docs) {
      String favoriteName = doc.id; 
      favorites.add(favoriteName);
      print("문서이름: $favoriteName");
    }
    print("즐겨찾기 목록을 가져왔습니다.");
  } catch (e) {
    print("fetchFavorites 예외: $e");
  }
  return favorites; 
}


Future<List<SongInfo>> fetchSongs() async {
  List<SongInfo> songs = [];
  
  try {
    QuerySnapshot querySnapshot = await songsCollection.get();

    for (var doc in querySnapshot.docs) {
      Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
      SongInfo songInfo = SongInfo.fromFirestore(data);
      songs.add(songInfo);
    }
    print("노래를 가져왔습니다.");
  } catch (e) {
    print("fetchSongs 예외: ");
    print(e);
  }
  return songs;
}