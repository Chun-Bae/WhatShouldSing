import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import '../models/song_info.dart';

class SongsState with ChangeNotifier {
  List<SongInfo> songsList = [];
  List<bool> checked = [];

  void setSongsList(List<SongInfo> loadedSongs) {
    songsList = loadedSongs;
    checked = List.generate(songsList.length, (index) => false);
    notifyListeners();
  }

  void addSong(SongInfo songInfo) async {
    songsList.add(songInfo);
    await saveSongs(songsList);
    notifyListeners();
  }

  void deleteSelectedItems() async {
    // 체크된 항목들을 삭제합니다.
    for (int i = checked.length - 1; i >= 0; i--) {
      if (checked[i]) {
        songsList.removeAt(i);
      }
    }
    checked = List.generate(songsList.length, (index) => false);
    await saveSongs(songsList);
    notifyListeners();
  }

  Future<void> saveSongs(List<SongInfo> songs) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    // SongInfo 객체 리스트를 JSON 문자열 리스트로 변환
    List<String> jsonSongs =
        songs.map((song) => json.encode(song.toJson())).toList();
    // JSON 문자열 리스트를 'songs' 키로 저장
    await prefs.setStringList('songs', jsonSongs);
  }
}
