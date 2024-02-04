import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

import '../utils/colors.dart';

import '../screens/main_page.dart';
import '../models/song_info.dart';
import '../providers/state_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

final FirebaseFirestore db = FirebaseFirestore.instance;

User? currentUser = FirebaseAuth.instance.currentUser;
// 상위 컬렉션과 문서 ID를 지정
final String parentCollectionPath = 'users';

final String userId =
    FirebaseAuth.instance.currentUser?.uid ?? ""; // 현재 사용자의 UID

// 서브컬렉션과 새 문서를 추가, 'songs'라는 서브컬렉션에 노래 정보를 추가
final CollectionReference subCollection =
    db.collection(parentCollectionPath).doc(userId).collection('songs');

class LoadingPage extends StatefulWidget {
  @override
  _LoadingPageState createState() => _LoadingPageState();
}

class _LoadingPageState extends State<LoadingPage> {
  @override
  void initState() {
    super.initState();
    _loadSongs();
    _navigateToLogin();
  }

  Future<List<SongInfo>> fetchSongs() async {
    List<SongInfo> songs = [];
    try {
      QuerySnapshot querySnapshot = await subCollection.get();

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

  FirebaseFirestore db = FirebaseFirestore.instance;

  void _loadSongs() async {
    List<SongInfo> loadedSongs = await fetchSongs();
    Provider.of<SongsState>(context, listen: false).setSongsList(loadedSongs);
  }

  _navigateToLogin() async {
    await Future.delayed(Duration(seconds: 1), () {});
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => KaraokeListScreen(),
        ));
  }

  // shared_preferences용
  Future<List<SongInfo>> loadSongs() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    // 'songs' 키로 저장된 JSON 문자열 리스트를 로드
    List<String>? jsonSongs = prefs.getStringList('songs');
    // JSON 문자열 리스트를 SongInfo 객체 리스트로 변환
    return jsonSongs
            ?.map((jsonSong) => SongInfo.fromJson(json.decode(jsonSong)))
            .toList() ??
        [];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: themeColors[2],
      body: Center(
        child: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            RichText(
              text: TextSpan(
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
                children: <TextSpan>[
                  TextSpan(
                    text: '뭐부',
                    style: TextStyle(
                      fontSize: 36,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  TextSpan(text: '르지'),
                ],
              ),
            ),
            Transform.translate(
              offset: Offset(-16, -30), // x축은 0, y축을 -10으로 이동
              child: Image.asset(
                'assets/images/mike.png', // <a href="https://www.flaticon.com/kr/free-icons/" title="노래방 아이콘">노래방 아이콘  제작자: Iconjam - Flaticon</a>
                width: 37,
                height: 37,
              ),
            )
          ],
        ),
      ),
    );
  }
}
