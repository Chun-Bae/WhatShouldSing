import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:provider/provider.dart';
import 'package:what_should_sing/widgets/button/main_add_button.dart';
import 'dart:convert';

import '../models/song_info.dart';

import '../providers/state_provider.dart';
import '../providers/theme_provider.dart';

import 'widgets/appbar/main_appbar.dart';
import 'widgets/body/empty_body.dart';
import 'widgets/body/list_body.dart';
import 'widgets/bottombar/delete_bar.dart';

Future<void> saveSongs(List<SongInfo> songs) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  // SongInfo 객체 리스트를 JSON 문자열 리스트로 변환
  List<String> jsonSongs =
      songs.map((song) => json.encode(song.toJson())).toList();
  // JSON 문자열 리스트를 'songs' 키로 저장
  await prefs.setStringList('songs', jsonSongs);
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

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => UIState()),
        ChangeNotifierProvider(create: (context) => SongsState()),
      ],
      child: WhatShouldSing(),
    ),
  );
}

class WhatShouldSing extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '뭐부르지',
      debugShowCheckedModeBanner: false,
      home: KaraokeListScreen(),
    );
  }
}

class KaraokeListScreen extends StatefulWidget {
  @override
  _KaraokeListScreenState createState() => _KaraokeListScreenState();
}

class _KaraokeListScreenState extends State<KaraokeListScreen> {
  @override
  Widget build(BuildContext context) {
    final isSelectionMode = Provider.of<UIState>(context).isSelectionMode;
    final songsList = Provider.of<SongsState>(context).songsList;

    return Scaffold(
      backgroundColor: Colors.white,
      //AppBar
      appBar: MainAppbar(),
      //Body
      body: songsList.isEmpty ? EmptyBody() : ListTileBody(),
      //BottomBar
      bottomNavigationBar: isSelectionMode ? DeleteBar() : null,
      //AddButton
      floatingActionButton: isSelectionMode ? null : MainAddButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
