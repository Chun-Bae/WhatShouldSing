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

Future<String?> firebaseAddSong(
    String song, String artist, String songNumber, bool isTJ, bool isKY) async {
// 보안 규칙 추가 필수
// rules_version = '2';

// service cloud.firestore {
//   match /databases/{database}/documents {
//     match /{document=**} {
//       allow read, write: if request.auth != null;
//     }
//   }
// }

  try {
    // Firestore에 사용자 ID를 포함한 노래 정보를 추가하는 문서 생성
    DocumentReference docRef = await songsCollection.add({
      'userId': userId, // 현재 사용자의 UID 추가
      'song': song,
      'artist': artist,
      'songNumber': songNumber,
      'isTJ': isTJ,
      'isKY': isKY,
      'createdAt':
          FieldValue.serverTimestamp(), // Firestore 서버 시간을 기준으로 타임스탬프 생성
    });
    // 생성된 문서의 ID를 가져옴
    String documentId = docRef.id;
    // 동일한 문서에 documentId 필드를 추가하거나 업데이트
    await docRef.update({
      'documentId': documentId,
    });

    print("노래 정보가 성공적으로 추가되었습니다.");
    return documentId;
  } catch (e) {
    print("노래 정보 추가 중 오류 발생: $e");
  }
  return null;
}