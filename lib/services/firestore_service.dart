//package
import 'package:cloud_firestore/cloud_firestore.dart';
//lib
import '../models/song_info.dart';
import 'auth_service.dart';

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
    print("fetch 예외: ");
    print(e);
  }
  return songs;
}