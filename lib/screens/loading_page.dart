import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

import '../utils/colors.dart';

import '../screens/login_page.dart';
import '../models/song_info.dart';
import '../providers/state_provider.dart';

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

  void _loadSongs() async {
    List<SongInfo> loadedSongs = await loadSongs();
    Provider.of<SongsState>(context, listen: false).setSongsList(loadedSongs);
  }

  _navigateToLogin() async {
    await Future.delayed(Duration(seconds: 1), () {});
    Navigator.pushReplacement(
        context, MaterialPageRoute(
          builder: (context) => LoginPage(),
          
      )
    );
  }

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
